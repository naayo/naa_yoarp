/**
 * Created by Julie NGUYEN - Modis on 22/02/2017.
 */

public class DataExtract004Pays implements Queueable {

    private static String OBJECT_NAME_PAYS = 'Pays__c';

    public void execute(QueueableContext context) {
        extractPays();
        System.enqueueJob(new DataExtract005Product());
    }

     /**
    Extraction de tous les enregistrements "Pays__c"
     */
    public static void extractPays() {
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Pays__c
        Schema.DescribeSObjectResult objectDescribe  = Pays__c.SObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();

        // Construction de l'en-tete du csv et insertion des champs nécessaires a la requete SQL
        for( String fieldName : fieldMap.keySet() ) {
            // Echappement des champs non mettables à jour
            if (fieldMap.get(fieldName).getDescribe().isUpdateable()) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            }
        }

        // Suppression derniere virgule
        query = query.substring(0, query.length() - 1);
        query += '\n FROM ' + OBJECT_NAME_PAYS;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Pays__c> paysList = Database.query(query);

        // Remplissage du csv
        for ( Pays__c pays : paysList ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( pays.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) pays.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + pays.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_PAYS, '04');
    }
}