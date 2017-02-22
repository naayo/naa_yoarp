/*s
* Implementation of methods called by triggers on opportunities and opportunity line items.
*/

global class TR003ManageOpportunities {
    
    public static void UpdateContact(List <Opportunity> oppList)
    {
        List<Contact> contactsList = new List <Contact>();
        set<id> oppIds =new set<id>();
        set<Opportunity> myOpportunities =new set<Opportunity>();
        RecordType FundraisingB2C= [Select ID From RecordType Where sObjectType = 'Opportunity' And name like '%Fundraising B2C%'];
        
        for (Opportunity opp : oppList){
            oppIds.add(opp.Contact_central__c);
            
        }
        
        if (oppIds.size()>0 ){
            contactsList = [Select a.Somme_Montant_Don__c ,a.Id From Contact a where id in: oppIds];
            myOpportunities = new set<Opportunity>([Select Contact_central__c, Amount, closeDate from Opportunity where Contact_central__c in:oppIds And stageName= 'Conclu' And recordTypeID=:FundraisingB2C.Id]);
        }
        
        for (Contact con : contactsList)
        {
            con.Somme_Montant_Don__c=0;
            for(Opportunity o : myOpportunities ){
                if(o.Contact_central__c==con.Id && Date.today()<=o.closeDate.addYears(Integer.valueof(Label.x.trim()))) con.Somme_Montant_Don__c +=o.Amount;
            }
            
        }
        
        if (contactsList.size()>0)update contactsList;
        
        //Executer un batch pour palier la limite CPU
        //BatchOpportunityUpdateContact batch = new BatchOpportunityUpdateContact(oppList);
        //Database.executeBatch(batch);
    }
    public static void UpdateOppsNumber(Set<Id> idContacts){
        
        // va servir à forcer la màj lorsque l'on rencontre des suspiscions de doublons Nom/prénom
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.AllowSave = true; 
        
        List<Contact> contacts = [Select a.Id, a.Nombre_opportunit_s__c From Contact a where a.Id in :idContacts];
        List<Opportunity> opportunities = [Select o.Id, o.Contact_central__c, o.StageName From Opportunity o where o.Contact_central__c  in : idContacts];
        String Criteria = Label.OpportunityCriteria;
        String CriteriaSansIP = Label.OpportunityCriteriaSansIP;
        Set<String> status = new Set<String>(Criteria.split(';',-1));
        Set<String> statusSansIP = new Set<String>(CriteriaSansIP.split(';',-1));
        for(Contact cont : contacts){
            Integer nbre=0;
            Integer nbreCriteria=0;
            Integer nbreQualifSansIP=0;// Nombre d'opportunit? qualifi? (sans "int?ress? par")
            for(Opportunity opp : opportunities){
                if(opp.Contact_central__c ==cont.Id){
                    nbre++;
                    if(status.contains(opp.StageName)){
                        nbreCriteria++;
                    }
                    if (statusSansIP.contains(opp.StageName)) {
                        nbreQualifSansIP++;
                    }
                }
            }
            cont.Nombre_opportunit_s__c=string.ValueOf(nbre);
            cont.Nombre_opportunites_sur_criteres__c=string.ValueOf(nbreCriteria);
            cont.nb_SIP_en_cours__c=nbreQualifSansIP;
        }
        
        Database.SaveResult[] sr = Database.update(contacts, dml); 
        
        update contacts;
        
        //Executer un batch pour palier la limite CPU
        //BatchOpportunityUpdateOppsNumber batch = new BatchOpportunityUpdateOppsNumber(idContacts);
        //Database.executeBatch(batch);
        
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
        }
        
        else {
            
            for(Opportunity o:lOpp){
                
                // cette partie de trigger n'est utilisé que lorsque l'on est en mode saisie manuelle
                // elle ne s'exécute pas pour les traitements en rafale constitués d'un tableau
                // d'enregistrements
                User newOwner = [Select ProfileId, UserRole.Id from User where Id =:o.OwnerId limit 1]; 
                //Profile p2 = [Select Name from Profile where Id =: newOwner.ProfileId limit 1];  
    
                {              
                    
                    User oldOwner = [select id, UserRole.id from User where id=: oldOwnerId limit 1] ;
              
                    
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
        system.debug('###### Id du record type formation initiale : '+ fi);
        
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
                
            } catch (System.DMLException e) {
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