public class TR002ManageOpportunityLineItem{

    public static void addProductFilter(List<OpportunityLineItem> oli){
        //Récupération des priceBookEntry ids
        Set<Id> idPriceBook = new Set<Id>();
        for(OpportunityLineItem op :oli){
            idPriceBook.add(op.PricebookEntryId);
        }
        
        List<PricebookEntry> priceBookEntry = [Select p.Product2Id, p.Id From PricebookEntry p where p.Id in :idPriceBook];
        
        //Récupération des produits à partir du priceBookEntry
        Map<Id,Id> maps = new Map<Id,ID>();
        for(PricebookEntry pE :priceBookEntry){
            maps.put(pe.Id,pE.Product2Id);
        }
        
        //Modification du champ ProduitFiltreSession__c de l'OpportunityLineItem 
        for(OpportunityLineItem o :oli){
            
            o.ProduitFiltreSession__c=maps.get(o.PricebookEntryId);
        }
    }
}