/**
 * Created by Julie NGUYEN - Modis on 27/02/2017.
 */

public class DataExtractUtils {

    // Champ personnalisé à mettre à jour 'A_extraire__c'
    private static String FIELD_TO_UPDATE = 'A_extraire__c';

    /**
    Méthode qui génère un fichier Csv et l'insère dans les fichiers Chatter
     */
    public static void generateCsvFile(String csv, String objName, String nbForInsertOrder) {
        try {
            ContentVersion file = new ContentVersion(
                    title = nbForInsertOrder + '-' + objName + '.csv',
                    versionData = Blob.valueOf(csv),
                    pathOnClient = '/' + objName + '.csv'
            );
            insert file;
        } catch (Exception e) {
            System.debug('Erreur génération du csv pour l\'objet ' + objName + ' : '  + e);
        }
    }

    /**
    Méthode qui met à jour le champ 'A_extraire__c' des enregistrements que l'on passe en paramètre
     @params :
     - Boolean : valeur que l'on veut donner au champ 'A_extraire__c'
     - List<Id> : liste des id des enregistrements à mettre à jour
     - String : nom du sObject à mettre à jour
     */
    public static Boolean updateFieldBoolean (Boolean bool, List<Id> ids, String objName) {
        // Construction de la requête SOQL
        String query = 'SELECT Id, ' + FIELD_TO_UPDATE + ' FROM ' + objName + ' WHERE ID IN '+ convertListToString(ids);
        List<SObject> objectsList = Database.query(query);

        try {
            // Mise à jour du champ 'A_extraire__c' pour les enregistrements de la liste
            for(SObject objectToUp : objectsList) {
                objectToUp.put(FIELD_TO_UPDATE, bool);
            }
            update objectsList;
            return true;
        } catch (Exception e) {
            System.debug('Erreur dans la mise à jour de l\'objet ' + objName + '. : ' + e.getMessage());
            return false;
        }
    }

    /**
    Conversion d'une List<Id> en une String compatible pour une requête SOQL
     */
    public static String convertListToString(List<Id> listIds){
        String listToString = '(';
        for( String item : listIds ) {
            listToString += '\'' + item + '\',';
        }
        return ( listToString.substring(0, listToString.length() - 1) + ')');
    }
}