<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <rules>
        <fullName>WF_SessionFormation</fullName>
        <active>true</active>
        <criteriaItems>
            <field>Session__c.Statut__c</field>
            <operation>equals</operation>
            <value>En attente</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>Session_de_formation_S_6</name>
                <type>Task</type>
            </actions>
            <offsetFromField>Session__c.Date_de_debut_de_session__c</offsetFromField>
            <timeLength>-45</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <tasks>
        <fullName>Session_de_formation_S_6</fullName>
        <assignedToType>owner</assignedToType>
        <dueDateOffset>7</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Élevé</priority>
        <protected>false</protected>
        <status>Non démarré</status>
        <subject>Session de formation S-6</subject>
    </tasks>
</Workflow>
