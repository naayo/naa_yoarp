/* 
 * Créé par Tom CHAMART - MODIS
 * Le 25/01/2017
 * Modifié le 05/05/2017 pour vérifier la modification du champ Identifiant_dipl_m__c
*/
trigger ContactAfterUpdate on Contact (after update){
	if(PAD.canTrigger('TR008ManageDiplomes')){
		// Vérifier si le champ Identifiant_dipl_m__c a été modifié
		List<Contact> ctcsToUpdate = new List<Contact>();
        List<Id> acctsIdToUpdate = new List<Id>();
		for (Contact cNew : Trigger.New) {
			// Si le champ Identifiant_dipl_m__c a été modifié
            if (Trigger.oldMap.get(cNew.Id).Identifiant_dipl_m__c != cNew.Identifiant_dipl_m__c) {
        		// Ajouter le contact à la liste de MàJ
                ctcsToUpdate.add(cNew);
            }
            
            // Si le champ Account a été modifié
            if (Trigger.oldMap.get(cNew.Id).AccountId != cNew.AccountId) {
        		// Ajouter l'ancien et le nouveau compte à la liste de MàJ
                acctsIdToUpdate.add(Trigger.oldMap.get(cNew.Id).AccountId);
                acctsIdToUpdate.add(cNew.AccountId);
            }
        }

		if(ctcsToUpdate.size() != 0){        
		    // Mettre à jour le nombre de diplômés de chaque compte et de leur groupe
		    TR008ManageDiplomes.updateDiplomesOfContacts(ctcsToUpdate);       
		}
        
        if(acctsIdToUpdate.size() != 0){
            // Mettre à jour les anciens et nouveaux comptes des contacts modifiés par leurs comptes
		    TR008ManageDiplomes.updateDiplomesOfAccounts(acctsIdToUpdate);            
		}
	}
	
}