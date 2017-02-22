<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Assignation_Piste_FCC</fullName>
        <field>OwnerId</field>
        <lookupValue>EML_Programme_Court</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assignation Piste FCC</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assignation_Piste_FCI</fullName>
        <field>OwnerId</field>
        <lookupValue>EML_PGM</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assignation Piste FCI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assignation_Piste_FCL</fullName>
        <field>OwnerId</field>
        <lookupValue>EML_AMP_DUA</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assignation Piste FCL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assignation_Piste_FINTRA</fullName>
        <field>OwnerId</field>
        <lookupValue>EML_INTRA</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assignation Piste FINTRA</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Assignation_Piste_Ind_termin_e</fullName>
        <field>OwnerId</field>
        <lookupValue>Ind_termin</lookupValue>
        <lookupValueType>Queue</lookupValueType>
        <name>Assignation Piste Indéterminée</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Remplir_Societe</fullName>
        <field>Company</field>
        <formula>&quot;Sans organisation connue&quot;</formula>
        <name>Remplir Société</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PISTE_01_DON_003</fullName>
        <field>Login__c</field>
        <formula>Adresse_e_mail__c</formula>
        <name>WF-PIST-01-DON-003</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PIST_01_DON_001_01</fullName>
        <field>Status</field>
        <literalValue>Abandon</literalValue>
        <name>WF-PIST-01-DON-001_01</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PIST_01_DON_001_02</fullName>
        <field>Motif_d_abandon__c</field>
        <literalValue>Date légale dépassée</literalValue>
        <name>WF-PIST-01-DON-001_02</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PIST_01_DON_002</fullName>
        <field>Company</field>
        <formula>&quot;Formation Initiale&quot;</formula>
        <name>WF-PIST-01-DON-002</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PIST_01_DON_003</fullName>
        <field>Login__c</field>
        <formula>Adresse_e_mail__c</formula>
        <name>WF-PIST-01-DON-003</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Assignation Piste FCC</fullName>
        <actions>
            <name>Assignation_Piste_FCC</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Interface</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Formation continue courte</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assignation Piste FCI</fullName>
        <actions>
            <name>Assignation_Piste_FCI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Interface</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Formation continue indéterminée</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assignation Piste FCL</fullName>
        <actions>
            <name>Assignation_Piste_FCL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Interface</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Formation continue longue</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assignation Piste FINTRA</fullName>
        <actions>
            <name>Assignation_Piste_FINTRA</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Interface</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Formation Intra-entreprise</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>Assignation Piste Indéterminée</fullName>
        <actions>
            <name>Assignation_Piste_Ind_termin_e</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Lead.CreatedById</field>
            <operation>equals</operation>
            <value>Interface</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.LeadSource</field>
            <operation>equals</operation>
            <value>Indéterminé</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF-PIST-01-DON-001</fullName>
        <active>true</active>
        <formula>AND 
( 
NOT ISBLANK ( Date_de_p_remption__c ), 
( NOT ISPICKVAL(Status, &quot;Qualifié&quot;) ) 
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
        <workflowTimeTriggers>
            <actions>
                <name>WF_PIST_01_DON_001_01</name>
                <type>FieldUpdate</type>
            </actions>
            <actions>
                <name>WF_PIST_01_DON_001_02</name>
                <type>FieldUpdate</type>
            </actions>
            <offsetFromField>Lead.Date_de_p_remption__c</offsetFromField>
            <timeLength>0</timeLength>
            <workflowTimeTriggerUnit>Days</workflowTimeTriggerUnit>
        </workflowTimeTriggers>
    </rules>
    <rules>
        <fullName>WF-PIST-01-DON-002</fullName>
        <actions>
            <name>WF_PIST_01_DON_002</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Reformatage &quot;Formation Initiale&quot;</description>
        <formula>LOWER(Company)=&quot;formation initiale&quot;</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF-PIST-01-DON-003</fullName>
        <actions>
            <name>WF_PISTE_01_DON_003</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-PIST-Remplir Société</fullName>
        <actions>
            <name>Remplir_Societe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation Courte</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation intra-entreprise</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.RecordTypeId</field>
            <operation>equals</operation>
            <value>Programme Long Diplômant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Lead.Company</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Pour les types d&apos;enregistrement non &quot;Principal&quot; (FI), mettre sans organisation connue quand le champ Société est vide</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
