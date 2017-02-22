public class TR008ManageDiplomes {
    
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