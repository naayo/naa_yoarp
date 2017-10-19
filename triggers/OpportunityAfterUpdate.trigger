trigger OpportunityAfterUpdate on Opportunity (after update) {
    if (PAD.canTrigger('TR003ManageOpportunities')){ 
   
  
        RecordType FundraisingB2C= [Select ID From RecordType Where sObjectType = 'Opportunity' And name like '%Fundraising B2C%'];
        Set<Id> idContacts = new Set<Id>();
        Set<Id> sContactRoles = new Set<Id>();
        List<Opportunity> oppToUpdateContacts = new List<Opportunity>();
        List<Opportunity> oppToUpdateContactRoles = new List<Opportunity>();
        Set<Id> sOpportunities = new Set<Id>();
         
        for(Opportunity o: Trigger.new){
            // on vérifie si l'opportunité en cours de modification ne possède pas de rôle contact central   
            if(o.Contact_central__c!=null) 
            {
                // Si elle n'en possède pas on l'ajoute au tableau qui sera passé en paramètre afin de créer le rôle 
                idContacts.add(o.Contact_central__c );
                
                // sauvegarde de  l'opportunité pour les ajouts de rôle contact central 
                sOpportunities.add(o.Id);
                oppToUpdateContactRoles.add(o);
            }
            
            if((o.recordTypeID == FundraisingB2C.Id)||(Trigger.oldMap.get(o.Id).recordTypeID == FundraisingB2C.Id ) 
                && (o.stageName== 'Conclu' || trigger.oldMap.get(o.Id).stageName=='Conclu'))
            {
                oppToUpdateContacts.add(o);
                
            }
        }
        
        //List<OpportunityContactRole> lContactsRoles= [select OpportunityId from OpportunityContactRole where Role = 'Contact central' and OpportunityId in:sOpportunities];
        
        for(OpportunityContactRole ocr: [select OpportunityId from OpportunityContactRole where Role = 'Contact central' and OpportunityId in:sOpportunities]){
            sContactRoles.add(ocr.OpportunityId);
        }  
        
        List<Opportunity> oppToUpdateContactsRole = new List<Opportunity>();  
        // s'il n'existe aucun rôle du contact, on fait l'appel de fonction pour créer le rôle "contact central"
        for(Opportunity o:oppToUpdateContactRoles){
            // on vérifie si l'opportunité en cours de modification ne possède pas de rôle contact central
            // Si elle n'en possède pas on l'ajoute au tableau qui sera passé en paramètre afin de créer le rôle
            if(sContactRoles.contains(o.Id)!=true){
                oppToUpdateContactsRole.add(o);
            }
        }
        
        if(oppToUpdateContactsRole.size()>0){
            TR003ManageOpportunities.createContactRole(oppToUpdateContactsRole);
        }
   
        if(!idContacts.isEmpty()){
           TR003ManageOpportunities.UpdateOppsNumber(idContacts);
           
        }
        
        if (!oppToUpdateContacts.isEmpty()){
            TR003ManageOpportunities.UpdateContact(oppToUpdateContacts);
        }
    }
    
}