public with sharing class TR_session_formation{

public static void attach_session(list<OpportunityLineItem > po_module, Map<Id,Session__c > map_session){
list<OpportunityLineItem> poToUpdate;
//[select Id, Name from Session__c  where Session_de_formation_associee__c IN :Id_sess]
for(OpportunityLineItem po: po_module)
 {
 
  if(map_session.ContainsKey(po.PricebookEntry.Product2Id) )
  {
  po.Session_de_formation__c = map_session.get(po.PricebookEntry.Product2Id).Id;
  // poToUpdate.add(po);
  }

 }
 update po_module;
 
 }
}