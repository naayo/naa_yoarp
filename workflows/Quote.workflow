<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Commentaire_devis</fullName>
        <field>Commentaire_devisOLD__c</field>
        <formula>Opportunity.Commentaire_devis__c</formula>
        <name>Commentaire devis</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Devis_Taxe</fullName>
        <field>Tax</field>
        <formula>( TotalPrice  *20)/100</formula>
        <name>Devis Taxe</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Commentaire devis</fullName>
        <actions>
            <name>Commentaire_devis</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.Commentaire_devis__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>TAXE</fullName>
        <actions>
            <name>Devis_Taxe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Quote.Subtotal</field>
            <operation>greaterThan</operation>
            <value>0</value>
        </criteriaItems>
        <description>Valeur par défaut de la taxe</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
