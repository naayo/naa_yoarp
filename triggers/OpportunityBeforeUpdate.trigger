trigger OpportunityBeforeUpdate on Opportunity (before update) {
    
    
    
    List<Opportunity> lOpp = new List<Opportunity>();
    
    String oldOwnerId;
    // cette partie de trigger n'est utilisé que lorsque l'on est en mode saisie manuelle
    // elle ne s'exécute pas pour les traitements en rafale exécutés sur un tableau
    // d'enregistrements
    if (Trigger.new.size() == 1){
        for(Opportunity o: Trigger.New){
            
            oldOwnerId = Trigger.oldMap.get(o.ID).ownerId;
          
            if (  o.OwnerId != Trigger.oldMap.get(o.ID).ownerId  ) {  
                
                lOpp.add(o);
                
                
            }
        }
        
    }
    if(lOpp.size()==1){
        TR003ManageOpportunities.checkOwnerIdChange(lOpp, oldOwnerId);
    }
}