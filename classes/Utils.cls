/**
*
* @author Mahmoud BECHAA 
*/
Public class Utils{
    
    // Maj automatique du champ département lorsque le pays est FRANCE et que le code postal 
    // adresse personnelle est renseigné
    
    
    public static void setDptAccount(List<Account> listAcctNew, List<D_partement__c> listDpt){
       String myDptCode='';
       for(integer i=0;i<listAcctNew.size();i++){
            
           // vérification des temps d'exécution
           /*
            System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
            System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getDmlRows());
            System.debug('3. Number of DML statements used so far: ' +  Limits.getDmlStatements());    
            System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());
          */
      
        if(listAcctNew[i].CountryName__c == 'FRANCE' && listAcctNew[i].Code_Postal__c!=null && listAcctNew[i].Code_Postal__c.trim().length()==5  ){
            myDptCode = listAcctNew[i].Code_Postal__c.substring(0,2);
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
    
    public static void setDptContact(List<Contact> listContactsNew, List<D_partement__c> listDpt){
        String myDptCode='';
        System.debug('Nb de contacts'+listContactsNew.size());
        for(integer i=0;i<listContactsNew.size();i++){
            
            // vérification des temps d'exécution
            System.debug('1. Number of Queries used in this Apex code so far: ' + Limits.getQueries());
            System.debug('2. Number of rows queried in this Apex code so far: ' + Limits.getDmlRows());
            System.debug('3. Number of DML statements used so far: ' +  Limits.getDmlStatements());    
            System.debug('4. Amount of CPU time (in ms) used so far: ' + Limits.getCpuTime());
            System.debug('Pays Contact'+ listContactsNew[i].CountryName__c);
                    
            if(listContactsNew[i].CountryName__c == 'FRANCE' && listContactsNew[i].Adresse_code_postal__c!=null && listContactsNew[i].Adresse_code_postal__c.trim().length()==5  ){
                myDptCode =  listContactsNew[i].Adresse_code_postal__c.substring(0,2); 
                System.debug('Dpt Contact' + myDptCode);
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

    /**
    @Author : Julie NGUYEN - Modis
    Created on : 23/03/2017
    Méthode permettant de récupérer le nom d'un objet à partir du préfix de l'ID d'un enregistrement
     */
    public static String findObjectNameFromRecordIdPrefix(String recordIdOrPrefix) {
        String objectName = '';
        try{

            // Récupère le préfixe à partir de l'ID de l'enregistrement
            String myIdPrefix = String.valueOf(recordIdOrPrefix).substring(0,3);

            // Récupération du schéma
            Map<String, Schema.SObjectType> gd =  Schema.getGlobalDescribe();

            // Boucle à travers tous les types de sObjects retournés par le Schéma
            for(Schema.SObjectType stype : gd.values()){
                Schema.DescribeSObjectResult r = stype.getDescribe();
                String prefix = r.getKeyPrefix();
                // System.debug('-- Prefix is ' + prefix);

                // Vérifie que le préfixe matche avec le préfixe requêté
                if(prefix!=null && prefix.equals(myIdPrefix)){
                    objectName = r.getName();
                    System.debug('-- Object Name! ' + objectName);
                    break;
                }
            }
        }catch(Exception e){
            System.debug(e);
        }
        return objectName;
    }
    
}