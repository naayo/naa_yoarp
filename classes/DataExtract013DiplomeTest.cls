/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract013DiplomeTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testExtractDiplomes() {
        String objName = DataExtract013Diplome.OBJECT_NAME_DIPLOME;

        DataToExport dataExport = new DataToExport();

        DataExtractObjectsUtilsTest.addObjectsToProcess(dataExport, DataExtract012Contact.OBJECT_NAME_CONTACT);

        DataExtract013Diplome de = new DataExtract013Diplome(dataExport);

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testCsvFile(objName);
    }
}