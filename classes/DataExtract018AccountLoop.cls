/**
 * Created by Julie NGUYEN - Modis on 03/03/2017.
 */

public class DataExtract018AccountLoop implements Queueable {

    private DataToExport dataExport;

    public DataExtract018AccountLoop(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        processAccounts();
        if (!Test.isRunningTest()) {
            if (!dataExport.isProcessingComplete()) {
                System.debug('-- DataExtract018AccountLoop / execute() : !dataExport.isProcessingComplete() ');
                System.enqueueJob(new DataExtract012ContactLoop(dataExport));
            } else {
                System.debug('-- DataExtract018AccountLoop / execute() : ELSE');
                System.enqueueJob(new DataExtract018AccountAfterLoop(dataExport));
            }
        }
    }

    public void processAccounts() {

        System.debug('--- BEGIN DataExtract018AccountLoop / processAccounts() ---');

        String idsToString = DataExtractUtils.convertSetToString(dataExport.accountsToProcess);

        System.debug('-- PARAM accountsToProcess\'Ids converted to String : ' + idsToString);

        // Sélection des contacts liés aux comptes à traiter
        selectContactsRelatedToAccounts(idsToString);

        System.debug('-- PARAM dataExport.accountsToExport before transfer : ' + dataExport.accountsToExport);
        System.debug('-- PARAM dataExport.accountsToProcess before transfer : ' + dataExport.accountsToProcess);

        // Déplacement des comptes traités de accountsToProcess à accountsToExport
        dataExport.accountsToExport.addAll(dataExport.accountsToProcess);
        dataExport.accountsToProcess.clear();

        System.debug('-- PARAM dataExport.accountsToExport after transfer : ' + dataExport.accountsToExport);
        System.debug('-- PARAM dataExport.accountsToProcess after transfer : ' + dataExport.accountsToProcess);
        System.debug('-- PARAM dataExport.loopCounter : ' + dataExport.loopCounter);

        System.debug('--- END DataExtract018AccountLoop / processAccounts() ---');
    }

    /**
    Sélection des contacts liés aux comptes
     */
    private void selectContactsRelatedToAccounts(String idsToString) {

        System.debug('--- METHOD : DataExtract018AccountLoop / selectContactsRelatedToAccounts() ---');

        String query = 'SELECT AccountId FROM ' + DataExtract012Contact.OBJECT_NAME_CONTACT +
                ' WHERE AccountId IN ' + idsToString;

        System.debug('--PARAM query : ' + query);

        List<Contact> contacts = Database.query(query);
        if ( contacts != null && !contacts.isEmpty() ) {
            Set<Id> conIds = new Set<Id>();
            for ( Contact con : contacts ) {
                conIds.add(con.AccountId);
            }
            dataExport.addAllContactsToProcess(conIds);
        }

        System.debug('--PARAM dataExport.contactsToProcess : '+ dataExport.contactsToProcess);

        System.debug('--- END METHOD : DataExtract018AccountLoop / selectContactsRelatedToAccounts() ---');
    }
}