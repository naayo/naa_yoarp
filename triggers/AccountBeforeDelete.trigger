/* 
 * Modifié par Tom CHAMART - MODIS
 * Le 27/01/2017 pour la TR008 et TR009
*/
trigger AccountBeforeDelete on Account (before delete) {
    
    Set<Id> acctIds = new Set<Id>();
    Set<Id> undeletableIds = New Set<Id>();   
    
    String currentUrl = URL.getCurrentRequestUrl().toExternalForm() ;    
    
    for(Account acc : Trigger.Old){
        acctIds.add(acc.id);
    }
    
    for(Opportunity o : [select AccountId from Opportunity where AccountId  in:acctIds]){
        undeletableIds.add(o.AccountId);
    }
    
    for(Account acc : Trigger.Old){        
        // on vérifie à la fois si le compte en question figure dans la liste des comptes
        // possédants des opportunités et on vérifie également que l'on est pas en mode fusion de compte
        // en vérifiant que l'url appelée ne fait pas référence au module de fusion accmergewizard
        
        if(undeletableIds.contains(acc.Id) && !currentURL.contains('accmergewizard') ){
            acc.Name.addError('<span style="color:red;font-size:14px;"><b>Vous ne pouvez pas supprimer ce compte car il contient des opportunités !</b></span><p>Si vous souhaitez vraiment supprimer ce compte, veuillez d\'abord supprimer toutes les opportunités associées à ce compte.',false);
            return;
        }       
    }
    
    // pour ne pas perturber le recalcul
    PAD.addTriggerBypass('AccountBeforeUpdate');
    PAD.addTriggerBypass('AccountAfterUpdate');
    
    // Mettre à jour les comptes principaux des hiérarchies
    // où des comptes supprimés sont présents
    Set<Id> sComptePrincipal = new Set<Id>();
    if(PAD.canTrigger('TR009PropagationHierarchie')){
        sComptePrincipal = TR009PropagationHierarchie.updateHierarchyBeforeDelete(Trigger.OldMap);
    }
    
    // Recalculer les nombres de diplômés pour tous les comptes concernés
    if(PAD.canTrigger('TR008ManageDiplomes')){
        // Mettre à jour le nombre de diplômés de chaque compte principal et de leur groupe
        TR008ManageDiplomes.updateGroupOfAccounts(sComptePrincipal);
    }
    
    PAD.removeTriggerBypass('AccountBeforeUpdate');   
    PAD.removeTriggerBypass('AccountAfterUpdate');
}