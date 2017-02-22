global class BatchDeleteEmailProfessionnelEtudiantMAV implements Database.Batchable<sObject> {
    
    List<Contact> contactUpdate = new List<Contact>();

    global BatchDeleteEmailProfessionnelEtudiantMAV() {
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select ID, Record_Type_Name__c, Email_de_repli__c FROM Contact WHERE Membre_vie__c=true AND Record_Type_Name__c=\'Etudiant\'';
        return Database.getQueryLocator(query);
    }
    
    global void execute(Database.BatchableContext BC, List<Contact> scope){
        Database.DMLOptions dml = new Database.DMLOptions();
		dml.DuplicateRuleHeader.AllowSave = true;
        
        for(Contact c : scope){
            if(c.Record_Type_Name__c == 'Etudiant'){
                c.Email_de_repli__c='';
                contactUpdate.add(c);               
            }
        }
        
        Database.update(contactUpdate,dml);        
    }
    
    global void finish(Database.BatchableContext BC){
     
    }
}