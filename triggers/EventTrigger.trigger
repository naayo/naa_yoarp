/**
 * Created by Julie NGUYEN - Modis on 23/03/2017.
 * Trigger pour l'objet Event (Événement)
 */

trigger EventTrigger on Event (before insert, after insert) {

    System.debug('--- BEGIN Trigger EventTrigger ---');

    if (PAD.canTrigger('EventTriggerHandler')) {
        new EventTriggerHandler().run();
    }

    System.debug('--- END Trigger EventTrigger ---');

}