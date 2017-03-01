/**
 * Created by Julie NGUYEN - Modis on 28/02/2017.
 */

public class DataExtract016Campaign implements Queueable {

    private static String OBJECT_NAME_CAMPAIGN = 'Campaign';

    public void execute(QueueableContext context) {
        extractCampaigns();
        System.enqueueJob(new DataExtract017Opportunity());
    }

    /**
    Extraction de 20 enregistrements "Campaign"
    Sélection des 20 campagnes les plus récentes (Date de création)
     */
    public static void extractCampaigns() {

        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Campaign
        Schema.DescribeSObjectResult objectDescribe  = Campaign.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_CAMPAIGN + ' ORDER BY CreatedDate DESC LIMIT 20';
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Campaign> campaigns = Database.query(query);

        // Remplissage du csv
        for ( Campaign campaign : campaigns ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( campaign.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) campaign.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + campaign.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_CAMPAIGN, '16');
    }
}