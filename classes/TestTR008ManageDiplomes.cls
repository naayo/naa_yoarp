@istest
public class TestTR008ManageDiplomes {
    
    static testMethod void majDateContact(){
        
        Pays__c pays = new Pays__c();
        pays.Name = 'France';
        insert pays;
        
        NAF__c naf = new NAF__c(Name='naf',CODE_APE__c='1234');
        insert naf;
        
        Account acc = new Account(Name='test');
        acc.SIRET__c='00000000000000';
        acc.CodeAPE__c=naf.Id;
        acc.Industry='Agriculture';
        acc.CodePays__c = pays.id;
        acc.Adresse_Ville__c = 'Nantes';
        insert acc;
        
        Contact contact1= new Contact(AccountId=acc.Id,
                                      statut__c='Professionnel',
                                      FirstName='Mahmoud',
                                      LastName='BECHAA',
                                      Salutation='M',
                                      Famille_Fonction__c='Autres');
        insert contact1;
        
        Contact contact2= new Contact(AccountId=acc.Id,
                                      statut__c='Professionnel',
                                      FirstName='Pierre',
                                      LastName='DURAND',
                                      Salutation='M',
                                      Famille_Fonction__c='Autres');
        insert contact2;
        
        Dipl_me__c dipl1 = new Dipl_me__c(programme__c='MBA', 
                                          Contact__c=contact1.id,
                                          Promo_d_entr_e__c='2015',
                                          Promo_de_sortie__c='2016',
                                          Cycle__c='International MBA'
        
        );
        Dipl_me__c dipl2 = new Dipl_me__c(programme__c='ESC Lyon', 
                                          Contact__c=contact2.id,
                                          Promo_d_entr_e__c='2015',
                                          Promo_de_sortie__c='2016'
        );
        
        insert dipl1;
        insert dipl2;
        
        List<Dipl_me__c> lDipl = New List<Dipl_me__c>();
        Set<Id> sContacts = new Set<Id>();
        
        lDipl.add(dipl1);
        lDipl.add(dipl2);
        
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
        
        
         for(Contact c : lContacts){
            
            System.assertEquals(c.Date_Modification_Fiche__c, System.Date.today()) ;
            
        }
        
        
    }
    
}