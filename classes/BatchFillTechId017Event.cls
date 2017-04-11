/**
 * Created by Julie NGUYEN - Modis on 21/03/2017.
 * Classe servant au remplissage des champs TECH_External_What_Id__c et TECH_External_Who_Id__c
 * Sa classe de test est : TestBatchFillTechId017Event
 */

global class BatchFillTechId017Event implements Database.Batchable<sObject> {
    String query = 'SELECT WhoId, WhatId FROM Event WHERE Tech_External_What_Id__c = null AND Tech_External_What_Id__c = null';

    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('--- BEGIN BatchFillTechId017Event ---');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Event> records){
        System.debug('--- Execute part BatchFillTechId017Event ---');
        for (Event event : records) {
            // Remplissage du champ TECH_External_What_Id__c
            if (event.WhatId != null) {
                event.TECH_External_What_Id__c = event.WhatId;
            }

            // Remplissage du champ TECH_External_Who_Id__c
            if (event.WhoId != null) {
                event.TECH_External_Who_Id__c = event.WhoId;
            }
        }
        update records;
    }

    global void finish(Database.BatchableContext bc){
        System.debug('--- END BatchFillTechId017Event ---');
    }
}