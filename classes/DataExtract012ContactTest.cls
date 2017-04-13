/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract012ContactTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testSelectContacts() {
        String objName = DataExtract012Contact.OBJECT_NAME_CONTACT;

        List<Contact> contacts = [SELECT Id, TECH_External_Id__c FROM Contact];
        for (Contact c : contacts) {
            c.TECH_External_Id__c = c.Id;
        }
        update contacts;

        DataExtract012Contact de = new DataExtract012Contact();

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testSelectedRecords(objName, DataExtract012Contact.dataExp);
    }
}