/**
* Implementation of the Pickup request for the UPS Shipping Carrier.
*
* Created by: Mehdi EL BILALI (mehdi.elbilali@kerensen.com), 06/03/2015.
* Last modified by: Mehdi EL BILALI
*/

trigger OpportunityAfterInsert on Opportunity (after insert) {
    
    if (PAD.canTrigger('TR003ManageOpportunities')){
        Map<ID,RecordType> rt_Map = New Map<ID,RecordType>([Select ID, Name From RecordType Where sObjectType = 'Opportunity']);
        List<Opportunity> oppToUpdateContacts = new List<Opportunity>();  
        Set<Id> idContacts = new Set<Id>();
        List<Opportunity> oppToUpdateContactsRole = new List<Opportunity>();  
        for(Opportunity o: trigger.new){
            
            if (o.Contact_central__c != null){
                idContacts.add(o.Contact_central__c );
                oppToUpdateContactsRole.add(o);
            }
            
            if (    rt_map.get(o.recordTypeID).name.containsIgnoreCase('Fundraising B2C')
                &&  o.stageName== 'Conclu'
                &&  o.Contact_central__c!=null
               ){
                oppToUpdateContacts.add(o);
            }

        }
        if (!idContacts.isEmpty()) 
        {   
            TR003ManageOpportunities.UpdateOppsNumber(idContacts);
            TR003ManageOpportunities.createContactRole(oppToUpdateContactsRole);
        }
        if (!oppToUpdateContacts.isEmpty()){
            TR003ManageOpportunities.UpdateContact(oppToUpdateContacts);
        }
    }
    
    System.debug('### test debug message');
    
 //RM   List<Portefeuille_contacts__c> pcList = new List<Portefeuille_contacts__c>();
    
    // Get the related Portefeuille contacts for the opportunities in this trigger
    //      Map<Id,Opportunity> oppWithPCs = new Map<Id,Opportunity>([SELECT Id,(SELECT Id FROM Portefeuille_contacts__c) FROM Opportunity WHERE Id IN :Trigger.New]);
    
    
    
    // Add an portefeuille for each opportunity if it doesn't already have one.
    // Iterate through each opportunity.
//RM    for(Opportunity opp : Trigger.New) {
        
//RM    System.debug('### test debug message 1');
//RM        System.debug(opp.CreatedById + ' ' + opp.Contact_central__c);
//RM        System.debug([SELECT Id FROM Portefeuille_contacts__c WHERE CreatedByID= :opp.CreatedByID and Contact__c= :opp.Contact_central__c]);
//RM        List<Portefeuille_contacts__c> pcList2 = [SELECT Id FROM Portefeuille_contacts__c WHERE CreatedByID= :opp.CreatedByID and Contact__c= :opp.Contact_central__c];
//RM        if(pcList2.size() == 0 )
//RM        { System.debug('### pcList2 vide');
            // If it doesn't, add a default portefeuille
//RM            pcList.add(new Portefeuille_contacts__c(Contact__c=opp.Contact_central__c,
//RM                                                    User__c=opp.CreatedByID,
//RM                                                CreatedByID=opp.CreatedByID));
            
//RM        }          
//RM    }
    
//RM    if (pcList.size() > 0  ) {
//RM        insert pcList;
//RM    }
    
}