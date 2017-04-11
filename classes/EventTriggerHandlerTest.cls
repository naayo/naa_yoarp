/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Classe de test pour EventTriggerHandler
 */

@IsTest
private class EventTriggerHandlerTest {

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
        System.debug('Contact : ' + ctc);

        Opportunity opportunity = [SELECT Id FROM Opportunity];
        System.debug('Opportunity : ' + opportunity);

        List<Event> events = new List<Event>();
        for (Integer i = 0 ; i < 10 ; i++) {
            events.add(new Event(DurationInMinutes = 2,
                    ActivityDateTime = datetime.now(),
                    TECH_External_What_Id__c = String.valueOf(opportunity.Id),
                    TECH_External_Who_Id__c = String.valueOf(ctc.Id)));
        }

        Test.startTest();
        insert events;
        Test.stopTest();

        events = [SELECT Id, WhoId, WhatId, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Event];
        for (Event event : events) {
            System.debug('event.whoId : ' + event.whoId);
            System.debug('event.TECH_External_Who_Id__c : ' + event.TECH_External_Who_Id__c);

            // Vérification que les champs WhoId et WhatId ont été remplis à partir des champs TECH
            System.assertEquals(event.WhoId, event.TECH_External_Who_Id__c);
            System.assertEquals(event.WhatId, event.TECH_External_What_Id__c);
        }
    }

    /**
    Méthode qui teste que le trigger remplit effectivement les champs WhatId à partir du champ
    TECH_External_What_Id__c, et qu'il laisse le champ WhoId vide
     */
    static testMethod void testWithWhatIdTechField() {

        Opportunity opportunity = [SELECT Id FROM Opportunity];
        System.debug('Opportunity : ' + opportunity);

        List<Event> events = new List<Event>();
        for (Integer i = 0 ; i < 10 ; i++) {
            events.add(new Event(DurationInMinutes = 2,
                    ActivityDateTime = datetime.now(),
                    TECH_External_What_Id__c = String.valueOf(opportunity.Id)));
        }

        Test.startTest();
        insert events;
        Test.stopTest();

        events = [SELECT Id, WhoId, WhatId, TECH_External_Who_Id__c, TECH_External_What_Id__c FROM Event];
        for (Event event : events) {
            System.debug('event.whoId : ' + event.whoId);
            System.debug('event.TECH_External_Who_Id__c : ' + event.TECH_External_Who_Id__c);

            // Vérification que les champs WhoId et WhatId ont été remplis à partir des champs TECH
            System.assertEquals(event.WhoId, null);
            System.assertEquals(event.WhatId, event.TECH_External_What_Id__c);
        }
    }
}