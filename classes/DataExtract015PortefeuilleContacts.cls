/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */

public class DataExtract015PortefeuilleContacts implements Queueable {

    public static final String OBJECT_NAME_PORTEFEUILLE_CONTACT = 'Portefeuille_contacts__c';

    public DataToExport dataExport{
        public get;
        public set;
    }

    public DataExtract015PortefeuilleContacts(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        extractPortefeuillesContacts();
        if (!Test.isRunningTest()) {
            System.enqueueJob(new DataExtract016Campaign(dataExport));
        }
    }

    /**
    Extraction des enregistrements Portefeuille_contacts__c liés aux contacts déjà traités
     */
    public void extractPortefeuillesContacts() {

        System.debug('--- BEGIN DataExtract015PortefeuilleContacts / extractPortefeuillesContacts() ---');

        System.debug('--- PARAM dataExport.contactsToExport : ' + dataExport.contactsToExport);

        if ( dataExport.contactsToExport != null && !dataExport.contactsToExport.isEmpty() ) {
            String whereClause = ' WHERE Contact__c IN ' + DataExtractUtils.convertSetToString(dataExport.contactsToExport) +
                    ' AND TECH_External_ID__c != null ';

            System.debug('--PARAM whereClause for query : ' + whereClause);

            // Stockage des id pour le traitement d'autres objets plus tard
            dataExport.portefeuillesToExport.addAll(DataExtractUtils.extractIdsFromSpecificRecords(
                    OBJECT_NAME_PORTEFEUILLE_CONTACT, whereClause, null));

            System.debug('--PARAM dataExport.portefeuillesToExport : ' + dataExport.portefeuillesToExport);

            // Génération du fichier csv
            DataExtractUtils.extractAllFieldWithSpecificWhereClause('14', OBJECT_NAME_PORTEFEUILLE_CONTACT, whereClause);
        } else {
            System.debug('--- Pas de Portefeuilles contacts existant liés aux contacts déjà traités');
        }

        System.debug('--- END DataExtract015PortefeuilleContacts / extractPortefeuillesContacts() ---');
    }
}