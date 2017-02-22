public class TR005OppLineItem {
public static void CreateOppLineItem(list <OpportunityLineItem> oppLineitemsList)
{
   list <OpportunityLineItem> oppLineItemsToInsert= new list <OpportunityLineItem>();
   set<id> ProductsIds = new set<id>();
   set<id> packProductsIds = new set<id>();
   map<id,List<Detail_pack__c>> mapPackModuleProducts = new map<id,List<Detail_pack__c>>();
   List<Detail_pack__c>  moduleProducts = new List<Detail_pack__c>();
   
    
    for (OpportunityLineItem oppLineItem: oppLineitemsList){
        ProductsIds.add(oppLineItem.Product2Id);
    }
    
    map<id,Product2> mapProducts = new map <id,Product2>([select id,Produit_Pack__c from product2 where id IN: ProductsIds ]);
     
    for (OpportunityLineItem oppLineItem: oppLineitemsList){
                System.debug('mapProducts.get(oppLineItem.Product2Id)'+mapProducts.get(oppLineItem.Product2Id));

        if (mapProducts.get(oppLineItem.Product2Id).Produit_Pack__c){
            packProductsIds.add(oppLineItem.Product2Id) ;   
        }
    }
    
    
    moduleProducts = [select Pack__c,Composant__c from Detail_pack__c where Pack__c IN: packProductsIds];
    system.debug('##moduleProducts'+moduleProducts);
    for (Detail_pack__c prod: moduleProducts){
        
        if (mapPackModuleProducts.containsKey(prod.Pack__c))
            {
        mapPackModuleProducts.get(prod.Pack__c). add(prod);
            }
        else {
          mapPackModuleProducts.put(prod.Pack__c, new  List <Detail_pack__c> { prod });
         }
    }
    
    
     for (OpportunityLineItem oppLineItem: oppLineitemsList){
        
         if (mapProducts.get(oppLineItem.Product2Id).Produit_Pack__c){
            
            if (mapPackModuleProducts.get(oppLineItem.Product2Id)!=null){
                
                for (Detail_pack__c pro : mapPackModuleProducts.get(oppLineItem.Product2Id)){
                    
                    OpportunityLineItem newOppLineItem = new OpportunityLineItem();
                    
                    system.debug('##Detail_pack__c : '+pro);
                    
                    PricebookEntry[] listPricebookEntry = [Select p.UseStandardPrice, p.UnitPrice, p.SystemModstamp, p.ProductCode, p.Product2Id, 
        p.Pricebook2Id, p.Name, p.LastModifiedDate, p.LastModifiedById, p.IsDeleted, p.IsActive, p.Id, 
        p.CreatedDate, p.CreatedById 
            from PricebookEntry p where p.Product2Id =: pro.Composant__c And Pricebook2Id IN (Select Pricebook2Id From Opportunity Where ID =:oppLineItem.OpportunityId) limit 1];
                            
                    if (listPricebookEntry.size() > 0){
                        newOppLineItem.PricebookEntryId = listPricebookEntry[0].Id;
                        newOppLineItem.OpportunityId= oppLineItem.OpportunityId;    
                        newOppLineItem.UnitPrice =0;
                        newOppLineItem.Quantity = oppLineItem.Quantity; 
                        //Quanit�
                        oppLineItemsToInsert.add(newOppLineItem);
                    } 
                    
                }
                     }
                 
             }
         }
    
    insert oppLineItemsToInsert;
    }
  
}