/**
 * Created by Julie NGUYEN - Modis on 23/03/2017.
 * Trigger pour l'objet Event (Événement)
 */

trigger EventTrigger on Event (before insert, after insert) {

    private static final Id ID_PROD = '00Dw0000000Cp11EAC';

    System.debug('--- BEGIN Trigger EventTrigger ---');

    // Le trigger ne se lance pas dans l'environnement de production
    if (!UserInfo.getOrganizationId().equals(ID_PROD)) {
        new EventTriggerHandler().run();
    }

    System.debug('--- END Trigger EventTrigger ---');

}