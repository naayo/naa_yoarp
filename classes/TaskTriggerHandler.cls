/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Handler pour le trigger TaskTrigger
 */

public class TaskTriggerHandler extends TriggerHandler {

    private static final Id ID_PROD = '00Dw0000000Cp11EAC';
    private static final Id ID_INT = '00D6E000000CvrTUAS';
    private static final Id ID_FULL = '00D5E0000008kwVUAQ';
    private static final Id ID_SANDBOX1 = '00D5E0000008kwyUAA';

    public TaskTriggerHandler() {}

    protected override void beforeInsert() {
        System.debug('--- BEGIN TaskTriggerHandler beforeInsert() ---');

        // Récupération des nouvelles tâches
        List<Task> tasks = (List<Task>) Trigger.new;

        // Vérification qu'on est bien dans le cas d'une insertion de données de la production vers une sandbox
        for (Task t : tasks) {
            if (!UserInfo.getOrganizationId().equals(ID_PROD) &&
                    !UserInfo.getOrganizationId().equals(ID_INT) &&
                    !UserInfo.getOrganizationId().equals(ID_FULL) &&
                    !UserInfo.getOrganizationId().equals(ID_SANDBOX1)) {
                if (t.TECH_External_What_Id__c != null || t.TECH_External_Who_Id__c != null) {

                /**
                Attribution du premier contact trouvé aux tâches pour pouvoir les insérer
                car les champs polymorphiques WhatId et WhoId ne peuvent pas faire référence à des External Id
                 */

                    // Récupération d'un contact quelconque afin de permettre l'insertion des tâches dans la sandbox
                    Contact contact = [SELECT Id FROM Contact LIMIT 1];

                    System.debug('-- PARAM contact retrieved : ' + contact );

                    // Attribution de ce contact au champ WhoId des nouvelles tâches
                    for (Task task : tasks) {
                        task.WhoId = contact.Id;
                    }
                    System.debug('-- PARAM task.WhoId : ' + task.WhoId);
                    System.debug('-- PARAM contact.Id : ' + contact.Id);
                }
            }
        }
        System.debug('--- END TaskTriggerHandler beforeInsert() ---');
    }

    /**
    Lors d'un transfert de données entre la production et une sandbox :
    Méthode qui récupère les valeurs contenues dans les champs TECH_External_What_Id__c et TECH_External_Who_Id__c
    afin de les réattribuer aux champs WhatId et WhoId
     */
    public override void afterInsert() {
        System.debug('--- BEGIN TaskTriggerHandler afterInsert() ---');

        /**
         Si les champs TECH_External_What_Id__c et TECH_External_Who_Id__c ne sont pas vides, on réattribue leur
         valeur à WhatId et/ou à WhoId. Sinon, on remet le champ à null (car précédemment nous avons inséré un
         contact au champ WhoId pour permettre l'insertion, mais il n'avait rien à voir avec les tâches)
          */
        List<Task> tasksJustInserted = (List<Task>) Trigger.new;
        Set<Id> ids = new Set<Id>();

        // Création d'une copie des nouvelles tâches pour pouvoir les mettre à jour plus tard
        for (Task task : tasksJustInserted) {
            System.debug('-- task after insert : ' + task);
            ids.add(task.Id);
        }
        String queryString = 'SELECT Id, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Task WHERE ID IN '
                + DataExtractUtils.convertSetToString(ids);
        List<Task> tasks = Database.query(queryString);

        for (Task task : tasks) {
            if (task.TECH_External_Who_Id__c != null) {
                System.debug('-- task.TECH_External_Who_Id__c : ' + task.TECH_External_Who_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_Who_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(task.TECH_External_Who_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE Id = \''
                        + task.TECH_External_Who_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                task.WhoId = obj.Id;
            }

            if ( task.TECH_External_What_Id__c != null && task.TECH_External_Who_Id__c == null ) {
                /*
                 Retour à une valeur WhoId null dans le cas où à l'insertion on est rentré dans le TaskTrigger en beforeInsert,
                 c'est-à-dire qu'on a attribué une valeur de contact juste pour permettre l'insertion
                  */
                task.WhoId = null;
            }

            if (task.TECH_External_What_Id__c != null) {
                System.debug('-- task.TECH_External_What_Id__c : ' + task.TECH_External_What_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_What_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(task.TECH_External_What_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE Id = \''
                        + task.TECH_External_What_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                task.WhatId = obj.Id;
            }
        }
        update tasks;

        System.debug('--- END TaskTriggerHandler afterInsert() ---');
    }

}