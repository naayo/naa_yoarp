/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */

public class DataExtract014Role implements Queueable {

    private static String OBJECT_NAME_ROLE = 'R_le__c';

    public void execute(QueueableContext context) {
        extractRoles();
        System.enqueueJob(new DataExtract015PortefeuilleContacts());
    }

    /**
    Extraction de 200 enregistrements "R_le__c" et changement des champs 'A_extraire__c' des contacts liés
    en true
    Sélection des 200 rôles les plus récents (Date de création)
     */
    public static List<Id> extractRoles() {

        List<Id> relatedContactsIds = new List<Id>();
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet R_le__c
        Schema.DescribeSObjectResult objectDescribe  = R_le__c.SObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();

        // Construction de l'en-tete du csv et insertion des champs nécessaires a la requete SQL
        for( String fieldName : fieldMap.keySet() ) {
            // Echappement des champs non mettables à jour
            if (fieldMap.get(fieldName).getDescribe().isUpdateable()) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            } // Prise en compte du champ contact
            else if (fieldName.equalsIgnoreCase('contact__c')) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            }
        }

        // Suppression derniere virgule
        query = query.substring(0, query.length() - 1);
        query += '\n FROM ' + OBJECT_NAME_ROLE + ' ORDER BY CreatedDate DESC LIMIT 300';
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<R_le__c> roles = Database.query(query);

        // Remplissage du csv et de la liste de contacts associée
        for ( R_le__c role : roles ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( role.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) role.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + role.get(field) + '",';
                    }
                }
            }
            csv += '\r';
            relatedContactsIds.add(role.Contact__c);
        }

        // Mise à jour du champ 'A_extraire__c' des contacts liés aux rôles
        DataExtractUtils.updateFieldBoolean(true, relatedContactsIds, 'Contact');

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_ROLE, '14');

        return relatedContactsIds;
    }
}