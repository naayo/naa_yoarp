/* 
 * Créé par Tom CHAMART - MODIS
 * Le 18/01/2017
*/
global class BatchCalculateNbDiplomes implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){
        // Récupérer tous les comptes
        String query = 'SELECT Id FROM Account';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Account> scope){
        // Initialiser les champs Nombre_de_contacts_dipl_m_s__c et Nombre_de_contacts_dipl_m_s_groupe__c
        TR008ManageDiplomes.initFields(new Map<Id,Account>(scope).keySet());

        // Mettre à jour le nombre de diplômés présents dans chaque compte
        TR008ManageDiplomes.updateDiplomesOfAccounts(new List<Id>(new Map<Id,Account>(scope).keySet()));
	}
    
    global void finish(Database.BatchableContext BC){
    }
}