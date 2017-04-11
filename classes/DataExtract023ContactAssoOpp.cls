/**
 * Created by Julie NGUYEN - Modis on 07/03/2017.
 */

public class DataExtract023ContactAssoOpp implements Queueable {

    public static String OBJECT_NAME_CONTACT_ASSO_OPP = 'Contact_associ_s_l_opportunit__c';

    private DataToExport dataExport;

    public DataExtract023ContactAssoOpp(DataToExport dataToExport) {
        this.dataExport = dataToExport;
    }

    public void execute(QueueableContext context) {
        extractContactsAssoToOpp();
        if ( !Test.isRunningTest() ) {
            System.enqueueJob(new DataExtract024PartenaireFinanceur(dataExport));
        }
    }

    /**
    Extraction des contacts associés à des opportunités et reliés aux enregistrements déjà traités parmi les objets :
    - Contact
    - Opportunity
     */
    public void extractContactsAssoToOpp() {
        System.debug('--- BEGIN DataExtract023ContactAssoOpp / extractContactsAssoToOpp() ---');
        if ( ( dataExport.contactsToExport != null && !dataExport.contactsToExport.isEmpty() )
                &&  ( dataExport.opportunitiesToExport != null && !dataExport.opportunitiesToExport.isEmpty() ) ) {
            String clause = ' WHERE Contact__c IN ' + DataExtractUtils.convertSetToString(dataExport.contactsToExport) +
                    ' AND Opportunit__c IN ' + DataExtractUtils.convertSetToString(dataExport.opportunitiesToExport)
            ;

            System.debug('-- PARAM String clause : ' + clause);

            DataExtractUtils.extractAllFieldWithSpecificWhereClause('18', OBJECT_NAME_CONTACT_ASSO_OPP, clause);
        } else {
            System.debug('Il n\'y a pas de contacts associés à des opportunités parmi les contacs et les ' +
                    'opportunités déjà traités');
        }

        System.debug('--- END DataExtract023ContactAssoOpp / extractContactsAssoToOpp() ---');
    }
}