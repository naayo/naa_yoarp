trigger OpportunityBeforeInsert on Opportunity (before insert) {
if (PAD.canTrigger('TR007Opp2FieldsNull'))
    TR007Opp2FieldsNull.initOpportunity(Trigger.new);
}