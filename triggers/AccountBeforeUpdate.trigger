/* 
* Modifié par Tom CHAMART - MODIS
* Le 27/01/2016 pour l'affection du nouveau compte principal
*/
trigger AccountBeforeUpdate on Account (before update) {
    if(Test.isRunningTest() && UserInfo.getName() == 'CreateContactRole') {
    return;
}
    // on crée une liste des départements en dehors de la boucle d'enregistrements
    List<D_partement__c> listDpt = [select id, Code_d_partement__c from D_partement__c];
    List<Account> listAcctNew = new List<Account>();

    for(integer i=0;i<Trigger.New.size();i++){    
        listAcctNew.add(Trigger.New[i]);   
    }    
    
    Utils.setDptAccount(listAcctNew);
    
    // Mettre à jour le compte principal des comptes modifiés
    if(PAD.canTrigger('AccountBeforeUpdate')){
        // Récupérer les nouveaux parents des comptes modifiés
        Set<Id> parentIds = new Set<Id>();
        for(account acc : Trigger.New) if(acc.ParentId != Trigger.OldMap.get(acc.Id).ParentId){
            parentIds.add(acc.parentId);
        }        
        
        // Récupérer les comptes parents
        Map<Id,Account> parentMap = new Map<Id,Account>([SELECT Id, ComptePrincipal__c FROM Account WHERE Id IN: parentIds]);
        for(account acc : Trigger.New) if(parentIds.size() >0){
            // Si le compte a toujours un parent
            if(acc.ParentId != null){            
                // Si le parent a un compte principal
                if(parentMap.get(acc.ParentId).ComptePrincipal__c != null){
                    // Affecter le compte principal du parent 
                    // au compte principal du compte ajouté
                    acc.ComptePrincipal__c = parentMap.get(acc.ParentId).ComptePrincipal__c;
                } else {
                    // Affecter le parent
                    // au compte principal du compte ajouté
                    acc.ComptePrincipal__c = acc.ParentId;
                }
            }else{
                // Le compte devient compte principal (et n'en a donc pas)
                acc.ComptePrincipal__c = null;
            }
        }
    }           
}