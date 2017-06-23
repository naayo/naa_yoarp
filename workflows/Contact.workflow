<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alerte_Contact_g_de_40_ans_ou_plus</fullName>
        <description>Alerte Contact âgé de 40 ans ou plus</description>
        <protected>false</protected>
        <recipients>
            <recipient>cesar@em-lyon.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>seux@em-lyon.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Prospect_g_de_40_ans_ou_plus</template>
    </alerts>
    <fieldUpdates>
        <fullName>Changement_Statut_Etudiant</fullName>
        <field>Statut__c</field>
        <literalValue>Etudiant</literalValue>
        <name>Changement Statut Etudiant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Changement_de_page_layout_Professionnel</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Professionnel</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Changement de page layout Professionnel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Code_agresso_tiers_contact</fullName>
        <field>Code_tiers_contact__c</field>
        <formula>Compteur_Tiers_Contact__c</formula>
        <name>Code agresso tiers contact</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Code_agresso_tiers_participant</fullName>
        <field>Code_Participant__c</field>
        <formula>Compteur_Tiers_Participant__c</formula>
        <name>Code agresso tiers participant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_MAJ_Email_standard_par_celui_de_l_EM</fullName>
        <field>Email</field>
        <formula>Email_EM_Lyon__c</formula>
        <name>FU. MAJ Email standard par celui de l&apos;EM</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_MAJ_email_standard_par_le_PRO</fullName>
        <field>Email</field>
        <formula>Email_de_repli__c</formula>
        <name>FU.MAJ email standard par le PRO</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>FU_MAJ_email_standard_par_le_personnel</fullName>
        <field>Email</field>
        <formula>Adresse_Email_Personnelle__c</formula>
        <name>FU.MAJ email standard par le personnel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Login_mettre_jour</fullName>
        <field>Login__c</field>
        <formula>Adresse_Email_Personnelle__c</formula>
        <name>Login mettre à jour</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ001_Code_Postal</fullName>
        <field>MailingPostalCode</field>
        <formula>Account.Code_Postal__c</formula>
        <name>MAJ Code Postal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ001_Region</fullName>
        <field>MailingState</field>
        <formula>Account.R_gion__c</formula>
        <name>MAJ Region</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ001_Rue</fullName>
        <field>MailingStreet</field>
        <formula>Account.Adresse_Rue__c +&quot; &quot;+  Account.Rue_2__c +&quot; &quot;+  Account.Ligne_3__c</formula>
        <name>MAJ_Rue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ001_Ville</fullName>
        <field>MailingCity</field>
        <formula>Account.Adresse_Ville__c</formula>
        <name>MAJ Ville</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Champ_Date_Modification_Fiche</fullName>
        <field>Date_Modification_Fiche__c</field>
        <formula>NOW()</formula>
        <name>MAJ Champ Date Modification Fiche</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Pays</fullName>
        <field>MailingCountry</field>
        <formula>Account.CodePays__r.Name</formula>
        <name>MAJ Pays</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Rue1</fullName>
        <field>Adresse_Repli_Rue__c</field>
        <formula>Account.Adresse_Rue__c</formula>
        <name>MAJ Rue1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Ville</fullName>
        <field>Adresse_de_repli_ville__c</field>
        <formula>Account.Adresse_Ville__c</formula>
        <name>MAJ Ville</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_du_Type_d_enregistrement</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Professionnel</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Mise à jour du Type d&apos;enregistrement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Pagelayout_Etudiant</fullName>
        <field>RecordTypeId</field>
        <lookupValue>Etudiant</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>Pagelayout Etudiant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Statut_Professionnel</fullName>
        <field>Statut__c</field>
        <literalValue>Professionnel</literalValue>
        <name>Statut Professionnel</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Statut_Prospect_Etudiant</fullName>
        <field>Statut__c</field>
        <literalValue>Prospect Etudiant</literalValue>
        <name>Statut Prospect Etudiant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Contact_MAJ_DateCr_ation</fullName>
        <field>Date_de_cr_ation_contact__c</field>
        <formula>CreatedDate</formula>
        <name>WF_Contact_MAJ_DateCréation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Changement Statut Etudiant</fullName>
        <actions>
            <name>Changement_Statut_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Etudiant</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changement Statut Etudiant Prospect</fullName>
        <actions>
            <name>Statut_Prospect_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Prospect Etudiant</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changement Statut Professionnel</fullName>
        <actions>
            <name>Statut_Professionnel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Professionnel</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changement de page layout</fullName>
        <actions>
            <name>Pagelayout_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Statut__c</field>
            <operation>equals</operation>
            <value>Etudiant</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Changement de page layout Professionnel</fullName>
        <actions>
            <name>Changement_de_page_layout_Professionnel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Statut__c</field>
            <operation>equals</operation>
            <value>Professionnel</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Code Agresso Tiers Contact</fullName>
        <actions>
            <name>Code_agresso_tiers_contact</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Remplir le champ code tiers contact automatiquement à partir du Compteur Tiers Contact</description>
        <formula>Code_tiers_contact__c = &quot;&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Code Agresso Tiers Participant</fullName>
        <actions>
            <name>Code_agresso_tiers_participant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>remplit automatiquement le champ code tiers participant depuis le champ compteur tiers participant</description>
        <formula>Code_Participant__c = &quot;&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Contact âgé de 40 ans ou plus</fullName>
        <actions>
            <name>Alerte_Contact_g_de_40_ans_ou_plus</name>
            <type>Alert</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Age__c</field>
            <operation>greaterOrEqual</operation>
            <value>40</value>
        </criteriaItems>
        <description>Envoie une alerte email toutes les fois qu&apos;un contact âgé de 40 ans ou plus est détecté</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Forcer type d%27enregistrement à Professionnel</fullName>
        <actions>
            <name>Mise_jour_du_Type_d_enregistrement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.Type_d_enregistrement_Piste__c</field>
            <operation>equals</operation>
            <value>Professionnel</value>
        </criteriaItems>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF Date Modification Fiche</fullName>
        <actions>
            <name>MAJ_Champ_Date_Modification_Fiche</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Ce WF met à jour le champ custom &quot;Date mise à jour fiche&quot;. Il récupère, par défaut la valeur générée par Salesforce dans le champ standard LastModifiedDate</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact01_Changement de page layout</fullName>
        <actions>
            <name>Pagelayout_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Statut__c</field>
            <operation>equals</operation>
            <value>Etudiant</value>
        </criteriaItems>
        <description>Ce workflow permet de modifier la présentation de page à &quot;Etudiant&quot; losqu&apos;on modifie le statut à &quot;Etudiant&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact02_Changement de page layout Professionnel</fullName>
        <actions>
            <name>Changement_de_page_layout_Professionnel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Contact.Statut__c</field>
            <operation>equals</operation>
            <value>Professionnel</value>
        </criteriaItems>
        <description>Ce workflow permet de modifier la présentation de page à &quot;Professionnel&quot; losqu&apos;on modifie le statut à &quot;Professionnel&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact03_Changement Statut Etudiant</fullName>
        <actions>
            <name>Changement_Statut_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Etudiant</value>
        </criteriaItems>
        <description>Ce workflow permet de modifier le statut à &quot;Etudiant&quot; losqu&apos;on modifie la présentation de page à  &quot;Etudiant&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact04_Changement Statut Etudiant Prospect</fullName>
        <actions>
            <name>Statut_Prospect_Etudiant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Prospect Etudiant</value>
        </criteriaItems>
        <description>Ce workflow permet de modifier le statut à &quot;Prospect Etudiant&quot; losqu&apos;on modifie la présentation de page à &quot;Prospect Etudiant&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact05_Changement Statut Professionnel</fullName>
        <actions>
            <name>Statut_Professionnel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Contact.RecordTypeId</field>
            <operation>equals</operation>
            <value>Professionnel</value>
        </criteriaItems>
        <description>Ce workflow permet de modifier le statut à &quot;Professionnel&quot; losqu&apos;on modifie la présentation de page à &quot;Professionnel&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact06_MAJ Adresse Postale</fullName>
        <actions>
            <name>MAJ001_Code_Postal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ001_Region</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ001_Rue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ001_Ville</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Pays</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_ContactLogin</fullName>
        <actions>
            <name>Login_mettre_jour</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Ce workflow permet de saisir le login automatiquement lors de la création d&apos;un contact si le login n&apos;est pas remplit</description>
        <formula>Login__c = &quot;&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact_ChangementSeuil_B2C</fullName>
        <actions>
            <name>Changement_de_seuil_B2C</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>envoie une tâche aux personnes ayant rôles Fundraising B2C lors d&apos;un changement de seuil</description>
        <formula>OR(  
AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;&quot;), Somme_Montant_Don__c &gt; 0),
AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Niveau Zéro&quot;),  Somme_Montant_Don__c &lt; VALUE($Label.ProgrammeReconnaissance_Seuil1_B2C)),
AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Mont Blanc&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil1_B2C)),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Kilimandjaro&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil2_B2C)),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_McKinley&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil3_B2C)),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Annapura&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil4_B2C)),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_K2&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil5_B2C)),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Everest&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil6_B2C)),
AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2C_Cercle du Président&quot;),  Somme_Montant_Don__c &gt;= VALUE($Label.ProgrammeReconnaissance_Seuil7_B2C)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Contact_MAJ_DateCréation</fullName>
        <actions>
            <name>WF_Contact_MAJ_DateCr_ation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>prend date de création standard et la met dans date de création contact</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WK_Contact_MAJ E-mail standard par l%27email EM Lyon</fullName>
        <actions>
            <name>FU_MAJ_Email_standard_par_celui_de_l_EM</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(
ISBLANK(Adresse_Email_Personnelle__c),
ISBLANK(Email_de_repli__c),

ISBLANK(Email),
Appliquer_l_e_mail_professionnel__c=false,
Appliquer_l_e_mail_EM_Lyon__c=false,
Appliquer_l_e_mail_personnel__c=false
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WK_Contact_MAJ E-mail standard par le personnel</fullName>
        <actions>
            <name>FU_MAJ_email_standard_par_le_personnel</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(
ISBLANK(Email),

Appliquer_l_e_mail_professionnel__c=false,
Appliquer_l_e_mail_EM_Lyon__c=false,
Appliquer_l_e_mail_personnel__c=false
)</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WK_Contact_MAJ E-mail standard par le professionnel</fullName>
        <actions>
            <name>FU_MAJ_email_standard_par_le_PRO</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>AND(
ISBLANK(Adresse_Email_Personnelle__c),
ISBLANK(Email),
Appliquer_l_e_mail_professionnel__c=false,
Appliquer_l_e_mail_EM_Lyon__c=false,
Appliquer_l_e_mail_personnel__c=false
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Changement_de_seuil_B2C</fullName>
        <assignedTo>Fundraising_B2B</assignedTo>
        <assignedToType>role</assignedToType>
        <dueDateOffset>10</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Non démarré</status>
        <subject>Changement de seuil B2C</subject>
    </tasks>
</Workflow>
