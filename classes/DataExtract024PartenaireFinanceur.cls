/**
 * Created by Julie NGUYEN - Modis on 07/03/2017.
 */

public class DataExtract024PartenaireFinanceur implements Queueable {

    public static final String OBJECT_NAME_PARTENAIRE_FINANCEUR = 'Partenaire_financeur__c';

    private DataToExport dataExport;

    public DataExtract024PartenaireFinanceur(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        extractPartenairesFinanceurs();
        if ( !Test.isRunningTest() ) {
            System.enqueueJob(new DataExtract025MailingAfterExtract());
        }
    }

    /**
    Extraction des partenaires financeurs reliés aux enregistrements déjà traités parmi les objets :
    - Account
    - Opportunity
     */
    public void extractPartenairesFinanceurs() {
        System.debug('--- BEGIN DataExtract024PartenaireFinanceur / extractPartenairesFinanceurs() ---');

        if ( ( dataExport.accountsToExport != null && !dataExport.accountsToExport.isEmpty() ) &&
                ( dataExport.opportunitiesToExport != null && !dataExport.opportunitiesToExport.isEmpty() ) ) {
            String clause = ' WHERE Compte_financeur__c IN ' + DataExtractUtils.convertSetToString(dataExport.accountsToExport) +
                    ' AND Opportunite_financee__c IN ' + DataExtractUtils.convertSetToString(dataExport.opportunitiesToExport)
            ;

            System.debug('-- PARAM String clause : ' + clause);

            DataExtractUtils.extractAllFieldWithSpecificWhereClause('20', OBJECT_NAME_PARTENAIRE_FINANCEUR, clause);
        } else {
            System.debug('Il n\'y a pas de comptes associés à des opportunités parmi les comptes et les ' +
                    'opportunités déjà traités');
        }

        System.debug('--- END DataExtract024PartenaireFinanceur / extractPartenairesFinanceurs() ---');
    }

}