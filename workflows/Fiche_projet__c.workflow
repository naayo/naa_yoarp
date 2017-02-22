<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Fiche_projet_Recordtype_Action</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Action</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Fiche projet Recordtype = &quot;Action&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fiche_projet_Recordtype_Anomalie</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Anomalie</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Fiche projet Recordtype = &quot;Anomalie&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fiche_projet_Recordtype_Evolution</fullName>
        <description>Fiche projet</description>
        <field>RecordTypeId</field>
        <lookupValue>Evolution</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Fiche projet Recordtype = &quot;Evolution&quot;</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fiche_projet_date_de_fermeture</fullName>
        <field>Date_de_fermeture__c</field>
        <formula>TODAY()</formula>
        <name>Fiche projet date de fermeture</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fiche_projet_responsable_Client</fullName>
        <field>Responsable__c</field>
        <literalValue>K par K</literalValue>
        <name>Fiche projet responsable Client</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Fiche_projet_responsable_Kerensen</fullName>
        <field>Responsable__c</field>
        <literalValue>Kerensen</literalValue>
        <name>Fiche projet responsable Kerensen</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Fiche projet action</fullName>
        <actions>
            <name>Fiche_projet_Recordtype_Action</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.Type__c</field>
            <operation>equals</operation>
            <value>Action,Demande</value>
        </criteriaItems>
        <description>Gestion du record type pour les anomalies, actions et demandes</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fiche projet anomalie</fullName>
        <actions>
            <name>Fiche_projet_Recordtype_Anomalie</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.Type__c</field>
            <operation>equals</operation>
            <value>Anomalie</value>
        </criteriaItems>
        <description>Gestion du record type pour les anomalie</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fiche projet date de fermeture</fullName>
        <actions>
            <name>Fiche_projet_date_de_fermeture</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.Statut__c</field>
            <operation>equals</operation>
            <value>Fermé</value>
        </criteriaItems>
        <description>Si statut = Fermé, Date de fermeture = Date()</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>Fiche projet responsable Client</fullName>
        <actions>
            <name>Fiche_projet_responsable_Client</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.OwnerId</field>
            <operation>contains</operation>
            <value>Bruno,François,Isabelle,marine,Jimmy</value>
        </criteriaItems>
        <description>Détermine si la fiche projet est chez le client (pour le reporting)
A MODIFIER APRES INSTALLATION DU PACKAGE CHEZ UN NOUVEAU CLIENT</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Fiche projet responsable Kerensen</fullName>
        <actions>
            <name>Fiche_projet_responsable_Kerensen</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.OwnerId</field>
            <operation>contains</operation>
            <value>Nadim,Kerensen,Michael,Dorothée</value>
        </criteriaItems>
        <description>Détermine si la fiche projet est chez Kerensen (pour le reporting)
A MODIFIER APRES INSTALLATION DU PACKAGE CHEZ UN NOUVEAU CLIENT</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Fiche projet évolution</fullName>
        <actions>
            <name>Fiche_projet_Recordtype_Evolution</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Fiche_projet__c.Type__c</field>
            <operation>equals</operation>
            <value>Evolution</value>
        </criteriaItems>
        <description>Gestion du record type pour les évolutions</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
