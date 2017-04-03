/**
 * Created by Julie NGUYEN - Modis on 23/03/2017.
 * Handler pour le trigger EventTrigger
 */

public class EventTriggerHandler extends TriggerHandler {

    private static final Id ID_PROD = '00Dw0000000Cp11EAC';
    private static final Id ID_INT = '00D6E000000CvrTUAS';
    private static final Id ID_FULL = '00D5E0000008kwVUAQ';
    private static final Id ID_SANDBOX1 = '00D5E0000008kwyUAA';

    public EventTriggerHandler() {}

    protected override void beforeInsert() {
        System.debug('--- BEGIN EventTriggerHandler beforeInsert() ---');

        // Récupération des nouveaux événements
        List<Event> events = (List<Event>) Trigger.new;

        // Vérification qu'on est bien dans le cas d'une insertion de données de la production vers une sandbox
        for (Event e : events) {
            if (!UserInfo.getOrganizationId().equals(ID_PROD) &&
                    !UserInfo.getOrganizationId().equals(ID_INT) &&
                    !UserInfo.getOrganizationId().equals(ID_FULL) &&
                    !UserInfo.getOrganizationId().equals(ID_SANDBOX1)) {
                if (e.TECH_External_What_Id__c != null || e.TECH_External_Who_Id__c != null) {

                /**
                Attribution du premier contact trouvé aux événements pour pouvoir les insérer
                car les champs polymorphiques WhatId et WhoId ne peuvent pas faire référence à des External Id
                 */

                    // Récupération d'un contact quelconque afin de permettre l'insertion des événements dans la sandbox
                    Contact contact = [SELECT Id FROM Contact LIMIT 1];

                    System.debug('-- PARAM contact retrieved : ' + contact );

                    // Attribution de ce contact au champ WhoId des nouveaux événements
                    for (Event event : events) {
                        event.WhoId = contact.Id;
                    }
                    System.debug('-- PARAM event.WhoId : ' + event.WhoId);
                    System.debug('-- PARAM contact.Id : ' + contact.Id);
                }
            }
        }

        System.debug('--- END EventTriggerHandler beforeInsert() ---');
    }

    /**
    Lors d'un transfert de données entre la production et une sandbox :
    Méthode qui récupère les valeurs contenues dans les champs TECH_External_What_Id__c et TECH_External_Who_Id__c
    afin de les réattribuer aux champs WhatId et WhoId
     */
    public override void afterInsert() {
        System.debug('--- BEGIN EventTriggerHandler afterInsert() ---');

        /**
         Si les champs TECH_External_What_Id__c et TECH_External_Who_Id__c ne sont pas vides, on réattribue leur
         valeur à WhatId et/ou à WhoId. Sinon, on remet le champ à null (car précédemment nous avons inséré un
         contact au champ WhoId pour permettre l'insertion, mais il n'avait rien à voir avec les événements)
          */
        List<Event> eventsJustInserted = (List<Event>) Trigger.new;
        Set<Id> ids = new Set<Id>();

        // Création d'une copie des nouveaux événements pour pouvoir les mettre à jour plus tard
        for (Event event : eventsJustInserted) {
            System.debug('-- event after insert : ' + event);
            ids.add(event.Id);
        }
        String queryString = 'SELECT Id, WhoId, WhatId, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Event WHERE ID IN '
                + DataExtractUtils.convertSetToString(ids);
        List<Event> events = Database.query(queryString);

        for (Event event : events) {
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
        update events;

        System.debug('--- END EventTriggerHandler afterInsert() ---');
    }
}