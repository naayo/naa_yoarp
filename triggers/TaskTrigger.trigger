/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Trigger pour l'objet Task (Tâche)
 */

trigger TaskTrigger on Task (before insert, after insert) {

    private static final Id ID_PROD = '00Dw0000000Cp11EAC';

    System.debug('--- BEGIN Trigger TaskTrigger ---');

    // Le trigger ne se lance pas dans l'environnement de production
    if (!UserInfo.getOrganizationId().equals(ID_PROD)) {
        new TaskTriggerHandler().run();
    }

    System.debug('--- END Trigger TaskTrigger ---');
}