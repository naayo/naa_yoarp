/**
 * Created by Julie NGUYEN - Modis on 23/02/2017.
 */

public class DataExtract012Contact implements Queueable {

    public static final String OBJECT_NAME_CONTACT = 'Contact';

    public static DataToExport dataExp = new DataToExport();

    /**
    Clauses WHERE pour obtenir un jeu de données pertinent en filtrant les types d'enregistrements
     */
    private static final String WHERE_RECORD_TYPE_PROSPECT_ETUDIANT = ' WHERE Record_Type_Name__c = \'Prospect Etudiant\' ' +
            'ORDER BY CreatedDate DESC ';
    private static final String WHERE_RECORD_TYPE_ETUDIANT = ' WHERE Record_Type_Name__c = \'Etudiant\' ' +
            'ORDER BY CreatedDate DESC ';
    private static final String WHERE_RECORD_TYPE_PROFESSIONNEL = ' WHERE Record_Type_Name__c = \'Professionnel\' ' +
            'ORDER BY CreatedDate DESC ';

    public void execute(QueueableContext context) {
        extractContacts(dataExp);
        if(!Test.isRunningTest()) {
            System.debug('-- PARAM BEFORE EnqueueJob dataToExport.contactsToProcess : ' + dataExp.contactsToProcess);
            System.enqueueJob(new DataExtract017Opportunity(dataExp));
        }
    }

    /**
    Sélection des id de 1000 enregistrements 'Contact'
    Les contacts sélectionnés sont de type :
    - 500 de type 'Etudiant'
    - 250 de type 'Prospect Etudiant'
    - 250 de type 'Professionnel'
     */
    public static void extractContacts(DataToExport dataToExport) {

        System.debug('--- BEGIN DataExtract012Contact / extractContacts() ---');

        // Sélection du quota de contacts de type 'Etudiant'
        dataToExport.addAllContactsToProcess(DataExtractUtils.extractIdsFromSpecificRecords(OBJECT_NAME_CONTACT,
                WHERE_RECORD_TYPE_ETUDIANT, 500));

        // Sélection du quota de contacts de type 'Prospect Etudiant'
        dataToExport.addAllContactsToProcess(DataExtractUtils.extractIdsFromSpecificRecords(OBJECT_NAME_CONTACT,
                WHERE_RECORD_TYPE_PROSPECT_ETUDIANT, 250));

        // Sélection du quota de contacts de type 'Professionnel'
        dataToExport.addAllContactsToProcess(DataExtractUtils.extractIdsFromSpecificRecords(OBJECT_NAME_CONTACT,
                WHERE_RECORD_TYPE_PROFESSIONNEL, 250));

        System.debug('-- PARAM dataToExport.contactsToProcess : ' + dataToExport.contactsToProcess);

        System.debug('--- END DataExtract012Contact / extractContacts() ---');
    }
}