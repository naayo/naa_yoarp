/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Handler pour le trigger TaskTrigger
 */

public class TaskTriggerHandler extends TriggerHandler {

    // Maps and list initialized from the Trigger context
    private Map<Id, Task> oldMap;
    private Map<Id, Task> newMap;
    private List<Task> oldList;
    private List<Task> newList;

    // Constructor
    public TaskTriggerHandler() {
        this.oldMap = (Map<Id, Task>) Trigger.oldMap;
        this.newMap = (Map<Id, Task>) Trigger.newMap;
        this.oldList = (List<Task>) Trigger.Old;
        this.newList = (List<Task>) Trigger.New;
    }

    protected override void beforeInsert() {
        System.debug('--- BEGIN TaskTriggerHandler beforeInsert() ---');

        for (Task t : this.newList) {

            // Vérification qu'on est bien dans le cas d'une insertion de données de la production vers une sandbox
            if (t.TECH_Is_Record_Transferring__c) {
                if (t.TECH_External_What_Id__c != null || t.TECH_External_Who_Id__c != null) {

                /**
                Attribution du premier contact trouvé aux tâches pour pouvoir les insérer
                car les champs polymorphiques WhatId et WhoId ne peuvent pas faire référence à des External Id
                 */

                    // Récupération d'un contact quelconque afin de permettre l'insertion des tâches dans la sandbox
                    Contact contact = [SELECT Id FROM Contact LIMIT 1];

                    System.debug('-- PARAM contact retrieved : ' + contact );

                    // Attribution de ce contact au champ WhoId des nouvelles tâches
                    t.WhoId = contact.Id;

                    System.debug('-- PARAM t.WhoId : ' + t.WhoId);
                    System.debug('-- PARAM contact.Id : ' + contact.Id);
                }
            }
        }
        System.debug('--- END TaskTriggerHandler beforeInsert() ---');
    }

    public override void afterInsert() {
        System.debug('--- BEGIN TaskTriggerHandler afterInsert() ---');

        List<Task> tasksJustInserted = (List<Task>) Trigger.new;
        // tasksToUpdateAfterInsert est une variable qui pourra être réutilisée pour des update en after insert
        List<Task> tasksToUpdateAfterInsert = new List<Task>();
        Set<Id> ids = new Set<Id>();

        for (Task task : tasksJustInserted) {
            System.debug('-- task after insert : ' + task);
            ids.add(task.Id);
        }

        /*
         Vérification si nous sommes en transfert de données entre sandbox, si oui on ajoute les tasks à la liste
         tasksToUpdateAfterInsert pour les mettre à jour
          */
        List<Task> tasksInTransferBetweenSandboxs = completeWhoAndWhatIdFields(ids);
        if (tasksInTransferBetweenSandboxs != null && !tasksInTransferBetweenSandboxs.isEmpty()) {
            tasksToUpdateAfterInsert.addAll(tasksInTransferBetweenSandboxs);
        }

        if (tasksToUpdateAfterInsert != null && !tasksToUpdateAfterInsert.isEmpty()) {
            try {
                update tasksToUpdateAfterInsert;
            } catch (Exception e) {
                System.debug('Update impossible pour en after insert de Task' + e);
            }
        }

        System.debug('--- END TaskTriggerHandler afterInsert() ---');
    }

    /**
    Lors d'un transfert de données entre la production et une sandbox :
    Méthode qui récupère les valeurs contenues dans les champs TECH_External_What_Id__c et TECH_External_Who_Id__c
    afin de les réattribuer aux champs WhatId et WhoId
    Si les champs TECH_External_What_Id__c et TECH_External_Who_Id__c ne sont pas vides, on réattribue leur
    valeur à WhatId et/ou à WhoId. Sinon, on remet le champ à null (car précédemment nous avons inséré un
    contact au champ WhoId pour permettre l'insertion, mais il n'avait rien à voir avec les événements)
    */
    private static List<Task> completeWhoAndWhatIdFields(Set<Id> ids) {
        // Vérification qu'on est dans le cas d'un transfert de données avec le champ TECH_Is_Record_Transferring__c à true
        String queryString = 'SELECT Id, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Task ' +
                'WHERE TECH_Is_Record_Transferring__c = true AND ID IN '
                + DataExtractUtils.convertSetToString(ids);
        List<Task> tasks = Database.query(queryString);

        if (tasks == null || tasks.isEmpty()){
            return null;
        }

        for (Task task : tasks) {
            /* On repasse le champ TECH_Is_Record_Transferring__c à false pour que les enregistrements ne repassent
             plus dans cette partie de code
              */
            task.TECH_Is_Record_Transferring__c = false;
            if (task.TECH_External_Who_Id__c != null) {
                System.debug('-- TaskTriggerHandler : task.TECH_External_Who_Id__c : ' + task.TECH_External_Who_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_Who_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(task.TECH_External_Who_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE TECH_External_Id__c = \''
                        + task.TECH_External_Who_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                task.WhoId = obj.Id;
                System.debug('-- TaskTriggerHandler : task.WhoId : ' + task.WhoId);
            }

            if ( task.TECH_External_What_Id__c != null && task.TECH_External_Who_Id__c == null ) {
                /*
                 Retour à une valeur WhoId null dans le cas où à l'insertion on est rentré dans le TaskTrigger en beforeInsert,
                 c'est-à-dire qu'on a attribué une valeur de contact juste pour permettre l'insertion
                  */
                task.WhoId = null;
                System.debug('>> TaskTriggerHandler  : task.whoId passé à null ? : ' + task.WhoId);
            }

            if (task.TECH_External_What_Id__c != null) {
                System.debug('-- TaskTriggerHandler : task.TECH_External_What_Id__c : ' + task.TECH_External_What_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_What_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(task.TECH_External_What_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE TECH_External_Id__c = \''
                        + task.TECH_External_What_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                task.WhatId = obj.Id;

                System.debug('-- TaskTriggerHandler AfterInsert : task.WhatId similaire au TECH_External_What_Id__c ? : ' + task.WhatId);
            }
        }
        return tasks;
    }

}