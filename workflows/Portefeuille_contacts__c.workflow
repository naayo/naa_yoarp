<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>M_J_auto_du_champ_TECH_Unicity_Value</fullName>
        <description>Remplit automatiquement le champ TECH Unicity Value avec l&apos;Id du contact et l&apos;Id du user.</description>
        <field>TECH_Unicity_Value_del__c</field>
        <formula>Contact__c &amp; &apos;|&apos; &amp;  User__c</formula>
        <name>MàJ auto du champ TECH Unicity Value</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <rules>
        <fullName>Unicité - Relation avec le contact</fullName>
        <actions>
            <name>M_J_auto_du_champ_TECH_Unicity_Value</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Remplissage automatique du champ TECH Unicity Value qui concatène les Id du contact et du user selectionnés pour créer d&apos;une &quot;Relation avec le contact&quot;. Ce champ est &quot;unique&quot;, il sera donc impossible de créer 2 fois la même &quot;Relation avec le contact&quot;.</description>
        <formula>OR(
		ISNEW(),
		ISCHANGED(Contact__c ),
		ISCHANGED(User__c)
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
