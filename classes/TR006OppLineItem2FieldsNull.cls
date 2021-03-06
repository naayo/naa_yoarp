public class TR006OppLineItem2FieldsNull{


    public static void initOpportunityLineItem(List<OpportunityLineItem> oliList) { 
        for (OpportunityLineItem newPO : oliList)
        {
            newPO.CodeAgresso_Poste_Opportunite__c = null;
            newPO.InterfaceExternalId__c = null;
        }
    }
    
    /*
     * Fonction de mise à jour des Champs : OCTA__c et Description
     * Seules sont concernées les Opportunités de type : TAXE
     */
    public static void initFieldOpportunityLineItem (List<OpportunityLineItem> opportunityLineItemsToInsert) {
        // Rassemblement des lignes de produits par Opportunité
        // Id: Id de l'opportunité
        Map<Id, List<OpportunityLineItem>> oppLineByOpp = new Map<Id, List<OpportunityLineItem>>();
        for(OpportunityLineItem oppLineItem : opportunityLineItemsToInsert) {
            if (oppLineByOpp.containsKey(oppLineItem.OpportunityId)) {
                oppLineByOpp.get(oppLineItem.OpportunityId).add(oppLineItem);
            } else {
                // List<OpportunityLineItem> newOppLines = new List<OpportunityLineItem>();
               // newOppLines.add(oppLineItem);                
                oppLineByOpp.put(oppLineItem.OpportunityId, new List<OpportunityLineItem>{ oppLineItem });
            }
        }
        
        // Récupération des Opportunités pour obtenir le RecordType des Opportunités (modification pour récupérer les oppportunité ayant le recordtype Taxe)
        /*Map<Id, Opportunity> opportunities = new Map<Id, Opportunity>([SELECT Id, RecordTypeId FROM Opportunity WHERE Id IN :oppLineByOpp.keySet()
                                                                      AND RecordTypeId IN (SELECT Id FROM RecordType WHERE DeveloperName = 'Taxe' AND sObjectType = 'Opportunity')
                                                                      ]);*/
        
        //////////	EMERGENCY DEBUG	 ////////////
       // System.debug('TR006OppLineItem2FieldsNull - initFieldOpportunityLineItem - number of references to opportunities that don\'t exist : '
        //             + (oppLineByOpp.keySet().size() - opportunities.size()) );
        //////////	END OF EMERGENCY DEBUG	 ////////////
        
        // Mise en mémoire de l'ID du RecordType TAXE sur les Opportunités
       // Id recordTypeTaxeId = [SELECT Id, sObjectType FROM RecordType WHERE DeveloperName = 'Taxe' AND sObjectType = 'Opportunity'].Id;
      //  System.debug('RECORD TYPE 01 :' + recordTypeTaxeId);
        
        // Déclarion des variables utilisées pour stocker la valeurs par défaut
        String descriptionD ;
        String octaD ;      
            for(Opportunity opp: [SELECT Id FROM Opportunity WHERE Id IN :oppLineByOpp.keySet()
                           AND RecordTypeId IN (SELECT Id FROM RecordType WHERE DeveloperName = 'Taxe' AND sObjectType = 'Opportunity')
                                                                      ]){                                                                     
              
                 // Pour chaque ligne de produit on détermine la valeur par défaut s'il elle n'est pas déjà mise en mémoire
                for (OpportunityLineItem oli : oppLineByOpp.get(opp.Id)) {
                    if (String.isEmpty(descriptionD) && oli.Description != null) {
                        descriptionD = oli.Description;
                    }
                    if(String.isEmpty(octaD) && oli.OCTA__c != null) {
                        octaD = oli.OCTA__c;
                    }
                     if(String.isEmpty(oli.Description)) {
                        oli.Description = descriptionD;
                    }
                    if(String.isEmpty(oli.OCTA__c)) {
                        oli.OCTA__c = octaD;
                    }
                    if(String.isNotEmpty(descriptionD) && String.isNotEmpty(octaD)) {
                        break;
                    }
                }
            }
            
        
        /*for(Id oppId : oppLineByOpp.keySet()) {            
           
            
            
            if (opportunities.get(oppId).RecordTypeId == recordTypeTaxeId) {
                descriptionD =  null;
                octaD = null;
                
                // Pour chaque ligne de produit on détermine la valeur par défaut s'il elle n'est pas déjà mise en mémoire
                for (OpportunityLineItem oli : oppLineByOpp.get(oppId)) {
                    if (String.isEmpty(descriptionD) && oli.Description != null) {
                        descriptionD = oli.Description;
                    }
                    if(String.isEmpty(octaD) && oli.OCTA__c != null) {
                        octaD = oli.OCTA__c;
                    }
                    if(String.isNotEmpty(descriptionD) && String.isNotEmpty(octaD)) {
                        break;
                    }
                }
                
                // Pour chaque ligne de produit mise à jour avec les valeurs pas défaut si aucune valeur n'est saisi
                for(OpportunityLineItem oli : oppLineByOpp.get(oppId)) {
                    if(String.isEmpty(oli.Description)) {
                        oli.Description = descriptionD;
                    }
                    if(String.isEmpty(oli.OCTA__c)) {
                        oli.OCTA__c = octaD;
                    }
                }
            }
        }*/
    }
    
}