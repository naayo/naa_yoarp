trigger OpportunityAfterUpdate on Opportunity (after update) {
    if (PAD.canTrigger('TR003ManageOpportunities')){ 
        Map<ID,RecordType> rt_Map = New Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Opportunity']);
        Set<Id> idContacts = new Set<Id>();
        Set<Id> sContactRoles = new Set<Id>();
        List<Opportunity> oppToUpdateContacts = new List<Opportunity>();
        List<Opportunity> oppToUpdateContactRoles = new List<Opportunity>();
        Set<Id> sOpportunities = new Set<Id>();
        
        List<OpportunityContactRole> lContactsRoles = new List<OpportunityContactRole>();

        // on construit un tableau des opportunités ayant un rôle 'Contact central' rattaché 
        List<Opportunity> oppToUpdateContactsRole = new List<Opportunity>();  
        
               
        for(Opportunity o: trigger.new){
            if (o.Contact_central__c!=null) {
                idContacts.add(o.Contact_central__c );
                
                // on vérifie si l'opportunité en cours de modification ne possède pas de rôle contact central
                // Si elle n'en possède pas on l'ajoute au tableau qui sera passé en paramètre afin de créer le rôle
                
                // sauvegarde de  l'opportunité pour les ajouts de rôle contact central 
                sOpportunities.add(o.Id);
                oppToUpdateContactRoles.add(o);
            }
            
            // Changed Old new Amount
            /*
            System.debug('####o.RecordType.Name'+o.RecordType.Name);
            System.debug('####o.stageName'+o.stageName);
            System.debug('o.Contact_central__c'+o.Contact_central__c);
			*/
            // Changer les valeurs en dur par des étiquettes 
            // Seules les opportunités dont la date de rentée
            //  / date cloture (champ technique : CloseDate) est supérieure à J – X années
            //   (X étant une valeur contenue dans une étiquette personnalisée dans le cas où celle-ci serait amenée à changer) 
            //   et J étant la date d’aujourd’hui.
            
            if ((rt_map.get(o.recordTypeID).name.containsIgnoreCase('Fundraising B2C')|| rt_map.get(trigger.oldMap.get(o.Id).recordTypeID).name.containsIgnoreCase('Fundraising B2C') ) && (o.stageName== 'Conclu' || trigger.oldMap.get(o.Id).stageName=='Conclu') && o.Contact_central__c!=null
               )
            {
                oppToUpdateContacts.add(o);
                
            }
        }
        
    lContactsRoles= [select OpportunityId from OpportunityContactRole where Role = 'Contact central' and OpportunityId in:sOpportunities];
        
        for(OpportunityContactRole ocr: lContactsRoles){
            
            sContactRoles.add(ocr.OpportunityId);
          
        }    
   
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