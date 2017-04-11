/**
 * Created by Julie NGUYEN - Modis on 23/02/2017.
 */

public class DataExtract011Formation implements Queueable {

    public static final String OBJECT_NAME_FORMATION = 'Formation__c';

    public DataToExport dataExport{
        public get;
        public set;
    }

    public DataExtract011Formation(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        extractFormations();

        if(!Test.isRunningTest()) {
            System.enqueueJob(new DataExtract013Diplome(dataExport));
        }
    }

    /**
    Extraction des formations liées aux contacts déjà traités
     */
    public void extractFormations() {

        System.debug('--- BEGIN DataExtract011Formation / extractFormations() ---');

        String whereClauseWithContacts = ' WHERE Contact__c IN ' + DataExtractUtils.convertSetToString(dataExport.contactsToExport);

        System.debug('--PARAM whereClause for query : ' + whereClauseWithContacts);

        if (!dataExport.contactsToExport.isEmpty() && dataExport.contactsToExport != null) {
            DataExtractUtils.extractAllFieldWithSpecificWhereClause('11', OBJECT_NAME_FORMATION, whereClauseWithContacts);
        } else {
            System.debug('Il n\'y a pas de formations liées aux contacts déjà traités');
        }

        System.debug('--- END DataExtract011Formation / extractFormations() ---');
    }
}