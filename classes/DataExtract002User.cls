/**
 * Created by Julie NGUYEN - Modis on 13/02/2017.
 */

public class DataExtract002User implements Queueable {

    private static String OBJECT_NAME_USER = 'User';

    public void execute(QueueableContext context) {
        extractUsers();
        System.enqueueJob(new DataExtract003Naf());
    }

    /**
    Extraction de tous les enregistrements "User"
     */
    public static void extractUsers() {
        String csv = '';
        String query = 'SELECT ';

        // Récuperation des champs de l'objet User
        Schema.DescribeSObjectResult objectDescribe = User.SObjectType.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = objectDescribe.fields.getMap();

        // Construction du header du csv et insertion des champs nécessaires à la requête SQL
        for (String fieldName : fieldMap.keySet()) {
            // Echappement du champ ADDRESS et des champs non mettables à jour
            if (fieldMap.get(fieldName).getDescribe().type != Schema.DisplayType.ADDRESS
                    && fieldMap.get(fieldName).getDescribe().isUpdateable()) {
                csv += '"' + fieldName.toUpperCase() + '",';
                query += fieldName + ',';
            }
        }
        System.debug('>>>> csv : ' + csv);

        // Suppression dernière virgule
        query = query.substring(0, query.length() - 1);
        query += '\n FROM ' + OBJECT_NAME_USER;
        csv = csv.substring(0, csv.length() - 1);
        csv += '\n';

        List<User> users = Database.query(query);

        // Remplissage du csv, non traitement du champ system.address, et changement des valeurs null en valeurs vides
        for (User user : users) {
            for (String field : fieldMap.keySet()) {
                // Echappement du champ ADDRESS et des champs non mettables à jour
                if (fieldMap.get(field).getDescribe().type != Schema.DisplayType.ADDRESS
                        && fieldMap.get(field).getDescribe().isUpdateable()) {
                    // Traitement si champ null
                    if (user.get(field) == null) {
                        csv += '"",';
                    } // Traitement escapeCsv pour les champs de type STRING et TEXTAREA
                    else if (fieldMap.get(field).getDescribe().type == Schema.DisplayType.STRING ||
                            fieldMap.get(field).getDescribe().type == Schema.DisplayType.TEXTAREA) {
                        csv += ((String) user.get(field)).escapeCsv() + ',';
                    } else {
                        csv += '"' + user.get(field) + '",';
                    }
                }
            }
            csv += '\r';
        }

        // Suppression du \r et de la dernière "," à la fin du traitement
        csv = csv.substring(0, csv.length() - 2);

        // Génération et enregistrement du fichier Csv
        DataExtractUtils.generateCsvFile(csv, OBJECT_NAME_USER, '02');
    }
}