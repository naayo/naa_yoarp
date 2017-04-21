/* 
 * Créé par Tom CHAMART - MODIS
 * Le 25/01/2017
*/
trigger ContactAfterInsert on Contact (after insert){    
    if(PAD.canTrigger('TR008ManageDiplomes')){        
        // Mettre à jour le nombre de diplômés de chaque compte et de leur groupe
        TR008ManageDiplomes.updateDiplomesOfContacts(Trigger.New);        
    }    
}