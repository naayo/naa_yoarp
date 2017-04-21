/* 
 * Créé par Tom CHAMART - MODIS
 * Le 25/01/2017
*/
trigger ContactAfterDelete on Contact (after delete) {
	if(PAD.canTrigger('TR008ManageDiplomes')){        
        // Mettre à jour le nombre de diplômés de chaque compte et de leur groupe
        TR008ManageDiplomes.updateDiplomesOfContacts(Trigger.Old);        
    }
}