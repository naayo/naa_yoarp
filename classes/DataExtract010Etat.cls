/**
 * Created by Julie NGUYEN - Modis on 23/02/2017.
 */

public class DataExtract010Etat implements Queueable {

    private static String OBJECT_NAME_ETAT = 'Etat__c';

    public void execute(QueueableContext context) {
        extractEtats();
        System.enqueueJob(new DataExtract011Formation());
    }

    /**
    Extraction de tous les enregistrements "Etat__c"
     */
    public static void extractEtats() {
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Etat__c
        Schema.DescribeSObjectResult objectDescribe  = Etat__c.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_ETAT;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Etat__c> etats = Database.query(query);

        // Remplissage du csv
        for ( Etat__c etat : etats ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( etat.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) etat.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + etat.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_ETAT, '10');
    }
}