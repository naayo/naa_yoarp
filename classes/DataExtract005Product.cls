/**
 * Created by Julie NGUYEN - Modis on 22/02/2017.
 */

public class DataExtract005Product implements Queueable {

    private static String OBJECT_NAME_PRODUCT = 'Product2';

    public void execute(QueueableContext context) {
        extractProducts();
        System.enqueueJob(new DataExtract006Pricebook2());
    }

     /**
    Extraction de tous les enregistrements "Product2"
     */
    public static void extractProducts() {
        String csv = '';
        String query = 'SELECT ';

        // Recuperation des champs de l'objet Product2
        Schema.DescribeSObjectResult objectDescribe  = Product2.SObjectType.getDescribe();
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
        query += '\n FROM ' + OBJECT_NAME_PRODUCT;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<Product2> products = Database.query(query);

        // Remplissage du csv
        for ( Product2 product : products ) {
            for ( String field : fieldMap.keySet() ) {
                // Echappement des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if ( product.get(field) == null ) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if ( fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA ) {
                        csv += ((String) product.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + product.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Generation du fichier csv et enregistrement dans les fichiers Chatter
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_PRODUCT, '05');
    }

}