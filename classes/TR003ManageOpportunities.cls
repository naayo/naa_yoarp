/*
* Implementation of methods called by triggers on opportunities and opportunity line items.
*/

global class TR003ManageOpportunities {

    public static void UpdateContact(List <Opportunity> oppList)
    {        
        List<Contact> contactsList = new List <Contact>();
        set<id> CtcCentralIds =new set<id>();
        set<Opportunity> myOpportunities =new set<Opportunity>();
        RecordType FundraisingB2C= [Select ID From RecordType Where sObjectType = 'Opportunity' And name like '%Fundraising B2C%'];
        
        for (Opportunity opp : oppList){
            CtcCentralIds.add(opp.Contact_central__c);
            
        }        
        
        if (CtcCentralIds.size()>0 ){
            contactsList = [Select a.Somme_Montant_Don__c ,a.Id From Contact a where id in: CtcCentralIds];
            myOpportunities = new set<Opportunity>([Select Contact_central__c, Amount, closeDate from Opportunity where Contact_central__c in:CtcCentralIds And stageName= 'Conclu' And recordTypeID=:FundraisingB2C.Id]);
        }

        Map<Id, Contact> mpIdContact = new Map<Id, Contact>();
        Map<Id, List<Opportunity>> mpOppByContactCentral = new Map<Id, List<Opportunity>>();
        // Parcourir chaque opportunité
        for(Opportunity o :[SELECT Contact_central__r.Id, Amount, closeDate
                            FROM Opportunity 
                            WHERE Contact_central__r.Id in:CtcCentralIds 
                            AND stageName= 'Conclu' 
                            AND recordTypeID=:FundraisingB2C.Id])
        {
            // Si son contact central n'a pas été ajouté
            if(!mpOppByContactCentral.containsKey(o.Contact_central__r.Id)) {
                // Ajouter son contact central en clé
                 mpOppByContactCentral.put(o.Contact_central__r.Id, new List<Opportunity>());
            }
            // Ajouter cette opportunité à la liste des opportunités de son contact central
            mpOppByContactCentral.get(o.Contact_central__r.Id).add(o);

            if(mpIdContact.containsKey(o.Contact_central__r.Id) != null){
                mpIdContact.put(o.Contact_central__r.Id, o.Contact_central__r);
            }
        }

        Set<Contact> sConToUpdate = new Set<Contact>();
        for(Id conId :mpOppByContactCentral.keySet()){
            Contact con = mpIdContact.get(conId);
            con.Somme_Montant_Don__c=0;
            for(Opportunity o :mpOppByContactCentral.get(conId)){
                if(Date.today() <= o.closeDate.addYears(Integer.valueof(Label.x.trim())))
                {
                    con.Somme_Montant_Don__c += o.Amount;
                }    
                if (!sConToUpdate.contains(con)) {
                    sConToUpdate.add(mpIdContact.get(conId));                
                }
            }
        }
                
        Map<Id,Contact> mpConToUpdate = new Map<Id,Contact>();
        mpConToUpdate.putAll(new List<Contact>(sConToUpdate));

        if (mpConToUpdate.size()>0){
            update mpConToUpdate.values();
        }
    }

    public static void UpdateOppsNumber(Set<Id> idContacts){

        // Va servir à forcer la màj lorsque l'on rencontre des suspiscions de doublons Nom/prénom
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true;

        // Récupération des critères de comptabilisation
        Set<String> statusEnCours = new Set<String>(Label.OpportunityCriteria.split(';',-1));
        Set<String> statusConseillers = new Set<String>(Label.OpportunityCriteriaSansIP.split(';',-1));

        // Détermination de l'exercice actuel
        Date endExerciceDate = Date.newinstance(System.Today().year(), 8, 31);
        Date actualDate = Date.today();
        Integer actualExercice = 0;
        if(actualDate>endExerciceDate){
            actualExercice = actualDate.year() + 1;
        }else{
            actualExercice = actualDate.year();
        }

        // Récupération du nombre d'opp par contact central par statut d'opportunité par exercice
        List<AggregateResult> ctcCentralByStage = [SELECT Contact_central__c, StageName, Exercice__c, Count(Id) 
                                                    FROM Opportunity
                                                    WHERE Contact_central__c IN :idContacts
                                                    GROUP BY Contact_central__c, StageName, Exercice__c
                                                    ORDER BY Contact_central__c];
        
        Map<Id,Contact> mapIdCon = new Map<Id,Contact>();
        for (AggregateResult aggregateResult : ctcCentralByStage){
            Id conId = (Id)aggregateResult.get('Contact_central__c');
            // Gestion du contact traité précedemment
            if(!mapIdCon.containsKey(conId)){
                mapIdCon.put(conId,new Contact(Id=conId,
                                               Nombre_opportunit_s__c='0',
                                               Nombre_opportunites_sur_criteres__c='0',
                                               nb_SIP_en_cours__c=0));
            }
            Contact lastCtc = mapIdCon.get(conId);
            
            // Calcul du compteur d'opp total
            lastCtc.Nombre_opportunit_s__c = String.valueOf(
                    Integer.valueOf(lastCtc.Nombre_opportunit_s__c)
                +   Integer.valueOf(aggregateResult.get('expr0'))
            );
            
            // Calcul du compteur d'opp en cours sur l'exercice en cours
            if(statusEnCours.contains(String.valueOf(aggregateResult.get('StageName'))) 
                && Integer.valueOf(aggregateResult.get('Exercice__c')) == actualExercice){
                lastCtc.Nombre_opportunites_sur_criteres__c = String.valueOf(
                        Integer.valueOf(aggregateResult.get('expr0'))
                    +   Integer.valueOf(lastCtc.Nombre_opportunites_sur_criteres__c)
                ); 
            }
            
            // Calcul du compteur d'opp conseillers sur l'exercice en cours
            if(statusConseillers.contains(String.valueOf(aggregateResult.get('StageName'))) 
                && Integer.valueOf(aggregateResult.get('Exercice__c')) == actualExercice)
            {
                lastCtc.nb_SIP_en_cours__c += Integer.valueOf(aggregateResult.get('expr0'));
            } 
        }
        
        // Modification des contacts
        Database.SaveResult[] sr = Database.update(mapIdCon.values(), dml);
    }
    
    public static void createContactRole(List<Opportunity> opportunities) {
        List<OpportunityContactRole> roles = new List<OpportunityContactRole>();
        for (Opportunity opp: opportunities){
            roles.add(
                new OpportunityContactRole(
                    ContactId = opp.Contact_central__c,
                    IsPrimary = true,
                    OpportunityId = opp.id,
                    Role = 'Contact central'
                    )
                );
        }
        if(roles.size()>0){
            insert roles;
        }
    }    
    
    public static void checkOwnerIdChange(List<Opportunity> lOpp, String oldOwnerId){
        Profile p = [Select id, Name from Profile where Id =: userinfo.getProfileid() limit 1];  
        User currentUser = [Select ProfileId, UserRole.Id from User where Id =:userinfo.getUserId() limit 1 ]; 
        Opportunity currentOpp = lOpp[0];
        Set<ID> OwnerIdSet = new Set<ID>();
        
         for(Opportunity o:lOpp){
             OwnerIdSet.add(o.OwnerId);
         }
        
        Map<Id, Group> groupMap = new Map<Id, Group>([
            Select Id, Name
            From Group
            Where Name = 'Administrateurs Opportunités'
            ]);
        
        Map<Id, GroupMember> groupAdminOpp = New Map<Id, GroupMember>([
            Select  Id, UserOrGroupId
            From GroupMember
            Where GroupId In :groupMap.keySet() and UserOrGroupId  =: currentUser.Id
            ]);
        
        // si l'utilisateur actuel est dans le groupe Administrateurs Opportunités
        // ou si l'utilisateur actuel est dans le profil administrateur ou interface
        // on ne fait rien
        if(groupAdminOpp.size()>0 || p.Name=='Administrateur système' || p.Name =='Interface'){

            return;
            }else {                
                 User newOwner = [Select ProfileId, UserRole.Id from User where Id =:OwnerIdSet limit 1]; 
                 User oldOwner = [select id, UserRole.id from User where id=: oldOwnerId limit 1] ;            

                for(Opportunity o:lOpp){
                    // cette partie de trigger n'est utilisé que lorsque l'on est en mode saisie manuelle
                    // elle ne s'exécute pas pour les traitements en rafale constitués d'un tableau
                    // d'enregistrements
                    if (newOwner.UserRole.id != oldOwner.UserRole.id ) {  
                        o.Adderror('le propriétaire actuel de l\'opportunité  et le nouveau propriétaire doivent avoir le même rôle !');
                        return;
                    }
                    
                    if(newOwner.UserRole.id != currentUser.UserRole.Id){

                        o.Adderror('Vous ne pouvez pas réaffecter une opportunité qui n\'est pas dans votre pôle !');
                        return;
                    }
                
           }
        }
    }    
    
    // 20150212_ABO: Nouveau traitement d'assignation de suiveur à une opportunité.
    // Déclenché en after insert sur OpportunityLineItem
    public static void AssignOwnerToOppty(Map<Id,OpportunityLineItem> newopplines){       
        // Liste des opportunités dont le suiveur est à assigner (i.e. qui ont un InterfaceExternalId__c non nul):
        List<Opportunity> opptyListToUpdate = [Select Id, OwnerId, Contact_central__c, RecordtypeId FROM Opportunity
        Where Id in (Select OpportunityId FROM OpportunityLineItem Where Id = : newopplines.keySet())
        And InterfaceExternalId__c <> null];
        
        // VBO ajout d'un filtre sur le type d'ernegistremenet pour garder le cas 1 uniquement pour formation initiale
        RecordType fi = [Select ID From RecordType Where sObjectType = 'Opportunity' And name like 'Formation initiale'];
        
        if (!opptyListToUpdate.isEmpty()) {
            // Ensemble des id de contacts centraux
            Set<Id> contactIds = new Set<Id>();
            // Ensemble des id des opportunit? ? traiter
            Set<Id> opptyToUpdateIds = new Set<Id>();
            for (Opportunity oppty : opptyListToUpdate) {
                opptyToUpdateIds.add(oppty.Id);
                if (oppty.Contact_central__c != null)
                contactIds.add(oppty.Contact_central__c);
            }
            
            // Map associant un id d'opportunité à un id de ligne d'opportunité (pour la gestion d'erreur)
            Map<Id,OpportunityLineItem> opptyLineByOpptyId = new Map<Id,OpportunityLineItem>();
            // Map associant un id d'opportunit? ? l'id de son produit
            Map<Id, Id> productIdByOpptyId = new Map<Id, Id>();
            for (OpportunityLineItem opptyLine : newopplines.values()) {
                productIdByOpptyId.put(opptyLine.OpportunityId, opptyLine.Product2Id);
                opptyLineByOpptyId.put(opptyLine.OpportunityId, opptyLine);
            }
            
            // Map des produits associés
            Map<Id, Product2> productMap = new Map<Id, Product2>([Select Id, Suiveur__c FROM Product2 Where Id in : productIdByOpptyId.values()]);
            
            // Liste des opportunités associ?es aux mêmes contacts centraux (les opportunités actuellement à traiter sont exclues).
            List<Opportunity> relatedOpptyList = [Select Id, OwnerId, Contact_central__c FROM Opportunity
            Where Contact_central__c in : contactIds
            /*And Id not in : opptyToUpdateIds*/
            Order by Date_de_mise__c asc];
            // Map associant un id de contact avec sa premi?re opportunit?
            Map<Id, Opportunity> firstOpptyByContactId = new Map<Id, Opportunity>();
            for (Opportunity oppty : relatedOpptyList) {
                if (!firstOpptyByContactId.containsKey(oppty.Contact_central__c)) {
                    firstOpptyByContactId.put(oppty.Contact_central__c, oppty);
                }
            }
            
            // Mise à jour du suiveur (i.e. le owner) des opportunités à traiter
            for (Opportunity oppty : opptyListToUpdate) {
                // Cas 1 : Il existe une autre opportunit? pour ce même contact central
                if (oppty.Contact_central__c!=null
                    && firstOpptyByContactId.containsKey(oppty.Contact_central__c)
                    && firstOpptyByContactId.get(oppty.Contact_central__c).Id != oppty.Id && oppty.RecordTypeId == fi.id) {
                        // => On affecte le suiveur de la premi?re opportunit?
                        oppty.OwnerId = firstOpptyByContactId.get(oppty.Contact_central__c).OwnerId;
                } else {
                // Cas 2 : Il n'existe pas d'autre opportunité pour ce m?me contact central VBO ou si on est pas formation initiale
                // => On affecte le suiveur du produit
                Id productId = productIdByOpptyId.get(oppty.Id);
                Product2 p = productMap.get(productId);
                oppty.OwnerId = p.Suiveur__c;
                }
            }

            try {
                update opptyListToUpdate;
            }catch (System.DMLException e) {
                Boolean errorLogged = false;
                for (Integer i=0; i<e.getNumDml();i++) {
                    Id opptyId = e.getDmlId(i);
                    if (opptyLineByOpptyId.containsKey(opptyId)) {
                        opptyLineByOpptyId.get(opptyId).addError(e.getDmlMessage(i));
                        errorLogged = true;
                    }
                }

                if (!errorLogged)
                    throw e;
            }
        }   
    }
}