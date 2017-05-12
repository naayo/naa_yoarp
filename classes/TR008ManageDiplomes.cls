/* 
* Modifié par Tom CHAMART - MODIS
* Le 16/02/2017
*/
public class TR008ManageDiplomes {  
    // -------Initialiser les champs Nombre_de_contacts_dipl_m_s__c et Nombre_de_contacts_dipl_m_s_groupe__c à 0
    public static void initFields(List<Account> accs){
        // Parcourir les comptes et initialiser les deux compteurs à 0
        List<Account> accsToUpdate = new List<Account>();
        for (Account acc :accs)  {
            accsToUpdate.add(new Account(
                Id = acc.Id,
                Nombre_de_contacts_dipl_m_s__c = 0,
                Nombre_de_contacts_dipl_m_s_groupe__c = 0
            ));
        }
        
        // MàJ les comptes en base
        if(accsToUpdate.size()>0) 
        {
            update accsToUpdate;
        }
    }
    
    // -------Mettre à jour toutes les données de diplômés de compte depuis des contacts
    public static void updateDiplomesOfContacts(List<Contact> lCtc){
        Set<Id> sAcctIds = new Set<Id>(); // Set contenant les Ids des comptes concernés par la modification
        
        // Récupérer les Ids des comptes concernés par le changement dans un set pour l'unicité
        for(Contact ctc : lCtc){
            if(ctc.AccountId != null){
                sAcctIds.add(ctc.AccountId); 
            }    
        }
        
        // Mettre à jour le nombre de diplomés de chaque compte
        updateAccounts(sAcctIds);
        
        // Mettre à jour le nombre de diplômés du groupe de chaque compte
        updateGroupOfAccounts(sAcctIds);     
    }
    
    // -------Mettre à jour toutes les données de diplômés de compte depuis des comptes
    public static void updateDiplomesOfAccounts(List<Id> lAccIds){
        
        // Mettre à jour le nombre de diplomés de chaque compte
        updateAccounts(new Set<Id>(lAccIds));
        
        // Mettre à jour le nombre de diplômés du groupe de chaque compte
        updateGroupOfAccounts(new Set<Id>(lAccIds));        
    }
    
    // -------Mettre à jour le nombre de diplomés de chaque compte
    public static void updateAccounts(Set<Id> sAcctIds){
        List<Account> accsToUpdate = new List<Account>();
        
        // By-passer les règles de duplications
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true;
        
        // Récuperer le nombre de diplômés par compte
        List<Account> accs = [
            SELECT  Id,
            (SELECT Id FROM Contacts WHERE Identifiant_dipl_m__c != null)
            FROM    Account
            WHERE   Id IN :sAcctIds
        ];
        
        // MàJ le nombre de diplômés de chaque compte 
        for (Account acc :accs)  {
            accsToUpdate.add(new Account(
                Id = acc.Id,
                Nombre_de_contacts_dipl_m_s__c = acc.contacts.size()
            ));
        }
        
        // MàJ les comptes en base
        if(accsToUpdate.size()>0) 
        {
            update accsToUpdate;
        }
    }    
    
    
    
