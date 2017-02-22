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

  Product2 prod2 = new Product2(Name='prodTest');
  insert prod2;

  Detail_pack__c dp= new Detail_pack__c(Pack__c=prod.Id,Composant__c=prod2.Id);
  insert dp;

  // Get standard price book ID.
  // This is available irrespective of the state of SeeAllData.
  Id standardPB = Test.getStandardPricebookId();

  Pricebookentry pricebook1= new PriceBookEntry(Product2Id=prod.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook1;

  Pricebookentry pricebook2= new PriceBookEntry(Product2Id=prod2.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook2;

  Date d = System.Today();
  Opportunity opp= new Opportunity(Pricebook2Id=standardPB ,StageName='test',Name='test',Contact_central__c=contact.Id,AccountId=acc.Id,Exercice__c='2015',CloseDate=Date.valueOf('2015-08-15'));
  opp.CloseDate=Date.valueOf('2015-08-15');
  System.debug('#####CloseDate'+opp.CloseDate);
  insert opp;


  OpportunityLineItem oli = new OpportunityLineItem(PricebookentryId=pricebook1.Id, Totalprice=23, Quantity=2);
  oli.OpportunityId=opp.Id;

  //Test
  Test.startTest();
  insert oli;
  OpportunityLineItem controlOppLI = [select id from OpportunityLineItem where OpportunityId =: opp.Id and Product2Id =:prod2.Id];
  System.assert(controlOppLI!=null);
  Test.stopTest(); 
 }
}