<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>D_sactivation_compte_Celia_PANAFIEU</fullName>
        <description>Désactivation du compte de Celia PANAFIEU après 6 jours</description>
        <field>IsActive</field>
        <literalValue>0</literalValue>
        <name>Désactivation compte Celia PANAFIEU</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Compte Utilisateur temporaire Panefieu</fullName>
        <active>true</active>
        <criteriaItems>
            <field>User.Username</field>
            <operation>equals</operation>
            <value>celia.panefieu@edu.emlyon.com</value>
        </criteriaItems>
        <description>compte utilisateur temporaire Celia PANEFIEU pour EML</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>D_sactivation_compte_Celia_PANAFIEU</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>User.CreatedDate</offsetFromField>
            <timeLength>6</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
</Workflow>
