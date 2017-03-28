/**
 * Created by Julie NGUYEN - Modis on 15/03/2017.
 */

@IsTest
private class DataExtract017OpportunityLoopTest {

    @testSetup static void createData() {
        DataExtractObjectsUtilsTest.createData();
    }

    static testMethod void testDataTransfer() {
        DataToExport dataToExport = new DataToExport();

        // Ajout de données à 'Process', dont opportunitiesToProcess
        DataToExportTest.fillObjectsToProcess(dataToExport);

        DataExtract017OpportunityLoop de = new DataExtract017OpportunityLoop(dataToExport);

        Test.startTest();
        de.execute(null);
        Test.stopTest();

        // Vérification que opportunitiesToProcess a été vidé au profit de opportunitiesToExport
        System.assertEquals(dataToExport.opportunitiesToProcess.size(), 0);
        System.assertEquals(dataToExport.opportunitiesToExport.size(), [SELECT Id FROM Contact].size());
    }
}