/**
 * Created by Julie NGUYEN - Modis on 08/03/2017.
 * Classe servant au remplissage du champ TECH_External_Id__c
 * Sa classe de test est : TestBatchFillTechIdObjects
 */

global class BatchFillTechId010PortefeuilleContacts implements Database.Batchable<sObject> {
    String query = 'SELECT Id FROM Portefeuille_contacts__c WHERE Tech_External_Id__c = null';

    global Database.QueryLocator start(Database.BatchableContext bc) {
        System.debug('--- BEGIN BatchFillTechId010PortefeuilleContacts ---');
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Portefeuille_contacts__c> records){
        System.debug('--- Execute part BatchFillTechId010PortefeuilleContacts ---');
        for (Portefeuille_contacts__c portContacts : records) {
            portContacts.TECH_External_Id__c = portContacts.Id;
        }
        Database.update(records, false);
    }

    global void finish(Database.BatchableContext bc){
        System.debug('--- END BatchFillTechId010PortefeuilleContacts ---');
        if(!Test.isRunningTest()){
            Database.executeBatch(new BatchFillTechId011Etat());
        }
    }

}