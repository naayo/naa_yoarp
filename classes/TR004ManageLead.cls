public with sharing class TR004ManageLead {

	public static void LeadConvertion(Id contactId, RecordType recordtype, Id oppId){
		Opportunity opp = [Select o.Id, o.Contact_central__c, o.StageName From Opportunity o where o.id  = : oppId];
		opp.Contact_central__c=contactId;
		opp.RecordTypeId=recordtype.id;
		update opp;
	}
}