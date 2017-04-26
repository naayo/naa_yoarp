/* 
* Modifié par Tom CHAMART - MODIS
* Le 27/01/2017 pour l'affectation du compte principal
*/
trigger AccountBeforeInsert on Account (before insert) {
    
    // on crée une liste des départements en dehors de la boucle d'enregistrements
    List<D_partement__c> listDpt = [select id, Code_d_partement__c from D_partement__c];
    List<Account> listAcctNew = new List<Account>();
    
    for(integer i=0;i<Trigger.New.size();i++){
        listAcctNew.add(Trigger.New[i]); 
    }
    
    Utils.setDptAccount(listAcctNew);
    
    // Affecter le compte principal des comptes ajoutés
    // Parcourir tous les comptes insérés
    Set<Id> parentIds = new Set<Id>();
    for(account acc : Trigger.New){
        parentIds.add(acc.parentId);
    }
    Map<Id,Account> parentMap = new Map<Id,Account>([SELECT Id, ComptePrincipal__c, Nombre_de_contacts_dipl_m_s_groupe__c FROM Account WHERE Id IN: parentIds]);
    for(account acc : Trigger.New){
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
            // On affecte le nombre de diplômés du groupe avec celui de son parent
            acc.Nombre_de_contacts_dipl_m_s_groupe__c = parentMap.get( acc.ParentId ).Nombre_de_contacts_dipl_m_s_groupe__c;
        }
    }

}