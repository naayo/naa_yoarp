/**
 * Created by Julie NGUYEN - Modis on 14/03/2017.
 */

@IsTest
private class DataExtract017OpportunityTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testSelectOpportunities() {
        String objName = DataExtract017Opportunity.OBJECT_NAME_OPPORTUNITY;
        List<Opportunity> opportunities = [SELECT ID, TECH_External_Id__c FROM Opportunity];
        for (Opportunity opp : opportunities) {
            opp.TECH_External_Id__c = opp.Id;
        }
        update opportunities;

        DataExtract017Opportunity de = new DataExtract017Opportunity(new DataToExport());

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        DataExtractObjectsUtilsTest.testSelectedRecords(objName, de.dataExport);
    }

}