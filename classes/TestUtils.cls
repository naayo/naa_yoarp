@isTest(seeAllData=true)
public class TestUtils {
    
    static testMethod void testInsert(){
        try{
            List<Contact> listContactsNew;
            List<Account> listAccountsNew;
            List<D_partement__c> listDpt=new List<D_partement__c>();    
            Test.startTest();
            listContactsNew = new List<Contact>();
            listAccountsNew = new List<Account>();
            D_partement__c d1;
            D_partement__c d2;
            
            d1=[select id, Code_d_partement__c from D_partement__c where Code_d_partement__c='69' ] ;    
            d2=[select id, Code_d_partement__c from D_partement__c where Code_d_partement__c='75' ] ; 
            
            
            listDpt.add(d1);
            listDpt.add(d2);
            
            
            System.debug('Nb de départements : '+listDpt.size());
            
            NAF__c naf = new NAF__c();
            naf.CODE_APE__c = 'AAAA';
            naf.Code_NACE__c = 'BBBB';
            naf.Secteur__c = 120;
            insert naf;
            
            Pays__c PaysFrance = [Select id from Pays__c where Name='France'];
            for(integer i=0;i<=200;i++){
                
                Account a = new Account();
                a.Name = 'Account test '+i;
                a.CodePays__c = PaysFrance.Id;
                a.Code_Postal__c='69500';
                a.SIRET__c='40483304800022';
                a.Adresse_Ville__c='Bron';
                a.CodeAPE__c = naf.id;
                listAccountsNew.add(a);
                String myDptCode = listAccountsNew[i].Code_Postal__c.substring(0,2);
                
                
            }
            
            for(integer i=0;i<=200;i++){
                Contact c = new Contact();
                c.Salutation = 'M';
                c.LastName='Test '+i;
                c.FirstName = 'test';
                c.AccountId = listAccountsNew[i].Id;
                c.Adresse_code_postal__c = '69500';
                c.Pays__c=PaysFrance.Id;
                listContactsNew.add(c);
            }
            
            
            insert listAccountsNew;
            insert listContactsNew;
            
            
            if(listContactsNew.size()>0){    
                TestsetDptContact(listContactsNew, listDpt);
                
            } 
            if(listAccountsNew.size()>0){
                TestsetDptAccount(listAccountsNew, listDpt);
            }
            
            for(Account a:listAccountsNew){
                
                a.Code_Postal__c='99000';
            }
            
            for(Contact c:listContactsNew){
                
                c.Adresse_code_postal__c='99000';
            }
            Exception e;
            try{
                update listAccountsNew;
                update listContactsNew;
            }
            
            catch(Exception ex){
                e=ex;   
            }
            
            try{        
                if(listContactsNew.size()>0){   
                    
                    TestsetDptContact(listContactsNew, listDpt);
                    
                } 
                
            }
            
            catch(Exception ex){
                e=ex;
                system.assertNotEquals(null, e);
                system.assert(e instanceOf system.Dmlexception);
                system.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
                system.assert(e.getMessage().contains('Vous ne pouvez pas sélectionner ce code postal pour le pays FRANCE'));
            }
            
            try{
                
                
                if(listAccountsNew.size()>0){
                    TestsetDptAccount(listAccountsNew, listDpt);
                }
            }
            
            
            catch(Exception ex){
                e=ex;
                
            }
            system.assertNotEquals(null, e);
            system.assert(e instanceOf system.Dmlexception);
            system.assert(e.getMessage().contains('FIELD_CUSTOM_VALIDATION_EXCEPTION'));
            system.assert(e.getMessage().contains('Vous ne pouvez pas sélectionner ce code postal pour le pays FRANCE'));
            
        } catch (Exception e){
            
        } 
        
        
        
        Test.stopTest();    
    }

    /**
    Julie NGUYEN - Modis (24/03/2017)
    Tests pour la méthode findObjectNameFromRecordIdPrefix(String str)
     */
    static testMethod void testFindObjectNameFromRecordIdPrefix(){
        String opportunityPrefix = '006';
        String accountPrefix = '001';
        String contactPrefix = '003';
        String leadPrefix = '00Q';

        System.assertEquals('Opportunity', Utils.findObjectNameFromRecordIdPrefix(opportunityPrefix));
        System.assertEquals('Account', Utils.findObjectNameFromRecordIdPrefix(accountPrefix));
        System.assertEquals('Contact', Utils.findObjectNameFromRecordIdPrefix(contactPrefix));
        System.assertEquals('Lead', Utils.findObjectNameFromRecordIdPrefix(leadPrefix));
        System.assertNotEquals('Opportunity', Utils.findObjectNameFromRecordIdPrefix(leadPrefix));
        System.assertNotEquals('Account', Utils.findObjectNameFromRecordIdPrefix(leadPrefix));
        System.assertNotEquals('Lead', Utils.findObjectNameFromRecordIdPrefix(accountPrefix));
    }
    
    public static void TestsetDptAccount(List<Account> listAcctNew, List<D_partement__c> listDpt){
        for(integer i=0;i<listAcctNew.size();i++){
            
            
            
            String myDptCode = listAcctNew[i].Code_Postal__c.substring(0,2);
            //System.debug('Département : ' + myDptCode) ;
            
            if(listAcctNew[i].CountryName__c == 'FRANCE' && listAcctNew[i].Code_Postal__c.trim().length()==5  ){
                for(D_partement__c d: listDpt  )
                {
                    
                    if(d.Code_d_partement__c==myDptCode)
                        listAcctNew[i].Departement__c= d.Id;     
                    
                    
                }
            }
            
            // on ne peux pas choisir un code postal débutant par "99"
            
            if(listAcctNew[i].CountryName__c == 'FRANCE' && MyDptCode=='99'  ){
                
                listAcctNew[i].addError('Vous ne pouvez pas sélectionner ce code postal pour le pays FRANCE !');
            }
            
        }
        
    }
    
    private static void TestsetDptContact(List<Contact> listContactsNew, List<D_partement__c> listDpt){
        for(integer i=0;i<listContactsNew.size();i++){
            
            
            
            String myDptCode =  listContactsNew[i].Adresse_code_postal__c.substring(0,2); 
            
            if(listContactsNew[i].CountryName__c == 'FRANCE' &&  MyDptCode=='99'  ){
                for(D_partement__c d: listDpt  )
                {
                    
                    if(d.Code_d_partement__c==myDptCode)
                        listContactsNew[i].D_partement__c= d.Id;     
                    
                    
                }
                
            }
            
            // on ne peux pas choisir un code postal débutant par "99"
            
            if(listContactsNew[i].CountryName__c == 'FRANCE' && MyDptCode=='99'  ){
                listContactsNew[i].addError('Vous ne pouvez pas sélectionner ce code postal pour le pays FRANCE !');
            }
            
            
        }
        
    }
    
    
    
}