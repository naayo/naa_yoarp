/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */

public class DataExtract013Diplome implements Queueable {

    private static String OBJECT_NAME_DIPLOME = 'Dipl_me__c';

    public void execute(QueueableContext context) {
        extractDiplomes();
        System.enqueueJob(new DataExtract014Role());
    }

    /**
    Extraction de 300 enregistrements "Dipl_me__c" et changement des champs 'A_extraire__c' des contacts liés
    en true
    Sélection des 300 diplômes les plus récents (Date de création)
     */
    public static List<Id> extractDiplomes() {

        List<Id> relatedContactsIds = new List<Id>();
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Dipl_me__c
        Schema.DescribeSObjectResult objectDescribe  = Dipl_me__c.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_DIPLOME + ' ORDER BY CreatedDate DESC LIMIT 300';
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Dipl_me__c> diplomes = Database.query(query);

        // Remplissage du csv et de la liste de contacts associée
        for ( Dipl_me__c diplome : diplomes ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( diplome.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) diplome.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + diplome.get(field) + '",';
                    }
                }
            }
            csv += '\r';
            relatedContactsIds.add(diplome.Contact__c);
        }

        // Mise à jour du champ 'A_extraire__c' des contacts liés aux diplômes
        DataExtractUtils.updateFieldBoolean(true, relatedContactsIds, 'Contact');

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_DIPLOME, '13');

        return relatedContactsIds;
    }
}