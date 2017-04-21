/**
 * Created by Julie NGUYEN - Modis on 23/03/2017.
 * Handler pour le trigger EventTrigger
 */

public class EventTriggerHandler extends TriggerHandler {

    // Maps and list initialized from the Trigger context
    private Map<Id, Event> oldMap;
    private Map<Id, Event> newMap;
    private List<Event> oldList;
    private List<Event> newList;

    // Constructor
    public EventTriggerHandler() {
        this.oldMap = (Map<Id, Event>) Trigger.oldMap;
        this.newMap = (Map<Id, Event>) Trigger.newMap;
        this.oldList = (List<Event>) Trigger.Old;
        this.newList = (List<Event>) Trigger.New;
    }

    protected override void beforeInsert() {
        System.debug('--- BEGIN EventTriggerHandler beforeInsert() ---');

        for (Event e : this.newList) {

            // Vérification qu'on est bien dans le cas d'une insertion de données de la production vers une sandbox
            if (e.TECH_Is_Record_Transferring__c) {
                if (e.TECH_External_What_Id__c != null || e.TECH_External_Who_Id__c != null) {

                /**
                Attribution du premier contact trouvé aux événements pour pouvoir les insérer
                car les champs polymorphiques WhatId et WhoId ne peuvent pas faire référence à des External Id
                 */

                    // Récupération d'un contact quelconque afin de permettre l'insertion des événements dans la sandbox
                    Contact contact = [SELECT Id FROM Contact LIMIT 1];

                    System.debug('-- PARAM contact retrieved : ' + contact );

                    // Attribution de ce contact au champ WhoId des nouveaux événements
                    e.WhoId = contact.Id;

                    System.debug('-- PARAM e.WhoId : ' + e.WhoId);
                    System.debug('-- PARAM contact.Id : ' + contact.Id);
                }
            }
        }

        System.debug('--- END EventTriggerHandler beforeInsert() ---');
    }

    public override void afterInsert() {
        System.debug('--- BEGIN EventTriggerHandler afterInsert() ---');

        List<Event> eventsJustInserted = this.newList;
        // eventsToUpdateAfterInsert est une variable qui pourra être réutilisée pour des update en after insert
        List<Event> eventsToUpdateAfterInsert = new List<Event>();
        Set<Id> ids = new Set<Id>();

        for (Event event : eventsJustInserted) {
            System.debug('-- event after insert : ' + event);
            ids.add(event.Id);
        }

        /*
         Vérification si nous sommes en transfert de données entre sandbox, si oui on ajoute les tasks à la liste
         tasksToUpdateAfterInsert pour les mettre à jour
          */
        List<Event> eventsInTransferBetweenSandboxs = completeWhoAndWhatIdFields(ids);
        if (eventsInTransferBetweenSandboxs != null && eventsInTransferBetweenSandboxs.isEmpty()) {
            eventsToUpdateAfterInsert.addAll(eventsInTransferBetweenSandboxs);
        }

        if (eventsToUpdateAfterInsert != null && !eventsToUpdateAfterInsert.isEmpty()) {
            try {
                update eventsToUpdateAfterInsert;
            } catch (Exception e) {
                System.debug('Update impossible pour en after insert d\'Event' + e);
            }
        }

        System.debug('--- END EventTriggerHandler afterInsert() ---');
    }

    /**
    Lors d'un transfert de données entre la production et une sandbox :
    Méthode qui récupère les valeurs contenues dans les champs TECH_External_What_Id__c et TECH_External_Who_Id__c
    afin de les réattribuer aux champs WhatId et WhoId
    Si les champs TECH_External_What_Id__c et TECH_External_Who_Id__c ne sont pas vides, on réattribue leur
    valeur à WhatId et/ou à WhoId. Sinon, on remet le champ à null (car précédemment nous avons inséré un
    contact au champ WhoId pour permettre l'insertion, mais il n'avait rien à voir avec les événements)
    */
    private static List<Event> completeWhoAndWhatIdFields(Set<Id> ids) {
        // Vérification qu'on est dans le cas d'un transfert de données avec le champ TECH_Is_Record_Transferring__c à true
        String queryString = 'SELECT Id, WhoId, WhatId, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Event ' +
                'WHERE TECH_Is_Record_Transferring__c = true AND ID IN '
                + DataExtractUtils.convertSetToString(ids);
        List<Event> events = Database.query(queryString);

        if (events == null || events.isEmpty()){
            return null;
        }

        for (Event event : events) {
            /* On repasse le champ TECH_Is_Record_Transferring__c à false pour que les enregistrements ne repassent
             plus dans cette partie de code
              */
            event.TECH_Is_Record_Transferring__c = false;
            if (event.TECH_External_Who_Id__c != null) {
                System.debug('-- event.TECH_External_Who_Id__c : ' + event.TECH_External_Who_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_Who_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(event.TECH_External_Who_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE Id = \''
                        + event.TECH_External_Who_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                event.WhoId = obj.Id;
            }

            if ( event.TECH_External_What_Id__c != null && event.TECH_External_Who_Id__c == null ) {
                /*
                 Retour à une valeur WhoId null dans le cas où à l'insertion on est rentré dans l'EventTrigger en beforeInsert,
                 c'est-à-dire qu'on a attribué une valeur de contact juste pour permettre l'insertion
                  */
                event.WhoId = null;
            }

            if (event.TECH_External_What_Id__c != null) {
                System.debug('-- event.TECH_External_What_Id__c : ' + event.TECH_External_What_Id__c);

                // Récupération du nom de l'objet en fonction du préfixe du TECH_External_What_Id__c
                String objName = Utils.findObjectNameFromRecordIdPrefix(event.TECH_External_What_Id__c);

                // Récupération de l'ID de l'objet
                String query = 'SELECT ID FROM ' + objName + ' WHERE Id = \''
                        + event.TECH_External_What_Id__c + '\'';

                System.debug('-- Query : ' + query);

                sObject obj = Database.query(query);

                // Attribution de l'ID récupéré au champ WhoId
                event.WhatId = obj.Id;
            }
        }
        return events;
    }
}