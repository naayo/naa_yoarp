trigger DiplomeAfterUpdate on Dipl_me__c (after insert, after update) {
    
    // on sauvegarde la liste des enregistrements en cours de mdofication dans un tableau d'id
    Set<Id> mDipl = Trigger.Newmap.Keyset();
    
    TR008ManageDiplomes.majDateContact(mDipl);
    
}