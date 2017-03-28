/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract023ContactAssoOppTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testExtractContactsAssoOpp() {
        String objName = DataExtract023ContactAssoOpp.OBJECT_NAME_CONTACT_ASSO_OPP ;

        DataToExport dataExport = new DataToExport();

        DataExtractObjectsUtilsTest.addObjectsToProcess(dataExport, DataExtract012Contact.OBJECT_NAME_CONTACT);
        DataExtractObjectsUtilsTest.addObjectsToProcess(dataExport, DataExtract017Opportunity.OBJECT_NAME_OPPORTUNITY);

        DataExtract023ContactAssoOpp de = new DataExtract023ContactAssoOpp(dataExport);
        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testCsvFile(objName);
    }
}