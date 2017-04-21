/* 
* Créé par Tom CHAMART - MODIS
* Le 27/01/2017
*/
trigger AccountAfterUpdate on Account (after update) {
    if(PAD.canTrigger('AccountAfterUpdate')){
        // Mettre à jour les comptes principaux des hiérarchies concernés par les comptes modifiés
        // Récupérer les comptes où le parent a été modifié
        Map<Id,Account> mpAccountsConcernes = new Map<Id,Account>();
        for(account acc : Trigger.New) if(acc.ParentId != Trigger.OldMap.get(acc.Id).ParentId){
            mpAccountsConcernes.put(acc.Id,acc);
        }
        
        // Mettre à jour les comptes principaux des comptes (et de leurs filiales)
        // On donne l'ancienne map pour retrouver la valeur de l'ancien compte principal
        if(mpAccountsConcernes.size() > 0){
            TR009PropagationHierarchie.updateComptePrincipalAfterUpdate(Trigger.OldMap,mpAccountsConcernes);    
        }
        
        // Calculer le nouveau nombre de diplomés des hiérarchies concernés par les comptes modifiés
        // Récupérer les anciens et nouveaux comptes principaux 
        List<Id> toCalculate = new List<Id>(); 
        for(account acc : Trigger.New){
            // Si le parent a changé
            if(acc.ParentId != Trigger.OldMap.get(acc.Id).ParentId){
                // Si le compte modifié est devenu compte principal
                if(acc.ComptePrincipal__c == null){
                    // Ajouter ce compte principal a être recalculé
                    toCalculate.add(acc.Id);
                }else{
                    // Ajouter son compte principâl à être recalculé
                    toCalculate.add(acc.ComptePrincipal__c);	
                }
                
                // Ajouter l'ancien compte principal à être recalculé
                toCalculate.add(Trigger.OldMap.get(acc.Id).ComptePrincipal__c);
            }           
        }
        
        // Mettre à jour les anciens et nouveaux comptes principaux
        // pour actualiser les nombre de diplômés des groupes
        if(toCalculate.size() > 0){
            TR008ManageDiplomes.updateDiplomesOfAccounts(toCalculate);    
        }   
    }
}