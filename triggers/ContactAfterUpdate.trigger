/* 
 * Créé par Tom CHAMART - MODIS
 * Le 25/01/2017
 * Modifié le 05/05/2017 pour vérifier la modification du champ Identifiant_dipl_m__c
*/
trigger ContactAfterUpdate on Contact (after update){
	if(PAD.canTrigger('TR008ManageDiplomes')){
		// Vérifier si le champ Identifiant_dipl_m__c a été modifié
		List<Contact> ctcsToUpdate = new List<Contact>();
		for (Contact cNew : Trigger.New) {
			// Si le champ Identifiant_dipl_m__c a été modifié
            if (Trigger.oldMap.get(cNew.Id).Identifiant_dipl_m__c != cNew.Identifiant_dipl_m__c) {
        		// Ajouter le contact à la liste de MàJ
                ctcsToUpdate.add(cNew);
            }
        }

		if(ctcsToUpdate.size() != 0){        
		    // Mettre à jour le nombre de diplômés de chaque compte et de leur groupe
		    TR008ManageDiplomes.updateDiplomesOfContacts(ctcsToUpdate);       
		}
	}
	
}