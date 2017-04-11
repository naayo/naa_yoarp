/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract019LeadTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testExtractLeads() {
        String objName = DataExtract019Lead.OBJECT_NAME_LEAD ;

        DataExtract019Lead de = new DataExtract019Lead(new DataToExport());

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testCsvFile(objName);
        DataExtractObjectsUtilsTest.testIfRecordsToExport(DataExtract019Lead.OBJECT_NAME_LEAD, de.dataExport);
    }
}