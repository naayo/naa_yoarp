trigger OpportunityLineItemAfterInsert on OpportunityLineItem (after insert) {
    if (PAD.canTrigger('TR003ManageOpportunities')){
        // ABO_20150212: Assignation de suiveur
        TR003ManageOpportunities.AssignOwnerToOppty(Trigger.newMap);
    }
    
    if (PAD.canTrigger('TR005OppLineItem')){
    // GGA 30/11 - Le trigger ne doit pas se déclencher si le champ système est rempli (il est rempli par WF à la création). En cas de clonage, le champ serait rempli donc ne se déclenche pas.
        list<OpportunityLineItem> po_clonage = new list<OpportunityLineItem>();
        for(OpportunityLineItem clonepo : trigger.new)  
         {
           if(clonepo.Champ_syst_me_pour_clonage__c == null)
           {
             po_clonage.add(clonepo);
            }
           }
        
        if (po_clonage.size() > 0)
        {
        	TR005OppLineItem.CreateOppLineItem(po_clonage);              
        }
    }
    
    //Add By mouad modifier session de formation de l'objet OpportunityLineItem de type module
        if (PAD.canTrigger('TR_session_formation')){
         set<Id> id_opp = new set<Id>();
         set<Id> id_session = new set<Id>();
         Map<Id,Session__c> map_module = new Map<Id,Session__c>();
         list<OpportunityLineItem> po_module = new list<OpportunityLineItem>();

         
         for(OpportunityLineItem po : trigger.new)  
         {
           if(po.Session_de_formation__c != null && po.Type_produit__c == 'Pack')
           {
            id_opp.add(po.OpportunityId);
            id_session.add(po.Session_de_formation__c);
           }
         }  
         po_module = [select Id, PricebookEntry.Product2Id, OpportunityId from OpportunityLineItem where Type_produit__c = 'Module' and OpportunityId IN :id_opp];
         

         for( Detail_pack_session__c  s : [select Id, Name ,Composant_session__r.Produits__c, Composant_session__c  from Detail_pack_session__c where Pack_Session__c IN :id_session ])
         {
          map_module.put(s.Composant_session__r.Produits__c,s.Composant_session__r);
          
         }
         /*
         for( Session__c  s : [select Id, Name from Session__c  where Session_de_formation_associee__c IN :id_session])
         {
          map_module.put(s.Produits__c,s);
          
         }*/
         TR_session_formation.attach_session(po_module,map_module);  
        }

}