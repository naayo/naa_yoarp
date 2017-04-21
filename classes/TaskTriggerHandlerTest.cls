/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Classe de test pour TaskTriggerHandler
 */

@IsTest
private class TaskTriggerHandlerTest {
    @testSetup public static void createData() {
        List<Contact> contacts = new List<Contact>{
                new Contact(Salutation = 'Mme', FirstName = 'Test ', LastName = ' 01'),
                new Contact(Salutation = 'Mme', FirstName = 'Test ', LastName = ' Owner')
        };
        insert contacts;

        Opportunity opp = new Opportunity(Name = 'Opp_Test01',
                StageName = 'Intéressé par',
                CloseDate = date.today());
        insert opp;
    }

    /**
    Méthode qui teste que le trigger remplit effectivement les champs WhatId et WhoId quand les deux champs
    TECH_External_What_Id__c et TECH_External_Who_Id__c sont remplis
     */
    static testMethod void testWithBothTechFields() {

        Contact ctc = [SELECT Id, LastName FROM Contact WHERE LastName = 'Owner'];
        ctc.TECH_External_Id__c = ctc.ID;
        update ctc;
        System.debug('Contact : ' + ctc);

        Opportunity opportunity = [SELECT Id FROM Opportunity];
        opportunity.TECH_External_Id__c = opportunity.ID;
        update opportunity;
        System.debug('Opportunity : ' + opportunity);

        List<Task> tasks = new List<Task>();
        for (Integer i = 0 ; i < 3 ; i++) {
            tasks.add(new Task(TECH_External_What_Id__c = String.valueOf(opportunity.Id),
                    TECH_External_Who_Id__c = String.valueOf(ctc.Id),
                    TECH_Is_Record_Transferring__c = true));
        }

        Test.startTest();
        insert tasks;
        Test.stopTest();

        tasks = [SELECT Id, WhoId, WhatId, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Task];
        for (Task task : tasks) {
            System.debug('task.whoId : ' + task.whoId);
            System.debug('task.TECH_External_Who_Id__c : ' + task.TECH_External_Who_Id__c);

            // Vérification que les champs WhoId et WhatId ont été remplis à partir des champs TECH
            System.assertEquals(task.TECH_External_Who_Id__c, task.WhoId);
            System.assertEquals(task.TECH_External_What_Id__c, task.WhatId);
        }
    }
}