    // -------Mettre à jour le nombre de diplomés du groupe de chaque compte
    public static void updateGroupOfAccounts(Set<Id> sAcctIds){        
        // By-passer les règles de duplications
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = true;
        
        // Liste des comptes concernés 
        List<Account> lAcct = [SELECT ComptePrincipal__c, ComptePrincipal__r.Nombre_de_contacts_dipl_m_s__c,
                               Id, Nombre_de_contacts_dipl_m_s__c 
                               FROM Account 
                               WHERE Id IN :sAcctIds];
        
        // Set d'id des comptes principaux concernés
        Set<Id> sPrincipalIds = new Set<Id>();
        // Parcourir tous les comptes concernés
        for(Account acc :lAcct){
            // Si le compte est un compte principal
            if(acc.ComptePrincipal__c == null){
                // Ajouter l'id du compte au set des comptes principaux concernés
                sPrincipalIds.add(acc.Id);
            }else{
                // Ajouter l'id de son compte principal au set des comptes principaux concernés
                sPrincipalIds.add(acc.ComptePrincipal__c);
            }
        }
        
        // Map des comptes filiales d'un compte principal
        Map<Id, List<Account>> mpAcctIdChildsList = new Map<Id, List<Account>>();
        // Parcourir chaque compte filiale
        for(Account acc : [SELECT Id, ComptePrincipal__c, Nombre_de_contacts_dipl_m_s__c
                           FROM Account
                           WHERE ComptePrincipal__c IN :sPrincipalIds]){
                               // Si son compte principal n'a pas été ajouté
                               if(!mpAcctIdChildsList.containsKey(acc.ComptePrincipal__c)) {
                                   // Ajouter l'id de son compte principal en clé
                                   mpAcctIdChildsList.put(acc.ComptePrincipal__c, new List<Account>());
                               }
                               // Ajouter ce compte à la liste des enfants de son compte principal
                               mpAcctIdChildsList.get(acc.ComptePrincipal__c).add(acc);            
                           }
        
        // Map de la somme des NbDiplomes des filiales d'un compte principal
        Map<Id,Integer> mpNbDiplomesInParent = new Map<Id,Integer>();
        Integer nbDiplomesInParent = 0;
        // Parcourir chaque compte principal
        for(Id parentId :mpAcctIdChildsList.keySet())
        {
            nbDiplomesInParent = 0;
            // Parcourir chaque filiale du compte principal
            for(Account accChild :mpAcctIdChildsList.get(parentId))
            {
                // Calculer la somme du nombre de diplomés au sein des filiales
                nbDiplomesInParent += (Integer)accChild.Nombre_de_contacts_dipl_m_s__c;
            }
            // Alimenter la map de la somme des NbDiplomes des filiales d'un compte principal
            mpNbDiplomesInParent.put(parentId, nbDiplomesInParent);
        }  
        
        // Map du NbDiplome d'un compte principal
        Map<Id,Integer> mpNbDiplomesByParent = new Map<Id,Integer>();
        // Parcourir tous les comptes concernés
        for(Account acc :lAcct){
            // Si le compte est un compte principal
            if(acc.ComptePrincipal__c == null){
				// Ajouter l'id du compte principal et son nombre de diplômés
				mpNbDiplomesByParent.put(acc.Id, (Integer)acc.Nombre_de_contacts_dipl_m_s__c);
            }else{
				// Ajouter l'id du compte principal et son nombre de diplômés
				mpNbDiplomesByParent.put(acc.ComptePrincipal__c, (Integer)acc.ComptePrincipal__r.Nombre_de_contacts_dipl_m_s__c);
            }
        }
        
        // MàJ le nombre de diplomés du groupe des comptes
        Integer nbGroupe = 0; 
        List<Account> accsToUpdate = new List<Account>();
        for(Id parentId :mpNbDiplomesInParent.keySet()){
            // Calculer le nombre de diplômés du groupe (somme des filiales + nb du compte principal)
            nbGroupe = mpNbDiplomesInParent.get(parentId) + mpNbDiplomesByParent.get(parentId);
            // MàJ le nombre de diplômés du groupe des comptes principaux
            accsToUpdate.add(new Account(
                Id = parentId,
                Nombre_de_contacts_dipl_m_s_groupe__c = nbGroupe
            ));
                        
            // MàJ le nombre de diplômés du groupe de chaque filiale du compte principal
            // Parcourir tous les comptes filiales concernés
            for(Account acc :mpAcctIdChildsList.get(parentId)){
                // MàJ le nombre de diplômés du groupe de cette filiale du compte principal 
                accsToUpdate.add(new Account(
                    Id = acc.Id,
                    Nombre_de_contacts_dipl_m_s_groupe__c = nbGroupe
                )); 
            }
            
        }
        
        // MàJ les comptes en base
        if(accsToUpdate.size()>0)  
        {
            Database.update(accsToUpdate,dml);
        }
    }
    
    // Fait par Mahmoud BECHAA
    public static void majDateContact(Set<Id> mDipl){
        
        // on va récupérer pour ces enregistrements l'id du contact associé
        // et on le stocke dans une liste
        List<Dipl_me__c> lDipl = [select id, Contact__c from Dipl_me__c where id in : mDipl];
        Set<Id> sContacts = new Set<Id>();
        
        // on initialise un tableau d'id des contacts dans lequel on stocke tous les contacts
        // auquel a été ajouté ou modifié un diplôme
        for(Dipl_me__c d : lDipl){
            
            sContacts.add(d.Contact__c);
            
        }
        
        // on parcours les contacts associés à chaque diplôme 
        // et on met à jour la date de modification avec la date du jour.
        List<Contact> lContacts = [select id, Date_Modification_Fiche__c  from contact where id in : sContacts];
        
        for(Contact c : lContacts){
            
            c.Date_Modification_Fiche__c = System.Date.today();
            
        }
        
        update lContacts;
        
    }
}