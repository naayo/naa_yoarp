trigger AccountBeforeInsert on Account (before insert) {

// on crée une liste des départements en dehors de la boucle d'enregistrements
List<D_partement__c> listDpt = [select id, Code_d_partement__c from D_partement__c];
List<Account> listAcctNew = new List<Account>();

for(integer i=0;i<Trigger.New.size();i++){
    
     
     listAcctNew.add(Trigger.New[i]);
    
 
    
    }
    
     Utils.setDptAccount(listAcctNew, listDpt);

}