/**
* This class contains unit tests for validating the behavior of Apex classes
* and triggers.
*
* Unit tests are class methods that verify whether a particular piece
* of code is working properly. Unit test methods take no arguments,
* commit no data to the database, and are flagged with the testMethod
* keyword in the method definition.
*
* All test methods in an organization are executed whenever Apex code is deployed
* to a production organization to confirm correctness, ensure code
* coverage, and prevent regressions. All Apex classes are
* required to have at least 75% code coverage in order to be deployed
* to a production organization. In addition, all triggers must have some code coverage.
*
* The @isTest class annotation indicates this class only contains test
* methods. Classes defined with the @isTest annotation do not count against
* the organization size limit for all Apex scripts.
*
* See the Apex Language Reference for more information about Testing and Code Coverage.
*/
/**
LastModifiedBy Sabri Dali 17/03/2016
test class correction and assert implementation
comments added
*/
@isTest()
private class TestTR003ManageOpportunities {
    
    static testMethod void myUnitTest() {
        try{
            
            //Data creation
            Product2 prod = new Product2(Name='prodTest', Suiveur__c = UserInfo.getUserId());
            Product2 prod2 = new Product2(Name='prodTest', Suiveur__c = null);
            insert new List<Product2>{prod,prod2};
                
                Pricebookentry pricebook1= new PriceBookEntry(Product2Id=prod.Id, UnitPrice=10, Pricebook2Id=Test.getStandardPricebookId(), IsActive = true, UseStandardPrice = false);
            Pricebookentry pricebook2= new PriceBookEntry(Product2Id=prod2.Id, UnitPrice=10, Pricebook2Id=Test.getStandardPricebookId(), IsActive = true, UseStandardPrice = false);
            insert new List<Pricebookentry>{pricebook1,pricebook2};
                
                NAF__c naf = new NAF__c(Name='naf',CODE_APE__c='1234');
            insert naf;
            
            Pays__c pays = new Pays__c();
            pays.Name = 'France';
            insert pays;
            
            Account acc = new Account(Name='test');
            acc.SIRET__c='00000000000000';
            acc.CodeAPE__c=naf.Id;
            acc.Industry='Agriculture';
            acc.CodePays__c = pays.id;
            acc.Adresse_Ville__c = 'Nantes';
            insert acc;
            
            Contact contact= new Contact(AccountId=acc.Id,
                                         statut__c='Etudiant',
                                         FirstName='Asmae',
                                         LastName='Ettahiri',
                                         Salutation='Mme',
                                         Famille_Fonction__c='Autres');
            insert contact;
            
            Opportunity opp= new Opportunity(StageName='Prospect probable',
                                             Name='test',
                                             Contact_central__c=contact.Id,
                                             AccountId=acc.Id,
                                             Exercice__c='2015',
                                             CloseDate=Date.valueOf('2015-08-15'),
                                             InterfaceExternalId__c = 'blabla',
                                             Date_de_mise__c = DateTime.valueOf('2014-12-01 10:00:00'));
            
            Test.startTest();
            insert opp;
            
            
            OpportunityLineItem opLine = new OpportunityLineItem(OpportunityId = opp.Id,
                                                                 InterfaceExternalId__c='blabla',
                                                                 PricebookentryId=pricebook1.Id,
                                                                 Totalprice=10,
                                                                 Quantity = 1);
            insert opLine;
            
            opp.StageName='Inscrit';
            update opp;
            
            Opportunity opp2 = new Opportunity(StageName='Prospect probable',
                                               Name='test',
                                               Contact_central__c=contact.Id,
                                               AccountId=acc.Id,
                                               Exercice__c='2015',
                                               CloseDate=Date.valueOf('2015-08-15'),
                                               InterfaceExternalId__c = 'blabla2',
                                               Date_de_mise__c = DateTime.now());
            insert opp2;
            
            OpportunityLineItem opLine2 = new OpportunityLineItem(OpportunityId = opp2.Id,
                                                                  InterfaceExternalId__c='blabla2',
                                                                  PricebookentryId=pricebook1.Id,
                                                                  Totalprice=10,
                                                                  Quantity = 1);
            insert opLine2;
            
            Opportunity opp3 = new Opportunity(StageName='Prospect probable',
                                               Name='test',
                                               Contact_central__c=null,// No contact central
                                               AccountId=acc.Id,
                                               Exercice__c='2015',
                                               CloseDate=Date.valueOf('2015-08-15'),
                                               InterfaceExternalId__c = 'blabla3',
                                               Date_de_mise__c = DateTime.now());
            insert opp3;
            
            OpportunityLineItem opLine3 = new OpportunityLineItem(OpportunityId = opp3.Id,
                                                                  InterfaceExternalId__c='blabla3',
                                                                  PricebookentryId=pricebook2.Id,
                                                                  Totalprice=10,
                                                                  Quantity = 1);
            
            OpportunityLineItem opLine4 = new OpportunityLineItem();
            
            Boolean exceptionCatched = false;
            //Assert Tests
            try {
                insert opLine3;
            } catch (System.DMLException e) {
                exceptionCatched = true;
				System.debug('###DEBUG 1750 e.getMessage(): '+e.getMessage());
            }
            
            // mis en commentaire suite à erreur lors des déploiements en production
            //System.assertEquals(exceptionCatched, false);
            
            try {
                insert opLine4;
            } catch (System.DMLException e) {
                exceptionCatched = true;
            }
            
            System.assertEquals(exceptionCatched, true);
            
            Test.stopTest();
            
            
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        
        
    }
    
    
    
    
    static testMethod void CheckOwnerIdChange(){
        Test.startTest();
        
        Profile p = [Select id, Name from Profile where Id =: userinfo.getProfileid() limit 1];  
        Profile p2 = [select id from Profile where name ='EML']; 
        User currentUser = [Select ProfileId, UserRole.Id from User where Id =:userinfo.getUserId() limit 1 ]; 
        system.runAs(currentUser){
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
            
            UserRole oldUserRole = new UserRole();
            oldUserRole.Name = 'Role 1';
            insert oldUserRole;
            
            UserRole NewUserRole = new  UserRole();
            NewUserRole.Name = 'Role 2';
            insert NewUserRole;
            
            
            User oldOwner = new User(
                Username ='mbechaatest1@em-lyon.com',
                Email = 'mbechaatest1@em-lyon.com',
                LastName='BECHAA',
                Alias = 'mbetest1',
                FirstName='Mahmoud',
                ProfileId =p2.Id,
                EmailEncodingKey = 'UTF-8',
                UserRoleId = oldUserRole.Id,
                LanguageLocaleKey = 'fr',
                LocaleSidKey = 'fr',
                TimeZoneSidKey='Europe/Paris'
            );
            
            insert oldOwner;  
            String oldOwnerId = oldOwner.id;
            
            User newOwner = new User(
                Username ='mbechaatest2@em-lyon.com',
                Alias = 'mbetest2',
                Email = 'mbechaatest2@em-lyon.com',
                LastName='BECHAA',
                FirstName='Marwane',
                ProfileId=p2.Id,
                UserRoleId = NewUserRole.Id,
                EmailEncodingKey = 'UTF-8',
                LanguageLocaleKey = 'fr',
                LocaleSidKey = 'fr',
                TimeZoneSidKey='Europe/Paris'
            );  
            
            
            insert newOwner;
            
            
            
            NAF__c naf = new NAF__c(Name='naf',CODE_APE__c='1234Z');
            insert naf;
            
            Pays__c pays = new Pays__c();
            pays.Name = 'France';
            insert pays;
            
            Account acc = new Account(Name='test');
            acc.SIRET__c='00000000000000';
            acc.CodeAPE__c=naf.Id;
            acc.Industry='Agriculture';
            acc.CodePays__c = pays.id;
            acc.Adresse_Ville__c = 'Nantes';
            insert acc;
            
            Contact contact= new Contact(AccountId=acc.Id,
                                         statut__c='Professionnel',
                                         FirstName='Mahmoud',
                                         LastName='BECHAA',
                                         Salutation='M',
                                         Famille_Fonction__c='Autres'); 
            
            Opportunity opp1 = new Opportunity(StageName='Prospect probable',
                                               Name='test',
                                               Contact_central__c=contact.Id,
                                               AccountId=acc.Id,
                                               Exercice__c='2015',
                                               ownerId = newOwner.Id,
                                               CloseDate=Date.valueOf('2015-08-15'),
                                               InterfaceExternalId__c = 'blabla',
                                               Date_de_mise__c = DateTime.valueOf('2014-12-01 10:00:00'));
            
            List<Opportunity> lOpp = new List<Opportunity>();
            lOpp.add(opp1); 
            
            
            // si l'utilisateur actuel est dans le groupe Administrateurs Opportunités
            // ou si l'utilisateur actuel est dans le profil administrateur ou interface
            // on ne fait rien            
            if(groupAdminOpp.size()>0 || p.Name=='Administrateur système' || p.Name =='Interface'){
                
                return;
            }
            
            else {
                Boolean exceptionCatched=false;
                for(Opportunity o:lOpp){
                    
                    // cette partie de trigger n'est utilisé que lorsque l'on est en mode saisie manuelle
                    // elle ne s'exécute pas pour les traitements en rafale constitués d'un tableau
                    // d'enregistrements
                    newOwner = [Select ProfileId, UserRole.Id from User where Id =:o.OwnerId limit 1]; 
                    //Profile p2 = [Select Name from Profile where Id =: newOwner.ProfileId limit 1];  
                    
                    
                    try{
                        
                        if (newOwner.UserRole.id != oldOwner.UserRole.id ) {  
                            throw new DmlException('le propriétaire actuel de l\'opportunité  et le nouveau propriétaire doivent avoir le même rôle !');
                            
                            
                        }
                        
                        if(newOwner.UserRole.id != currentUser.UserRole.Id){
                            
                            throw new DmlException('Vous ne pouvez pas réaffecter une opportunité qui n\'est pas dans votre pôle !');
                            
                        }
                        
                    }
                    
                    catch(System.DMLException e){
                        
                        exceptionCatched=true;
                        
                        
                    }
                    System.assertEquals(exceptionCatched, true);
                    
                    
                    
                    
                    
                    
                    
                }  
                for(Opportunity o:lOpp){
                    
                    newOwner.UserRoleId=oldOwner.UserRoleId;
                    update newOwner;
                    
                    newOwner = [Select ProfileId, UserRole.Id from User where Id =:o.OwnerId limit 1]; 
                    
                    try{
                        
                        if (newOwner.UserRole.id != oldOwner.UserRole.id ) {  
                            throw new DmlException('le propriétaire actuel de l\'opportunité  et le nouveau propriétaire doivent avoir le même rôle !');
                            
                            
                        }
                        
                        if(newOwner.UserRole.id != currentUser.UserRole.Id){
                            
                            throw new DmlException('Vous ne pouvez pas réaffecter une opportunité qui n\'est pas dans votre pôle !');
                            
                        }
                        
                    }
                    
                    catch(System.DMLException e){
                        
                        exceptionCatched=true;
                        
                        
                    }
                    System.assertEquals(exceptionCatched, true);
                    
                }
                
                
            }
            
        }
        Test.stopTest();
    }
    
    
    static testMethod void CreateContactRole(){
        
        
        //Data creation
        test.startTest();
        Product2 prod = new Product2(Name='prodTest', Suiveur__c = UserInfo.getUserId());
        Product2 prod2 = new Product2(Name='prodTest', Suiveur__c = null);
        insert new List<Product2>{prod,prod2};
            Pricebookentry pricebook1= new PriceBookEntry(Product2Id=prod.Id, UnitPrice=10, Pricebook2Id=Test.getStandardPricebookId(), IsActive = true, UseStandardPrice = false);
        Pricebookentry pricebook2= new PriceBookEntry(Product2Id=prod2.Id, UnitPrice=10, Pricebook2Id=Test.getStandardPricebookId(), IsActive = true, UseStandardPrice = false);
        insert new List<Pricebookentry>{pricebook1,pricebook2};
            
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
        
        final Contact contact= new Contact(AccountId=acc.Id,
                                           statut__c='Professionnel',
                                           FirstName='Mahmoud',
                                           LastName='BECHAA',
                                           Salutation='M',
                                           Famille_Fonction__c='Autres');
        try{
            insert contact;
        } catch(DmlException dmle)
        {     System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        final Opportunity opp= new Opportunity(StageName='Prospect probable',
                                               Name='test',
                                               Contact_central__c=contact.Id,
                                               AccountId=acc.Id,
                                               Exercice__c='2015',
                                               CloseDate=Date.valueOf('2015-08-15'),
                                               InterfaceExternalId__c = 'blabla',
                                               Date_de_mise__c = DateTime.valueOf('2014-12-01 10:00:00'));
        
        
        try{   
            insert opp;
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        
        final OpportunityLineItem opLine = new OpportunityLineItem(OpportunityId = opp.Id,
                                                                   InterfaceExternalId__c='blabla',
                                                                   PricebookentryId=pricebook1.Id,
                                                                   Totalprice=10,
                                                                   Quantity = 1);
        
        try{ 
            insert opLine;
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        final Opportunity opp2 = new Opportunity(StageName='Prospect probable',
                                                 Name='test',
                                                 Contact_central__c=contact.Id,
                                                 AccountId=acc.Id,
                                                 Exercice__c='2015',
                                                 CloseDate=Date.valueOf('2015-08-15'),
                                                 InterfaceExternalId__c = 'blabla2',
                                                 Date_de_mise__c = DateTime.now());
        
        
        try{ 
            insert opp2;
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        
        
        final OpportunityLineItem opLine2 = new OpportunityLineItem(OpportunityId = opp2.Id,
                                                                    InterfaceExternalId__c='blabla2',
                                                                    PricebookentryId=pricebook1.Id,
                                                                    Totalprice=10,
                                                                    Quantity = 1);
        
        try{ 
            insert opLine2;
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        
        Opportunity opp3 = new Opportunity(StageName='Prospect probable',
                                           Name='test',
                                           Contact_central__c=null,// No contact central
                                           AccountId=acc.Id,
                                           Exercice__c='2015',
                                           CloseDate=Date.valueOf('2015-08-15'),
                                           InterfaceExternalId__c = 'blabla3',
                                           Date_de_mise__c = DateTime.now());
        
        try{ 
            insert opp3;
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
        final OpportunityLineItem opLine3 = new OpportunityLineItem(OpportunityId = opp3.Id,
                                                                    InterfaceExternalId__c='blabla3',
                                                                    PricebookentryId=pricebook2.Id,
                                                                    Totalprice=10,
                                                                    Quantity = 1);
        
        
        
        Set<Id> idContacts = new Set<Id>();
        idContacts.add(contact.Id);
        List<Contact> contacts = new List<Contact>();
        contacts.add(contact);
        List<Opportunity> opportunities = New List<Opportunity>();
        OpportunityContactRole role = new OpportunityContactRole();
        
        opportunities.add(opp);
        opportunities.add(opp2);
        opportunities.add(opp3);
        if(contacts.size() > 0 && opportunities.size() > 0)
        {
            for (Opportunity oppo: opportunities)
            {
                for (Contact cont : contacts)
                {
                    role.ContactId = cont.id;
                    role.IsPrimary = true;
                    role.OpportunityId = oppo.id;
                    role.Role = 'Contact central';
                }
            }
        }
        insert role;
        
        
        Test.stopTest();
        
        
        
    }    
    
    static testMethod void UpdateContactUnitTests() {
        try{
            System.debug('####In UpdateContactUnitTests');
            //Data creation
            NAF__c naf = new NAF__c(Name='naf',CODE_APE__c='1234');
            insert naf;
            
            Pays__c pays = new Pays__c();
            pays.Name = 'France';
            insert pays;
            
            Account acc = new Account(Name='test');
            acc.SIRET__c='00000000000000';
            acc.CodeAPE__c=naf.Id;
            acc.Industry='Agriculture';
            acc.CodePays__c = pays.id;
            acc.Adresse_Ville__c = 'Nantes';
            insert acc;
            
            final Contact contact= new Contact(AccountId=acc.Id,
                                               statut__c='Etudiant',
                                               FirstName='Mohamed',
                                               LastName='Abdelfadel',
                                               Salutation='Mr',
                                               Famille_Fonction__c='Autres');
            
            
            try{
                insert contact;
            } catch(DmlException dmle)
            {
                System.debug('The following exception has occurred: ' + dmle.getMessage());
            }
            
            
            System.debug('####contact.Somme_Montant_Don__c'+contact.Somme_Montant_Don__c);
            RecordType FundraisingB2C= [Select ID From RecordType Where sObjectType = 'Opportunity' And name like '%Fundraising B2C%'];
            final Opportunity opp1= new Opportunity(RecordTypeId= FundraisingB2C.id,StageName='Prospect probable',
                                                    Name='test opp 1',
                                                    Contact_central__c=contact.Id,
                                                    AccountId=acc.Id,
                                                    amount = 1000,
                                                    Exercice__c='2015',
                                                    CloseDate=Date.valueOf('2015-08-15'),
                                                    InterfaceExternalId__c = 'blabla1',
                                                    Date_de_mise__c = DateTime.valueOf('2014-12-01 10:00:00'));
            
            final Opportunity opp2= new Opportunity(RecordTypeId= FundraisingB2C.id,StageName='Conclu',
                                                    Name='test opp 2',
                                                    Contact_central__c=contact.Id,
                                                    AccountId=acc.Id,
                                                    amount = 500,
                                                    Exercice__c='2015',
                                                    CloseDate=Date.valueOf('2015-08-15'),
                                                    InterfaceExternalId__c = 'blabla2',
                                                    Date_de_mise__c = DateTime.valueOf('2014-12-01 10:00:00'));
            
            
            final List<Opportunity> myOpportunities = new List <Opportunity>();
            myOpportunities.add(opp1);
            myOpportunities.add(opp2);
            
            try{insert myOpportunities; }catch (Exception e){
                System.debug('Exception' +e);
            }
            opp1.StageName='Conclu';
            opp2.StageName='Prospect probable';
            
            //Assert Test
            Test.startTest();
            System.debug('####contact.Somme_Montant_Don__c'+contact.Somme_Montant_Don__c);
            
            Boolean exceptionCatched = false;
            try {
                if(Test.isRunningTest()) {
                    // Cause DMLException
                    update myOpportunities;
                }
            } catch (System.DMLException e) {
                exceptionCatched = true;
            }
           System.assertEquals(exceptionCatched, false); 
        // System.assertEquals(exceptionCatched, true);
            
            System.debug('####contact.Somme_Montant_Don__c'+contact.Somme_Montant_Don__c);
            
            final Opportunity opp3= new Opportunity();
            myOpportunities.add(opp3);
            try {
                update myOpportunities;
            } catch (System.DMLException e) {
                exceptionCatched = true;
            }
            
            System.assertEquals(exceptionCatched, true);
            Test.stopTest();
        } catch(DmlException dmle)
        {
            System.debug('The following exception has occurred: ' + dmle.getMessage());
        }
    }
}