/**
 * Created by Julie NGUYEN - Modis on 23/02/2017.
 */

public class DataExtract011Formation implements Queueable {

    private static String OBJECT_NAME_FORMATION = 'Formation__c';

    public void execute(QueueableContext context) {
        extractFormations();
        System.enqueueJob(new DataExtract013Diplome());
    }

    /**
    Extraction de 150 enregistrements "Formation__c" et changement des champs 'A_extraire__c' des contacts liés
    en true
    Sélection des 150 formations les plus récentes (Date de création)
     */
    public static List<Id> extractFormations() {

        List<Id> relatedContactsIds = new List<Id>();
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Formation__c
        Schema.DescribeSObjectResult objectDescribe  = Formation__c.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_FORMATION + ' ORDER BY CreatedDate DESC LIMIT 150';
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Formation__c> formations = Database.query(query);

        // Remplissage du csv et de la liste de contacts associée
        for ( Formation__c formation : formations ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( formation.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) formation.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + formation.get(field) + '",';
                    }
                }
            }
            csv += '\r';
            relatedContactsIds.add(formation.Contact__c);
        }

        // Mise à jour du champ 'A_extraire__c' des contacts liés aux formations
        DataExtractUtils.updateFieldBoolean(true, relatedContactsIds, 'Contact');

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_FORMATION, '12');

        return relatedContactsIds;
    }
}