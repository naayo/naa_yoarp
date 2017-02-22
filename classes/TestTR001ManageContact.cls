/**
LastModifiedBy Sabri Dali 16/03/2016
test class correction and assert implementation
cooments added
*/
@isTest
public class TestTR001ManageContact {

    static testMethod void verifyCreatePosteSupplementaire(){

        //Data creation
        NAF__c naf = new NAF__c();
        naf.CODE_APE__c = 'AAAA';
        naf.Code_NACE__c = 'BBBB';
        naf.Secteur__c = 120;
        insert naf;

        Pays__c pays = new Pays__c();
        pays.Name = 'France';
        insert pays;

        Account acc1 = new Account(Name='AccTest1');
        acc1.SIRET__c  = '40483304800022';
        acc1.CodeAPE__c = naf.Id;
        acc1.CodePays__c = pays.id;
        acc1.Adresse_Ville__c = 'Nantes';
        insert acc1;

        Account acc2 = new Account(Name='AccTest2');
        acc2.SIRET__c  = '40483304800030';
        acc2.CodeAPE__c = naf.Id;
        acc2.CodePays__c = pays.id;
        acc2.Adresse_Ville__c = 'Nantes';
        insert acc2;

        Contact testContact = new Contact();
        testContact.lastName = 'toto';
        testContact.firstName = 'toto2';
        testContact.salutation = 'M.';
        testContact.AccountId = acc1.Id;
        testContact.Statut__c = 'Etudiant';
        testContact.Famille_Fonction__c = 'Production/Achats';
        insert testContact;

        //Test
        Test.startTest();
        testContact.AccountId = acc2.Id;
        testContact.Statut__c = 'Professionnel';
        update testContact;
        List<Postes_Suppl_mentaires__c> poste = [SELECT id,Name FROM Postes_Suppl_mentaires__c where Contact__c =:testContact.Id];
        System.assertEquals(1, poste.size());
        Test.stopTest();
    }
}