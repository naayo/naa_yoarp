/**
 * Created by Julie NGUYEN - Modis on 22/02/2017.
 */

public class DataExtract003Naf implements Queueable {

    private static String OBJECT_NAME_NAF = 'NAF__c';

    public void execute(QueueableContext context) {
        extractNaf();
        System.enqueueJob(new DataExtract004Pays());
    }

    /**
    Extraction de tous les enregistrements "NAF__c"
     */
    public static void extractNaf() {

        String csv = '';
        String query = 'SELECT ';

        // Récuperation des champs de l'objet NAF__c
        Schema.DescribeSObjectResult objectDescribe = NAF__c.SObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();

        // Construction de l'en-tete du csv et insertion des champs nécessaires a la requete SQL
        for( String fieldName : fieldMap.keySet() ) {
            // Echappement des champs non mettables à jour
            if (fieldMap.get(fieldName).getDescribe().isUpdateable()) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            }
        }

        // Suppression dernière virgule
        query = query.substring(0, query.length() - 1);
        query += '\n FROM ' + OBJECT_NAME_NAF;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<NAF__c> nafList = Database.query(query);

        // Remplissage du csv
        for ( NAF__c naf : nafList ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( naf.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) naf.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + naf.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Génération et enregistrement du fichier Csv
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_NAF, '03');
    }
}