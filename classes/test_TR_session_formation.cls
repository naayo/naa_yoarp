/**
LastModifiedBy Sabri Dali 17/03/2016
test class correction and assert implementation
cooments added
*/
@isTest
private class test_TR_session_formation {


 static testMethod void myUnitTest() {
  // get Product RecordTypes 
  String  pack = [select Id from RecordType  where DeveloperName = 'Pack' and SobjectType = 'Product2' limit 1].Id;
  String  Module = [select Id from RecordType  where DeveloperName = 'Module' and SobjectType = 'Product2' limit 1].Id;

  //date creation
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

  Product2 prod = new Product2(Name='prodTest', RecordtypeId = pack);
  insert prod;
  Product2 prod_module = new Product2(Name='prodTest', RecordtypeId = Module);
  insert prod_module;

  Detail_pack__c dp= new Detail_pack__c(Pack__c=prod.Id,Composant__c=prod_module.Id);
  insert dp;

  Session__c ses_pack = new Session__c (Name = 'pack', Produits__c = prod.Id, Code_agresso_for__c = '54983');
  insert ses_pack;
  Session__c ses_module = new Session__c (Name = 'module', Produits__c = prod_module.Id,  Code_agresso_for__c = '98456');
  insert ses_module;

  Detail_pack_session__c dps = new Detail_pack_session__c(Composant_session__c=ses_module.Id,Pack_Session__c=ses_pack.id);
  insert dps;

  // Get standard price book ID.
  // This is available irrespective of the state of SeeAllData.
  Id standardPB = Test.getStandardPricebookId();

  Pricebookentry pricebook1= new PriceBookEntry(Product2Id=prod.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook1;

  Pricebookentry pricebook2= new PriceBookEntry(Product2Id=prod_module.Id, UnitPrice=10, Pricebook2Id=standardPB, IsActive = true, UseStandardPrice = false);
  insert pricebook2;

  Date d = System.Today();
  Opportunity opp= new Opportunity(Pricebook2Id=standardPB,StageName='test',Name='test',Contact_central__c=contact.Id,AccountId=acc.Id,Exercice__c='2015',CloseDate=Date.valueOf('2015-08-15'));
  opp.CloseDate=Date.valueOf('2015-08-15');
  System.debug('#####CloseDate'+opp.CloseDate);
  insert opp;


  OpportunityLineItem oli = new OpportunityLineItem(PricebookentryId=pricebook1.Id, Totalprice=23, Quantity=2, Session_de_formation__c = ses_pack.Id, OpportunityId=opp.Id);

 // Test
  Test.startTest();
  insert oli;

  List<OpportunityLineItem> lcontrolOppLI = [select id,Session_de_formation__c from OpportunityLineItem where OpportunityId =: opp.Id and Session_de_formation__c =:ses_module.id];
  System.assert(lcontrolOppLI!=null);

  Test.stopTest();
 }
}