/* 
* Créé par Tom CHAMART - MODIS
* Le 16/02/2017
*/
public class TR009PropagationHierarchie {
    
    public static void updateComptePrincipalAfterUpdate(Map<Id,Account> OldMapData, Map<Id,Account> mpAcctModifies){
        List<Account> listToUpdate = new List<Account>();
        
        // Récupérer l'ancien et le nouveau compte principal
        // de chaque compte concernés
        Map<Id,Id> mpConversionComptePrincipal = new Map<Id,Id>();
        // Parcourir chaque compte modifié
        for(Account acc : mpAcctModifies.values()){
            // Si le compte avait un compte principal et en a toujours un
            if(OldMapData.get(acc.Id).ComptePrincipal__c != null && acc.ComptePrincipal__c !=null){
            	// Charger une map avec en clé l'ancien compte principal du compte 
                // et en valeur le compte principal de son nouveau parent
                mpConversionComptePrincipal.put(OldMapData.get(acc.Id).ComptePrincipal__c, acc.ComptePrincipal__c);    
            }else if(OldMapData.get(acc.Id).ComptePrincipal__c != null && acc.ComptePrincipal__c == null){ // Si le compte est devenu compte principal
                // Charger une map avec en clé l'ancien compte principal du compte 
                // et en valeur le compte
                mpConversionComptePrincipal.put(OldMapData.get(acc.Id).ComptePrincipal__c,acc.Id);
            }
            
            // Le compte principal du compte modifié est réaffecté dans le AccountBeforeUpdate
        }
        
        // Récupérer la hiérarchie complète des comptes concernés
        List<Account> lAccs = [
            SELECT 
            Id, ParentId, ComptePrincipal__c,
            Parent.ParentId, 
            Parent.Parent.ParentId,
            Parent.Parent.Parent.ParentId,
            Parent.Parent.Parent.Parent.ParentId,
            Parent.Parent.Parent.Parent.Parent.ParentId
            FROM Account
            WHERE ComptePrincipal__c IN: mpConversionComptePrincipal.keySet()
        ];
                
        // Réaffecter le compte principal des filiales des comptes modifiés
        // Parcourir chaque filiale concerné par les comptes modifiés
        for(account acc : lAccs){
            // Si son parent est un des comptes modifiés
            if(acc.ParentId != null && mpAcctModifies.containsKey(acc.ParentId)){
                // Assigner le nouveau compte principal correspondant à son ancien
                acc.ComptePrincipal__c = mpConversionComptePrincipal.get(acc.ComptePrincipal__c);
                listToUpdate.add(acc);
            }else{
                // Si le parent de son parent est un des comptes modifiés
                if(acc.Parent.ParentId != null && mpAcctModifies.containsKey(acc.Parent.ParentId)){
                    // Assigner le nouveau compte principal correspondant à son ancien
                    acc.ComptePrincipal__c = mpConversionComptePrincipal.get(acc.ComptePrincipal__c);
                    listToUpdate.add(acc);                
                }else{
                    // ...
                    if(acc.Parent.Parent.ParentId != null && mpAcctModifies.containsKey(acc.Parent.Parent.ParentId)){
                        acc.ComptePrincipal__c = mpConversionComptePrincipal.get(acc.ComptePrincipal__c);
                        listToUpdate.add(acc);                
                    }else{
                        if(acc.Parent.Parent.Parent.ParentId != null && mpAcctModifies.containsKey(acc.Parent.Parent.Parent.ParentId)){
                            acc.ComptePrincipal__c = mpConversionComptePrincipal.get(acc.ComptePrincipal__c);
                            listToUpdate.add(acc);                
                        }else{
                            if(acc.Parent.Parent.Parent.Parent.ParentId != null && mpAcctModifies.containsKey(acc.Parent.Parent.Parent.Parent.ParentId)){
                                acc.ComptePrincipal__c = mpConversionComptePrincipal.get(acc.ComptePrincipal__c);
                                listToUpdate.add(acc); 
                            }	               
                        }
                    } 
                } 
            }    
        }
        
        update listToUpdate;        
    } // Fin updateComptePrincipal   
    
