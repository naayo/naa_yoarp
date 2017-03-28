/**
 * Created by Julie NGUYEN - Modis on 22/02/2017.
 */

public class DataExtract003Naf implements Queueable {

    public static final String OBJECT_NAME_NAF = 'NAF__c';

    public void execute(QueueableContext context) {
        extractNaf();
        if(!Test.isRunningTest()) {
            System.enqueueJob(new DataExtract004Pays());
        }
    }

    /**
    Extraction de tous les enregistrements "NAF__c"
     */
    public static void extractNaf() {
        System.debug('--- BEGIN DataExtract003Naf / extractNaf() ---');
        DataExtractUtils.extractAllFieldsToCSV('02', OBJECT_NAME_NAF, null);
        System.debug('--- END DataExtract003Naf / extractNaf() ---');
    }
}