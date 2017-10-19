/**
LastModifiedBy Sabri Dali 16/03/2016
test class correction and assert implementation
cooments added
*/
@isTest
private class TestTR005OppLineItem {

 static testMethod void myUnitTest() {
            
  //Get Product RecordType
  String  pack = [select Id from RecordType  where DeveloperName = 'Pack' and SobjectType = 'Product2' limit 1].Id;

  //Data creation
  NAF__c naf = new NAF__c(Name='naf',CODE_APE__c='1234');
  insert naf;

  Pays__c pays = new Pays__c();
  pays.Name = 'France';
  insert pays;

  Account acc = new Account(Name='test');
  acc.SIRET__c='00000000000000';
  acc.CodeAPE__c=naf.Id;
  acc.Industry='Agriculture';
  acc.CodePays__c = pays.id;
  acc.Adresse_Ville__c = 'Nantes';
  insert acc;

  Contact contact= new Contact(AccountId=acc.Id,statut__c='Etudiant',FirstName='Asmae',LastName='Ettahiri',Salutation='Mme');
  insert contact;

  Product2 prod = new Product2(Name='prodTest',RecordtypeId = pack);
  insert prod;

     RecordType rtProd = [SELECT Id, name FROM RecordType WHERE DeveloperName = 'Pack'];
      Product2 prod_1 = new Product2(Name='prodTest', Suiveur__c = UserInfo.getUserId(),RecordTypeId =rtProd.id);
     
     insert prod_1;
     
     Product2 prod2 = new Product2(Name='prodTest',Suiveur__c = UserInfo.getUserId(),RecordTypeId =rtProd.id);
  insert prod2;

  Detail_pack__c dp= new Detail_pack__c(Pack__c=prod.Id,Composant__c=prod2.Id);
  insert dp;
   
     Detail_pack__c dp1= new Detail_pack__c(Pack__c=prod2.Id,Composant__c=prod_1.Id);
     

  // Get standard price book ID.
  // This is available irrespective of the state of SeeAllData.
  Id standardPB = Test.getStandardPricebookId();

  Pricebookentry pricebook1= new PriceBookEntry(Product2Id=prod.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook1;

  Pricebookentry pricebook2= new PriceBookEntry(Product2Id=prod2.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook2;
     
      Pricebookentry pricebook3= new PriceBookEntry(Product2Id=prod_1.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook3;

  Date d = System.Today();
  Opportunity opp= new Opportunity(Pricebook2Id=standardPB ,StageName='test',Name='test',Contact_central__c=contact.Id,AccountId=acc.Id,Exercice__c='2015',CloseDate=Date.valueOf('2015-08-15'));
  opp.CloseDate=Date.valueOf('2015-08-15');
  System.debug('#####CloseDate'+opp.CloseDate);
  insert opp;

     List<OpportunityLineItem> oliList = new List<OpportunityLineItem>();

   
    //insert oli;   
      for (Integer i =0;i<200;i++){
          OpportunityLineItem oli = new OpportunityLineItem(PricebookentryId=pricebook2.Id, Totalprice=23, Quantity=2,Product2Id =prod2.Id);     
  	      oli.OpportunityId=opp.Id;
          oliList.add(oli);
      }
   INSERT oliList;
  //Test
  Test.startTest();    
  OpportunityLineItem controlOppLI = [select id from OpportunityLineItem where OpportunityId =: opp.Id and Product2Id =:prod2.Id Limit 1];
  System.assert(controlOppLI!=null);
  Test.stopTest(); 
     
 }
}