    public static Set<Id> updateHierarchyBeforeDelete(Map<Id,Account> OldMapData){        
        // Récupérer les Ids des comptes principaux des comptes supprimés
        Set<Id> sComptePrincipal = new Set<Id>();
        for(Account acc:OldMapData.values()){
            // Si le compte avait un compte principal
            if(acc.ComptePrincipal__c!=null){
                // Ajouter son compte principal à la liste
            	sComptePrincipal.add(acc.ComptePrincipal__c);    
            }else{
                // L'ajouter à la liste
                sComptePrincipal.add(acc.Id);
            }			
        }
        
        
        // Liste des comptes filiales des comptes supprimés
        List<Account> lAccs = [
            SELECT Id, ParentId,
            Parent.ParentId, 
            Parent.Parent.ParentId,
            Parent.Parent.Parent.ParentId,
            Parent.Parent.Parent.Parent.ParentId,
            Parent.Parent.Parent.Parent.Parent.ParentId
            FROM Account
            WHERE ComptePrincipal__c IN :sComptePrincipal
            OR ID in :OldMapData.keyset()
        ];
        
        // Retirer les comptes supprimés de la liste des comptes principaux pour update
        sComptePrincipal.removeAll(OldMapData.keySet());
        
        // Actualiser le compte principal de chaque compte        
        List<Account> listToUpdate = new List<Account>();
        for(Account accFiliale :lAccs){
            if(accFiliale.ParentId != null && OldMapData.containsKey(accFiliale.ParentId)){
            	// Désaffecter le ComptePrincipal du nouveau compte principal
                accFiliale.ComptePrincipal__c = null;
                listToUpdate.add(accFiliale);
            }
            
            // Si le parent du parent de la filiale est un compte supprimé
            if(accFiliale.ParentId != null && OldMapData.containsKey(accFiliale.Parent.ParentId)){
                // Affecter le parent du compte en compte principal
                accFiliale.ComptePrincipal__c = accFiliale.ParentId;
                // Ajouter le compte principal à la liste pour recalcule des nb
                sComptePrincipal.add(accFiliale.ComptePrincipal__c);
                listToUpdate.add(accFiliale);
            }else{
                // Si le parent du parent du parent de la filiale est un compte supprimé
                if(accFiliale.Parent.ParentId != null && OldMapData.containsKey(accFiliale.Parent.Parent.ParentId)){
                    accFiliale.ComptePrincipal__c = accFiliale.Parent.ParentId;
                    sComptePrincipal.add(accFiliale.ComptePrincipal__c);
                    listToUpdate.add(accFiliale); 
                }else{
                    if(accFiliale.Parent.Parent.ParentId != null && OldMapData.containsKey(accFiliale.Parent.Parent.Parent.ParentId)){
                        accFiliale.ComptePrincipal__c = accFiliale.Parent.Parent.ParentId;
                    	sComptePrincipal.add(accFiliale.ComptePrincipal__c);    
                        listToUpdate.add(accFiliale); 
                    }else{
                        if(accFiliale.Parent.Parent.Parent.ParentId != null && OldMapData.containsKey(accFiliale.Parent.Parent.Parent.Parent.ParentId)){
                            accFiliale.ComptePrincipal__c = accFiliale.Parent.Parent.Parent.ParentId;
                            sComptePrincipal.add(accFiliale.ComptePrincipal__c);
                            listToUpdate.add(accFiliale); 
                        }    
                    }     
                }     
            }
        }    
        
        // Mettre à jour les filiales des comptes supprimés
        update listToUpdate;
        
        // Retourner les nouveaux et anciens comptes principaux
        // pour MàJ les hiérarchies correspondantes
        return sComptePrincipal;
    }
    
} // Fin class