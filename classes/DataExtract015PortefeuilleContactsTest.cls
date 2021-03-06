/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract015PortefeuilleContactsTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testExtractPortefeuilles() {
        String objName = DataExtract015PortefeuilleContacts.OBJECT_NAME_PORTEFEUILLE_CONTACT ;

        DataToExport dataExport = new DataToExport();

        DataExtractObjectsUtilsTest.addObjectsToProcess(dataExport, DataExtract012Contact.OBJECT_NAME_CONTACT);

        List<Portefeuille_contacts__c> portefeuilles = [SELECT Id, TECH_External_Id__c FROM Portefeuille_contacts__c];
        for (Portefeuille_contacts__c p : portefeuilles) {
            p.TECH_External_Id__c = p.Id;
        }
        update portefeuilles;

        DataExtract015PortefeuilleContacts de = new DataExtract015PortefeuilleContacts(dataExport);

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testCsvFile(objName);
        DataExtractObjectsUtilsTest.testIfRecordsToExport(DataExtract015PortefeuilleContacts.OBJECT_NAME_PORTEFEUILLE_CONTACT, de.dataExport);
    }
}