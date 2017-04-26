trigger ContactBeforeInsert on Contact (before insert) {
 IF (PAD.canTrigger('TR001ManageContact')&&PAD.canTrigger('utilAccount')){
  // Déclaration de la liste qui va contenir les contacts modifiés
  List <Contact> ContactsNew= new List <Contact>();
    // on crée une liste des départements en dehors de la boucle d'enregistrements
    // pour la màj automatique du dpt en fonction du code postal saisi
    List<D_partement__c> listDpt = [select id, Code_d_partement__c from D_partement__c];
    for (contact con : Trigger.new){
        if (con.Conversion_Contact__c=='Prospect Etudiant')con.RecordTypeID=Label.RecordTypeProspectEtudiant;
       else if (con.Conversion_Contact__c=='Professionnel')con.RecordTypeID=Label.RecordTypeProfessionnel   ;  
       else if (con.Conversion_Contact__c=='Etudiant')con.RecordTypeID= Label.RecordTypeEtudiant; 
       // mise en forme casse du nom et prénom
       Utils.contactToUpper(con);
       ContactsNew.add(con);  
    }
    
    if(ContactsNew.Size() > 0){
    
          Utils.setDptContact(ContactsNew);
    
    }
    
  }
}