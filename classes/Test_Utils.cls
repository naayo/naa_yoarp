@isTest
public class Test_Utils {

    // Méthode de création d'un utilisateur de test 
    public static User createTestUser (string bypassTriggers, boolean bypassWorkflow, boolean bypassValidationRules) {        
        User testUser = new User(
            alias = 'Test',
            email = 'test_emlyon@example.com', 
            emailencodingkey='UTF-8',
            lastname='EML',
            languagelocalekey='fr', 
            localesidkey='fr_FR',
            profileid = [SELECT Id FROM Profile WHERE Name = 'System Administrator' OR Name = 'Administrateur système' LIMIT 1][0].Id,
            timezonesidkey='America/Los_Angeles',
            username='test_emlyon@example.com',
            BypassTrigger__c = bypassTriggers,
            //Bypass_Workflows__c = bypassWorkflow,//TODO
            ByPass_RV__c = bypassValidationRules
        );
        
        Database.Saveresult sr = Database.insert(testUser,false);
        System.assert(sr.isSuccess(),'Utilisateur de Test pas créé');
        return testUser;
    }
    
    
}