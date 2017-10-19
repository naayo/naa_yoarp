trigger OpportunityLineItemBeforeInsert on OpportunityLineItem (Before Insert) {
      if(PAD.isFirstBeforeOliInsertRun())
     { 
    	TR002ManageOpportunityLineItem.addProductFilter(trigger.new);
    
   	 if (PAD.canTrigger('TR006OppLineItem2FieldsNull')) {        
    	TR006OppLineItem2FieldsNull.initOpportunityLineItem(Trigger.new);
        TR006OppLineItem2FieldsNull.initFieldOpportunityLineItem(Trigger.new);
  	  }
	}
}