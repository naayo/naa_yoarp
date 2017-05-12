trigger ContactBeforeUpdate on Contact (before update) {
  
    
    IF (PAD.canTrigger('TR001ManageContact') && PAD.canTrigger('Utils')){
    
    // Déclaration de la liste qui va contenir les contacts modifiés
    List <Contact> ContactsOld= new List <Contact>();
    List <Contact> ContactsNew= new List <Contact>();
    // on crée une liste des départements en dehors de la boucle d'enregistrements
    // pour la màj automatique du dpt en fonction du code postal saisi
    List<Contact> ContactsUpdtDpt = new List<Contact>();
    
    
    for(integer i=0;i<Trigger.new.size();i++){

            ContactsUpdtDpt.add(Trigger.new[i]);
            // formatage nom et prénom en majuscules
            Utils.contactToUpper(Trigger.new[i]);
            if('Professionnel'.equalsIgnoreCase(Trigger.new[i].Statut__c) ||
                'Professionnel'.equalsIgnoreCase(Trigger.old[i].Statut__c) ) {

                if(Trigger.new[i].AccountId != Trigger.old[i].AccountId||Trigger.new[i].Famille_Fonction__c!= Trigger.old[i].Famille_Fonction__c||Trigger.new[i].Fonctions__c!= Trigger.old[i].Fonctions__c){             
                    ContactsOld.add(Trigger.old[i]);
                    ContactsNew.add(Trigger.new[i]);
                    
                    
                }
            }
    }


    // Vérifier que la liste des contacts n'est pas vide,
    // puis lancer le traitement sur la liste des contacts
    if(ContactsOld.size()>0){
      
        TR001ManageContact.CreatePosteSupplementaire(ContactsOld,ContactsNew);
         
      
}  
        if(ContactsUpdtDpt.size()>0){
              
              Utils.setDptContact(ContactsUpdtDpt);
        }


       }
        }