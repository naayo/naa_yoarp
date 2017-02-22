trigger LeadConvert on Lead (after update) {
	
	IF (PAD.canTrigger('TR004ManageLead')){  
		
		
	//no bulk processing; will only run from the UI
	if (Trigger.new.size() == 1) {
	
	    // on recherche l'id des record type, l'id de l'opportunité convertie dépend uniquement de l'id 
	    
	    RecordType RTpiste = [SELECT Name FROM RecordType WHERE Id = :Trigger.old[0].RecordTypeId];
	    RecordType RTopport = [Select  Name, Id  From RecordType Where sObjectType = 'Opportunity' AND Name= : RTpiste.name ];
	
    	if (Trigger.old[0].isConverted == false && Trigger.new[0].isConverted == true) {
			if(Trigger.new[0].ConvertedContactId!=null && Trigger.new[0].ConvertedOpportunityId!=null){
				
				 System.debug('RecordType de la piste' + RTpiste.name );
				 System.debug('RecordType cible' + RTopport.name);
				 
				TR004ManageLead.LeadConvertion(Trigger.new[0].ConvertedContactId, RTopport  , Trigger.new[0].ConvertedOpportunityId);
			}
    	}
	}
	}
}