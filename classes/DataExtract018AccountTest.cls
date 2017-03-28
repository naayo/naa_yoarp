/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract018AccountTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testSelectAccounts() {
        String objName = DataExtract018Account.OBJECT_NAME_ACCOUNT;

        DataExtract018Account dataExtAccount = new DataExtract018Account(new DataToExport());

        Test.startTest();
        dataExtAccount.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testSelectedRecords(objName, dataExtAccount.dataExport);
    }
}