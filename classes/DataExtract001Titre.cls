/**
 * Created by Julie NGUYEN - Modis on 13/02/2017.
 */

public class DataExtract001Titre implements Queueable {

    public static final String OBJECT_NAME_TITRE = 'Titre__c';

    public void execute(QueueableContext context) {
        extractTitres();
        System.enqueueJob(new DataExtract002User());
        if(!Test.isRunningTest()) {
            System.enqueueJob(new DataExtract003Naf());
        }
    }

    /**
    Extraction de tous les enregistrements "Titre__c"
     */
    public static void extractTitres() {
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Titre__c
        Schema.DescribeSObjectResult objectDescribe  = Titre__c.SObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();

        // Construction de l'en-tete du csv et insertion des champs nécessaires a la requete SQL
        for( String fieldName : fieldMap.keySet() ) {
            // Echappement des champs non mettables à jour
            if (fieldMap.get(fieldName).getDescribe().isCreateable()) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            }
        }

        // Suppression derniere virgule
        query = query.substring(0, query.length() - 1);
        query += '\n FROM ' + OBJECT_NAME_TITRE;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Titre__c> titres = Database.query(query);

        if (!titres.isEmpty()) {
            // Remplissage du csv
            for ( Titre__c titre : titres ) {
                for ( String field : fieldMap.keySet() ) {
                    // Echappement des champs non mettables à jour
                    if (fieldMap.get(field).getDescribe().isCreateable()) {
                        // Traitement si champ null
                        if ( titre.get(field) == null ) {
                            csv += '"",';
                        } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                        else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                                fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                            csv += ((String) titre.get(field)).escapeCsv() + ',';
                        } else {
                            csv += '"' + titre.get(field) + '",';
                        }
                    }
                }
                csv += '\r';
            }

            // Suppression du \r et de la dernière "," à la fin du traitement
            csv = csv.substring(0, csv.length() - 2);

            // Génération et enregistrement du fichier Csv
            DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_TITRE, '01');
        }
        System.debug('--- Begin DataExtract001Titre / extractTitres() ---');
        DataExtractUtils.extractAllFieldsToCSV('01', OBJECT_NAME_TITRE, null);
        System.debug('--- End DataExtract001Titre / extractTitres() ---');
    }
}