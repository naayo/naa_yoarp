<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Unicit</fullName>
        <field>produit_unique__c</field>
        <formula>ProductCode</formula>
        <name>Unicité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Unicité</fullName>
        <actions>
            <name>Unicit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>rempli le champ produit unique</description>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
