trigger TriggerContactBeforeDelete on Contact (before delete) {
    for(Contact c: trigger.old)
    {
        if(c.Membre_vie__c == true)            
        {   
            System.debug('Membre_vie__c = true');
            c.adderror('Ce contact ne peux pas être supprimé car il est synchronisé avec Forever');
     	} 
    }     
}