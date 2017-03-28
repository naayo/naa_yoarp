/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */

public class DataExtract013Diplome implements Queueable {

    public static final String OBJECT_NAME_DIPLOME = 'Dipl_me__c';

    private DataToExport dataExport;

    public DataExtract013Diplome(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        extractDiplomes();
        if ( !Test.isRunningTest() ) {
            System.enqueueJob(new DataExtract014Role(dataExport));
        }
    }

    /**
    Extraction des diplômes liés aux contacts déjà traités
     */
    public void extractDiplomes() {

        System.debug('--- BEGIN DataExtract013Diplome / extractDiplomes() ---');

        if ( dataExport.contactsToExport != null && !dataExport.contactsToExport.isEmpty() ) {
            String whereClause = ' WHERE Contact__c IN ' + DataExtractUtils.convertSetToString(dataExport.contactsToExport);

            System.debug('--PARAM whereClause for query : ' + whereClause);

            DataExtractUtils.extractAllFieldWithSpecificWhereClause('12', OBJECT_NAME_DIPLOME, whereClause);
        } else {
            System.debug(' Il n\'y a de diplômés parmi les contacts traités');
        }

        System.debug('--- END DataExtract013Diplome / extractDiplomes() ---');
    }
}