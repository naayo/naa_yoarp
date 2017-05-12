/* 
 * Créé par Tom CHAMART - MODIS
 * Le 22/02/2017
*/
@isTest
public class TestNbDiplomesInAccount {
    @testSetup static void setup(){
        Pays__c pays = new Pays__c();
        pays.Name = 'France';
        insert pays;
        
        // Créer et insérer un premier niveau de hiérarchie (COMPTE ULTIME)
        Account acc1_1 = new Account(Name='AccountTest1_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, SIRET__c='00000000000901');
        Account acc1_2 = new Account(Name='AccountTest1_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, SIRET__c='00000000000208');
        insert new List<Account>{acc1_1,acc1_2};
            
        // Créer et insérer un deuxième niveau de hiérarchie
        Account acc2_1 = new Account(Name='AccountTest2_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc1_1.Id, SIRET__c='00000000000802');
        Account acc3_1 = new Account(Name='AccountTest3_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc1_1.Id, SIRET__c='00000000000703');
        Account acc2_2 = new Account(Name='AccountTest2_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc1_2.Id, SIRET__c='00000000000109');
        Account acc3_2 = new Account(Name='AccountTest3_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc1_2.Id, SIRET__c='09010000000000');
        insert new List<Account>{acc2_1,acc3_1,acc2_2,acc3_2};
        
        // Créer et insérer un troisième niveau de hiérarchie
        Account acc4_1 = new Account(Name='AccountTest4_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc2_1.Id, SIRET__c='00000000000604');
        Account acc5_1 = new Account(Name='AccountTest5_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc2_1.Id, SIRET__c='00000000000505');
        Account acc6_1 = new Account(Name='AccountTest6_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc3_1.Id, SIRET__c='00000000000406');
        Account acc7_1 = new Account(Name='AccountTest7_1', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc3_1.Id, SIRET__c='00000000000307');
        Account acc4_2 = new Account(Name='AccountTest4_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc2_2.Id, SIRET__c='08020000000000');
        Account acc5_2 = new Account(Name='AccountTest5_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc2_2.Id, SIRET__c='07030000000000');
        Account acc6_2 = new Account(Name='AccountTest6_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc3_2.Id, SIRET__c='06040000000000');
        Account acc7_2 = new Account(Name='AccountTest7_2', Industry='Agriculture', Adresse_Ville__c = 'Marseille', 
                                     CodePays__c=pays.Id, ParentId = acc3_2.Id, SIRET__c='05050000000000');        
        insert new List<Account>{acc4_1,acc5_1,acc6_1,acc7_1,acc4_2,acc5_2,acc6_2,acc7_2};   
    }
    
    // Insertion d'un compte dans une hiérarchie
    static testMethod void verifyInsertAccount(){
        // Récupérer un compte 
        Account accParent = [SELECT Id FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        
        Test.startTest();

        // Assigner un contact diplômé au compte
        Contact ctc1 = new Contact(Salutation='Mr',FirstName='FirstName', LastName='LastName', 
                                   AccountId=accParent.Id, Identifiant_dipl_m__c='12345678');
        insert ctc1;

        // Créer un compte enfant du compte récupéré
        Pays__c pays = [SELECT Id FROM Pays__c WHERE Name = 'France'];
        Account accEnfant = new Account(Name='AccountTest', Industry='Agriculture', Adresse_Ville__c = 'Marseille', Code_tiers_societe__c ='CodeTest',
                                     	CodePays__c=pays.Id, SIRET__c='40483304800022');
        insert accEnfant;
        // Assigner un contact diplômé au compte enfant
        Contact ctc2 = new Contact(Salutation='Mr',FirstName='FirstName2', LastName='LastName2', 
                                   AccountId=accEnfant.Id, Identifiant_dipl_m__c='12345678');
        insert ctc2;
        // Assigner le parent du compte enfant créé
        accEnfant.ParentId = accParent.Id;
        update accEnfant;

        Test.stopTest();
        
        // Vérifier que le compte principal du nouveau compte a été affecté
        accEnfant = [SELECT ComptePrincipal__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest' LIMIT 1];
        System.assertEquals(accParent.Id,accEnfant.ComptePrincipal__c);

        // Vérifier le recalcul du nombre de diplômés du groupe
        System.assertEquals(2,accEnfant.Nombre_de_contacts_dipl_m_s_groupe__c);

        // Vérifier le recalcul du nombre de diplômés du groupe
        accParent = [SELECT ComptePrincipal__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        System.assertEquals(2,accParent.Nombre_de_contacts_dipl_m_s_groupe__c);

    }
    
    // Changement de hiérarchie d'un compte
    static testMethod void verifyUpdateAccount(){
        // Récupérer une hiérarchie
        Account acc1_1 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        Account acc2_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1]; 
        Account acc3_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        Account acc4_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest4_1' LIMIT 1];        
        Account acc5_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest5_1' LIMIT 1]; 
        Account acc6_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest6_1' LIMIT 1];
        Account acc7_1 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest7_1' LIMIT 1];

        // Récupérer une autre hiérarchie
        Account acc1_2 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_2' LIMIT 1];        
        Account acc2_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest2_2' LIMIT 1]; 
        Account acc3_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest3_2' LIMIT 1];
        Account acc4_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest4_2' LIMIT 1];        
        Account acc5_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest5_2' LIMIT 1]; 
        Account acc6_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest6_2' LIMIT 1];
        Account acc7_2 = [SELECT ComptePrincipal__c FROM Account WHERE Name='AccountTest7_2' LIMIT 1];

        Test.startTest();

        // Assigner un contact diplômé au parent de la deuxième hiérarchie
        Contact ctc1 = new Contact(Salutation='Mr',FirstName='FirstName1', LastName='LastName', 
                                   AccountId=acc1_2.Id, Identifiant_dipl_m__c='12345678');
        insert ctc1;

        // Assigner un contact diplômé à un compte de la deuxième hiérarchie
        Contact ctc2 = new Contact(Salutation='Mr',FirstName='FirstName', LastName='LastName', 
                                   AccountId=acc2_2.Id, Identifiant_dipl_m__c='12345678');
        insert ctc2;

        // Rattacher un compte de la deuxième hiérarchie à la première
        acc2_2.ParentId = acc1_1.Id;        
        update acc2_2;

        Test.stopTest();
        
        // Vérifier l'affectation du compte principal du compte rattaché
        acc2_2 = [SELECT Id,ComptePrincipal__c FROM Account WHERE Name='AccountTest2_2' LIMIT 1];
        System.assertEquals(acc1_1.Id,acc2_2.ComptePrincipal__c);        
        
        // Vérifier que le nombre de diplômés du premier groupe a été recalculé
        acc1_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        acc2_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1]; 
        acc3_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        acc4_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest4_1' LIMIT 1];        
        acc5_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest5_1' LIMIT 1]; 
        acc6_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest6_1' LIMIT 1];
        acc7_1 = [SELECT Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest7_1' LIMIT 1];
        System.assertEquals(1,acc1_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc2_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc3_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc4_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc5_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc6_1.Nombre_de_contacts_dipl_m_s_groupe__c);
        System.assertEquals(1,acc7_1.Nombre_de_contacts_dipl_m_s_groupe__c);

        // Vérifier que le nombre de diplômés du deuxième groupe a été recalculé
        acc1_2 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_2' LIMIT 1]; 
        System.assertEquals(1,acc1_2.Nombre_de_contacts_dipl_m_s_groupe__c);
    }
    
    // Vérifier de l'affectation des nombres de diplômés lors d'un ajout de contact diplômés
    static testMethod void verifyUnitInsertContactDiplomes(){
    	// Récupérer 3 comptes (2 et 3 filiales de 1)
        Account acc1 = [SELECT Id FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        Account acc2 = [SELECT Id FROM Account WHERE Name='AccountTest2_1' LIMIT 1]; 
        Account acc3 = [SELECT Id FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        
        Test.startTest();
        // Créer et insérer 4 contacts diplômés       
        Contact ctc1 = new Contact(Salutation='Mr',FirstName='FirstName1', LastName='LastName1', 
                                   AccountId=acc1.Id, Identifiant_dipl_m__c='12345678');
        
        Contact ctc2 = new Contact(Salutation='Mr',FirstName='FirstName2', LastName='LastName2', 
                                   AccountId=acc1.Id, Identifiant_dipl_m__c='12345678'); 
        
        Contact ctc3 = new Contact(Salutation='Mr',FirstName='FirstName3', LastName='LastName3', 
                                   AccountId=acc2.Id, Identifiant_dipl_m__c='12345678');
        
        Contact ctc4 = new Contact(Salutation='Mr',FirstName='FirstName4', LastName='LastName4', 
                                   AccountId=acc3.Id, Identifiant_dipl_m__c='12345678');
        
        insert new List<Contact>{ctc1,ctc2,ctc3,ctc4};
        Test.stopTest();
        
        // Récupérer les comptes modifié
        acc1 = [SELECT Nombre_de_contacts_dipl_m_s__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        acc2 = [SELECT Nombre_de_contacts_dipl_m_s__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1];
        acc3 = [SELECT Nombre_de_contacts_dipl_m_s__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        
        // Vérifier que les comptes possèdent le bon nombre de diplômés
        System.assertEquals(2,acc1.Nombre_de_contacts_dipl_m_s__c);       
        System.assertEquals(1,acc2.Nombre_de_contacts_dipl_m_s__c);        
        System.assertEquals(1,acc3.Nombre_de_contacts_dipl_m_s__c);
        
        // Vérifier que les comptes possèdent 4 diplômés dans le groupe       
        System.assertEquals(4,acc1.Nombre_de_contacts_dipl_m_s_groupe__c);        
        System.assertEquals(4,acc2.Nombre_de_contacts_dipl_m_s_groupe__c);       
        System.assertEquals(4,acc3.Nombre_de_contacts_dipl_m_s_groupe__c);
    }
    
    // Vérifier de l'affectation des nombres de diplômés lors d'un ajout de contact diplômés en masse
    static testMethod void verifyBulkInsertContactDiplomes(){        
        // Récupérer 3 comptes (2 et 3 filiales de 1)
        Account acc1 = [SELECT Id FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        Account acc2 = [SELECT Id FROM Account WHERE Name='AccountTest2_1' LIMIT 1]; 
        Account acc3 = [SELECT Id FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        
        // Créer 200 contacts diplômés dans une liste
        List<Contact> contacts = new List<Contact>{}; 
        for(Integer i = 0; i < 50; i++){
            Contact c = new Contact(Salutation='Mr',FirstName='FirstName'+i, LastName='LastName'+i, 
                                    AccountId=acc1.Id, Identifiant_dipl_m__c='12345678');
            contacts.add(c);
        }
        for(Integer i = 50; i < 100; i++){
            Contact c = new Contact(Salutation='Mr',FirstName='FirstName'+i, LastName='LastName'+i, 
                                    AccountId=acc2.Id, Identifiant_dipl_m__c='12345678');
            contacts.add(c);
        }
        for(Integer i = 100; i < 150; i++){
            Contact c = new Contact(Salutation='Mr',FirstName='FirstName'+i, LastName='LastName'+i, 
                                    AccountId=acc3.Id, Identifiant_dipl_m__c='12345678');
            contacts.add(c);
        }
        
        // Insérer la liste de 200 contacts diplômés
        Test.startTest();        
        insert contacts;        
        Test.stopTest();
        
        // Vérifier que les comptes possèdent le bon nombre de diplômés
        acc1 = [SELECT Id, Nombre_de_contacts_dipl_m_s__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        System.assertEquals(50,acc1.Nombre_de_contacts_dipl_m_s__c);
        acc2 = [SELECT Id, Nombre_de_contacts_dipl_m_s__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1];        
        System.assertEquals(50,acc2.Nombre_de_contacts_dipl_m_s__c);
        acc3 = [SELECT Id, Nombre_de_contacts_dipl_m_s__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];        
        System.assertEquals(50,acc3.Nombre_de_contacts_dipl_m_s__c);
        
        // Vérifier que les comptes possèdent 4 diplômés dans le groupe
        acc1 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        System.assertEquals(150,acc1.Nombre_de_contacts_dipl_m_s_groupe__c);
        acc2 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1];        
        System.assertEquals(150,acc2.Nombre_de_contacts_dipl_m_s_groupe__c);
        acc3 = [SELECT Id, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];        
        System.assertEquals(150,acc3.Nombre_de_contacts_dipl_m_s_groupe__c);
    }
    
    // Vérifier le recalcul des nombres de diplômés lors d'une suppression de contact
    static testMethod void verifyDeleteContactDiplomes(){
        Account acc1 = [SELECT Id FROM Account WHERE Name='AccountTest1_1' LIMIT 1];        
        
        // Créer et insérer 3 contacts au compte dont 2 diplômés
        Test.startTest();        
        Contact ctc1 = new Contact(Salutation='Mr',FirstName='FirstName1', LastName='LastName1', 
                                   AccountId=acc1.Id, Identifiant_dipl_m__c='12345678');        
        Contact ctc2 = new Contact(Salutation='Mr',FirstName='FirstName2', LastName='LastName2', 
                                   AccountId=acc1.Id, Identifiant_dipl_m__c='12345678');        
        Contact ctc3 = new Contact(Salutation='Mr',FirstName='FirstName3', LastName='LastName3', 
                                   AccountId=acc1.Id);        
        insert new List<Contact>{ctc1,ctc2,ctc3};
        Test.stopTest();
        
        // Enlever le diplôme d'un des deux diplômés
        ctc1.Identifiant_dipl_m__c = null;
        update ctc1;
        
        // Vérifier que le compte ne possède qu'un diplômé
        acc1 = [SELECT Id, Nombre_de_contacts_dipl_m_s__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        System.assertEquals(1,acc1.Nombre_de_contacts_dipl_m_s__c);
        
        // Vérifier que les comptes possèdent 1 diplômés dans le groupe
        System.assertEquals(1,acc1.Nombre_de_contacts_dipl_m_s_groupe__c);
        Account acc2 = [SELECT Id,Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1];
        System.assertEquals(1,acc2.Nombre_de_contacts_dipl_m_s_groupe__c);
        Account acc3 = [SELECT Id,Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        System.assertEquals(1,acc3.Nombre_de_contacts_dipl_m_s_groupe__c);
        

        // Supprimer un contact diplômé
		// Récupérer le portefeuille contact
        List<Portefeuille_contacts__c> pcs = [SELECT Id FROM Portefeuille_contacts__c WHERE Contact__r.Id=:ctc2.Id];
        // Supprimer le portefeuille contact pour supprimer le contact
        if(pcs.size()>0) delete pcs;
        // Supprimer le dernier diplômé
        delete ctc2;
        
        // Vérifier que le compte ne possède plus de diplômés
        acc1 = [SELECT Id, Nombre_de_contacts_dipl_m_s__c,Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        System.assertEquals(0,acc1.Nombre_de_contacts_dipl_m_s__c);
        
        // Vérifier que les comptes ne possèdent plus diplômés dans le groupe
        System.assertEquals(0,acc1.Nombre_de_contacts_dipl_m_s_groupe__c);
        acc2 = [SELECT Id,Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest2_1' LIMIT 1];
        System.assertEquals(0,acc2.Nombre_de_contacts_dipl_m_s_groupe__c);
        acc3 = [SELECT Id,Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
        System.assertEquals(0,acc3.Nombre_de_contacts_dipl_m_s_groupe__c);
    }
    
    // Vérifier la réaffectation des comptes principaux lors d'un changement de compte principal d'un contact
    static testMethod void verifyUpdateComptePrincipal(){
    	// Récupérer deux comptes de deux hiérarchies (des enfants direct d'un compte principal de chaque hierarchie)
        Account acc2_1 = [SELECT Id, ParentId FROM Account WHERE Name='AccountTest2_1' LIMIT 1];
        Account acc1_2 = [SELECT Id FROM Account WHERE Name='AccountTest1_2' LIMIT 1];
        
        Test.startTest();
        // Modifier le parent du compte de la première hiérarchie avec le compte de la seconde hiérarchie
        acc2_1.ParentId = acc1_2.Id;
		update acc2_1;        
        Test.stopTest();
        
        // Récupérer le compte modifié et ses enfants
        acc2_1 = [SELECT Id, ComptePrincipal__c, ComptePrincipal__r.Name FROM Account WHERE Name='AccountTest2_1' LIMIT 1];
		Account acc4_1 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest4_1' LIMIT 1];  
        Account acc5_1 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest5_1' LIMIT 1];
        
        // Vérifier que le compte de la première hiérarchie a bien été modifié ainsi que ses enfants
        System.assertEquals(acc1_2.Id, acc2_1.ComptePrincipal__c);
        System.assertEquals(acc1_2.Id, acc4_1.ComptePrincipal__c);
        System.assertEquals(acc1_2.Id, acc5_1.ComptePrincipal__c);
    }
    
    // Vérifier la réaffectation des comptes principaux lors de la suppression d'un compte principal
    static testMethod void verifyDeleteComptePrincipal(){
    	// Récupérer le compte principal
        Account acc1 = [SELECT Id FROM Account WHERE Name='AccountTest1_1' LIMIT 1];
        
        Test.startTest();
        delete acc1; // Supprimer le compte principal
        Test.stopTest();
        
        // Récupérer les deux nouveaux comptes principaux
        Account acc2 = [SELECT Id FROM Account WHERE Name='AccountTest2_1' LIMIT 1];        
        Account acc3 = [SELECT Id FROM Account WHERE Name='AccountTest3_1' LIMIT 1];
		// Récupérer les filiales
		Account acc4 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest4_1' LIMIT 1];  
        Account acc5 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest5_1' LIMIT 1];
        Account acc6 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest6_1' LIMIT 1];        
        Account acc7 = [SELECT Id, ComptePrincipal__c FROM Account WHERE Name='AccountTest7_1' LIMIT 1];
        
        // Vérifier que les comptes principaux des filiales ont bien été modifiés
        System.assertEquals(acc2.Id,acc4.ComptePrincipal__c);
        System.assertEquals(acc2.Id,acc5.ComptePrincipal__c);
        System.assertEquals(acc3.Id,acc6.ComptePrincipal__c);
        System.assertEquals(acc3.Id,acc7.ComptePrincipal__c);
    }    
}