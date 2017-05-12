/**
 * Created by Julie NGUYEN - Modis on 24/03/2017.
 * Trigger pour l'objet Task (Tâche)
 */

trigger TaskTrigger on Task (before insert, after insert) {

    System.debug('--- BEGIN Trigger TaskTrigger ---');

    if (PAD.canTrigger('TaskTriggerHandler')) {
        new TaskTriggerHandler().run();
    }
    
    System.debug('--- END Trigger TaskTrigger ---');
}