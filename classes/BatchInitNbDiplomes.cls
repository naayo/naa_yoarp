/* 
 * Créé par Tom CHAMART - MODIS
 * Le 19/01/2017
*/
global class BatchInitNbDiplomes implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC){        
    	return Database.getQueryLocator([
				SELECT 
				    Id,ParentId,
				    Parent.ParentId, 
				    Parent.Parent.ParentId,
				    Parent.Parent.Parent.ParentId,
				    Parent.Parent.Parent.Parent.ParentId,
				    Parent.Parent.Parent.Parent.Parent.ParentId
				FROM Account
				WHERE ParentId != null
    		]);
    }
	
    global void execute(Database.BatchableContext BC, List<Account> scope){        
        // Parcourir chaque filiale
		for (Account acc:scope){
            // Assigner le compte principal du compte
			acc.ComptePrincipal__c = this.setComptePrincipal(acc);
		}
		update scope;
	}
    
    global void finish(Database.BatchableContext BC){
		// Initialiser à 0 les compteurs de diplômés
        Database.executeBatch(new BatchInitFieldsNbDiplomes());
    }    
    
    private Id setComptePrincipal(Account acc){
        // Si le compte a un parent
    	if(acc.ParentId != null){
            // Si le parent du compte n'a pas de parent
    		if(acc.Parent.ParentId == null){
                // Le parent est le compte principal du compte
    			return acc.ParentId;
    		}else{
                // Sinon on recommence avec le parent du compte
				return this.setComptePrincipal(acc.Parent);
    		}
    	}
    	return null;
    }    
}