<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <outboundMessages>
        <fullName>inx__Close_Inxmail_Campaign</fullName>
        <apiVersion>27.0</apiVersion>
        <endpointUrl>https://sfdc2.inxmail.com/salesforce-connector/CloseCampaignNotificationService</endpointUrl>
        <fields>Id</fields>
        <fields>inx__list_id__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>hugonnet@em-lyon.com</integrationUser>
        <name>Close Inxmail Campaign Trigger</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <outboundMessages>
        <fullName>inx__Inxmail_Campaign_Trigger</fullName>
        <apiVersion>27.0</apiVersion>
        <endpointUrl>https://sfdc2.inxmail.com/salesforce-connector/CreateCampaignNotificationService</endpointUrl>
        <fields>Id</fields>
        <fields>inx__list_id__c</fields>
        <includeSessionId>true</includeSessionId>
        <integrationUser>hugonnet@em-lyon.com</integrationUser>
        <name>Connect Inxmail Campaign Trigger</name>
        <protected>false</protected>
        <useDeadLetterQueue>false</useDeadLetterQueue>
    </outboundMessages>
    <rules>
        <fullName>inx__Close%2C Abort or Delete Inxmail Campaign Rule</fullName>
        <actions>
            <name>inx__Close_Inxmail_Campaign</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Campaign.Status</field>
            <operation>contains</operation>
            <value>Completed</value>
        </criteriaItems>
        <criteriaItems>
            <field>Campaign.Status</field>
            <operation>contains</operation>
            <value>Aborted</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>inx__Connect with Inxmail Rule</fullName>
        <actions>
            <name>inx__Inxmail_Campaign_Trigger</name>
            <type>OutboundMessage</type>
        </actions>
        <active>true</active>
        <formula>inx__connect_with_Inxmail__c  = true</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
