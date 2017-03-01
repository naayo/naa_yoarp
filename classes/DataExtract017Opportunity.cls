/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */
public class DataExtract017Opportunity {

    private static String OBJECT_NAME_OPPORTUNITY = 'Opportunity';

    public void execute(QueueableContext context) {
        extractOpportunities();
        System.enqueueJob(new DataExtract012Contact());
    }

    /**
    Extraction de 100 enregistrements "Opportunity" et changement des champs 'A_extraire__c' des contacts liés
    en true
    Sélection des 100 portefeuilles contacts les plus récents (Date de création)
     */
    public static List<Id> extractOpportunities() {

        List<Id> relatedContactsIds = new List<Id>();
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Portefeuille_contacts__c
        Schema.DescribeSObjectResult objectDescribe  = Portefeuille_contacts__c.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_OPPORTUNITY + ' ORDER BY CreatedDate DESC LIMIT 100';
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Portefeuille_contacts__c> portefeuilles = Database.query(query);

        // Remplissage du csv et de la liste de contacts associée
        for ( Portefeuille_contacts__c portefeuille : portefeuilles ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( portefeuille.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) portefeuille.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + portefeuille.get(field) + '",';
                    }
                }
            }
            csv += '\r';
            relatedContactsIds.add(portefeuille.Contact__c);
        }

        // Mise à jour du champ 'A_extraire__c' des contacts liés aux portefeuilles
        DataExtractUtils.updateFieldBoolean(true, relatedContactsIds, 'Contact');

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_OPPORTUNITY, '17');

        return relatedContactsIds;
    }
}