<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <alerts>
        <fullName>Alerte_information_approbation_20_K</fullName>
        <description>Alerte information approbation &lt; 20 K</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>EMLYON/Approbation_20</template>
    </alerts>
    <alerts>
        <fullName>Approbation_refusee</fullName>
        <description>Approbation refusée</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approbation_Refuse</template>
    </alerts>
    <alerts>
        <fullName>Doublon_opp_formationcourte</fullName>
        <ccEmails>open@eml-executive.com</ccEmails>
        <description>Un workflow donne la possibilité d’envoyer un email à l’adresse fixe open@eml-executive.com à chaque fois</description>
        <protected>false</protected>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approbation</template>
    </alerts>
    <alerts>
        <fullName>Notification</fullName>
        <description>Notification par mail à envoyer au responsable d&apos;activité</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>EMLYON/Approbation_20</template>
    </alerts>
    <alerts>
        <fullName>Notification_par_mail_envoyer_au_responsable_d_activit</fullName>
        <description>Notification par mail à envoyer au responsable d&apos;activité</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>EMLYON/Approbation_50</template>
    </alerts>
    <alerts>
        <fullName>Notification_par_mail_envoyer_au_responsable_d_activit_accord_de_principe</fullName>
        <description>Notification par mail à envoyer au responsable d&apos;activité &quot;accord de principe&quot;</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mabboux@em-lyon.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Mod_le_envoyer_au_responsable_acc_principe</template>
    </alerts>
    <alerts>
        <fullName>Notification_par_mail_envoyer_au_responsable_d_activite_sontrat_signe</fullName>
        <description>Notification par mail à envoyer au responsable d&apos;activité &quot;Contrat signé&quot;</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <recipients>
            <recipient>mabboux@em-lyon.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Mod_le_envoyer_au_responsable_contrat_signe</template>
    </alerts>
    <alerts>
        <fullName>Permet_d_envoyer_un_mail</fullName>
        <description>Permet d&apos;envoyer un mail au propriétaire</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Opportunit_Approuv_e</template>
    </alerts>
    <alerts>
        <fullName>Permet_d_envoyer_un_mail_au_responsable_indiquant_une_demande_d_approbation</fullName>
        <description>Permet d&apos;envoyer un mail au responsable indiquant une demande d&apos;approbation</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approbation</template>
    </alerts>
    <alerts>
        <fullName>Rappel_d_approbation</fullName>
        <description>Rappel d&apos;approbation</description>
        <protected>false</protected>
        <recipients>
            <recipient>charbonnelhette@em-executive.com</recipient>
            <type>user</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/Approbation_rappel</template>
    </alerts>
    <alerts>
        <fullName>tache_remercier_donateur</fullName>
        <description>Une tâche pour remercier le donateur a été créée</description>
        <protected>false</protected>
        <recipients>
            <type>owner</type>
        </recipients>
        <senderType>CurrentUser</senderType>
        <template>unfiled$public/ContactFollowUpSAMPLE</template>
    </alerts>
    <fieldUpdates>
        <fullName>Ajouter_le_nom</fullName>
        <field>Name</field>
        <formula>Programme_chapeau__r.Name</formula>
        <name>Ajouter le nom</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Code_Agresso_Opportunit</fullName>
        <field>Code_Agresso_Opportunit__c</field>
        <formula>CASE(RecordType.DeveloperName,
     &quot;Intra_entreprise&quot;, &quot;IE&quot;,
     &quot;Formation_courte&quot;, &quot;FC&quot;,
     &quot;Programme_Long_Dipl_mant&quot;, &quot;FC&quot;,
      Id )
&amp;
RIGHT(TEXT(YEAR( DATEVALUE(CreatedDate) )),2)
&amp; &quot;-&quot; &amp;
Compteur_OPP__c</formula>
        <name>Code Agresso Opportunité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Date_de_fin_acad_mique</fullName>
        <description>Si l’utilisateur clique sur la date du jour, la date du jour est écrasée par la date de fin académique dans le champ date de clôture.</description>
        <field>CloseDate</field>
        <formula>DATE(  IF(DATE(YEAR(TODAY()), 08, 31) &gt; TODAY(), YEAR(TODAY()), YEAR(TODAY()) + 1), 08, 31)</formula>
        <name>Date de fin académique</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Interet_Supp</fullName>
        <field>StageName</field>
        <literalValue>Intérêt Supplémentaire</literalValue>
        <name>MAJ Interet Supp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Opportunit_sur_mesure_Approuve</fullName>
        <field>A_ete_approuve__c</field>
        <literalValue>1</literalValue>
        <name>MAJ Opportunité Intra Approuvé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <reevaluateOnChange>true</reevaluateOnChange>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Opportunit_sur_mesure_st_A_valider</fullName>
        <field>StageName</field>
        <literalValue>Offre à valider</literalValue>
        <name>MAJ Opportunité Intra Entreprise</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Opportunit_sur_mesure_statut_refus</fullName>
        <field>StageName</field>
        <literalValue>Offre en rédaction</literalValue>
        <name>MAJ OpportunitéIntra statut refusé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Opportunite_sur_mesure_statut</fullName>
        <description>Passage au statut validé</description>
        <field>StageName</field>
        <literalValue>Offre validée</literalValue>
        <name>MAJ Opportunité Intra statut validé</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_Opp_Dipl_mant</fullName>
        <description>Mettre à jour le record type opportunité en fonction du record type du contact (professionnel = Programme Long Diplômant)</description>
        <field>RecordTypeId</field>
        <lookupValue>Programme_Long_Dipl_mant</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ RecordType Opp Diplômant</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_RecordType_Opp_FI</fullName>
        <description>Mettre à jour le record type opportunité en fonction du record type du contact (propect etudiant ou etudiant = FI)</description>
        <field>RecordTypeId</field>
        <lookupValue>Formation_initiale</lookupValue>
        <lookupValueType>RecordType</lookupValueType>
        <name>MAJ RecordType Opp FI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>LookupValue</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_case_pour_cumul_Intra</fullName>
        <field>Case_pour_cumul_Intra__c</field>
        <literalValue>0</literalValue>
        <name>MAJ case pour cumul Intra</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_oppo_type_formation</fullName>
        <field>type_de_formation__c</field>
        <literalValue>OPP-TF20</literalValue>
        <name>MAJ oppo type formation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_oppo_type_formation_2</fullName>
        <field>type_de_formation__c</field>
        <literalValue>OPP-TF10</literalValue>
        <name>MAJ oppo type formation 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_CIN_002</fullName>
        <field>CloseDate</field>
        <formula>DATE(VALUE(TEXT(Exercice__c)), 9, 1)</formula>
        <name>WF-OPPO-01-CIN-002</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_CIN_002_bis</fullName>
        <field>ExerciceNum_ro__c</field>
        <formula>IF(
MONTH(CloseDate)&lt;=08,
TEXT(YEAR( CloseDate )),
(TEXT(YEAR( CloseDate )+1))
)</formula>
        <name>WF-OPPO-01-CIN-002_bis</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Opp_Dernier_Motif_Fermeture</fullName>
        <field>Dernier_motif_de_refus__c</field>
        <formula>TEXT(Motif_de_fermeture__c)</formula>
        <name>WF_Opp_Dernier_Motif_Fermeture</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Opp_ExerciceNum_ro_FI</fullName>
        <field>ExerciceNum_ro__c</field>
        <formula>TEXT(Exercice__c )</formula>
        <name>WF_Opp_ExerciceNuméro_FI</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Opp_MAJ_DateCr_ation</fullName>
        <field>Date_de_mise__c</field>
        <formula>CreatedDate</formula>
        <name>WF_Opp_MAJ_DateCréation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Opp_StatutConclu_Compte</fullName>
        <field>Donateur__c</field>
        <literalValue>1</literalValue>
        <name>WF_Opp_StatutConclu_Compte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
        <targetObject>AccountId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Code Agresso Opportunité</fullName>
        <actions>
            <name>Code_Agresso_Opportunit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>(1 OR 2 OR 3) AND 4</booleanFilter>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation courte</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation intra-entreprise</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Programme Long Diplômant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Code_Agresso_Opportunit__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Remplir le champ code agresso opportunité automatiquement en se basant sur ( RecordType + Date de création (year) + compteur opp)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Date de clôture forcée</fullName>
        <actions>
            <name>Date_de_fin_acad_mique</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Sur une opportunité de type &quot;Relations Employeur&quot;, si l’utilisateur veut que la date de fin académique soit indiquée en date de fermeture, il clique sur la date du jour. À l’enregistrement, la date du jour est écrasée par la date de fin académique.</description>
        <formula>RecordType.Name = &quot;Relations Employeur&quot;  &amp;&amp;  CloseDate  = TODAY()</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>RG-OPP-01-CIN-001</fullName>
        <actions>
            <name>Notification_par_mail_envoyer_au_responsable_d_activit_accord_de_principe</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Accord de principe</value>
        </criteriaItems>
        <description>Au passage au statut « Accord de principe », une notification par mail est envoyée au CDG et au responsable d’activité</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>RG-OPP-01-CIN-002</fullName>
        <actions>
            <name>Notification</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>Au passage au statut « offre validée » et que l’approbateur est le propriétaire CPM, une notification par mail est envoyée au responsable de l’activité</description>
        <formula>AND (  ISCHANGED(A_ete_approuve__c),  A_ete_approuve__c,  RecordType.DeveloperName = &quot;Intra_entreprise&quot;,  Amount &lt; 20000)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RG-OPP-01-CIN-003</fullName>
        <actions>
            <name>Notification_par_mail_envoyer_au_responsable_d_activit</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <description>&gt; 50000</description>
        <formula>AND (  ISCHANGED(A_ete_approuve__c),  A_ete_approuve__c,  RecordType.DeveloperName = &quot;Intra_entreprise&quot;,  Amount &gt; 50000)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>RG-OPP-01-CIN-004</fullName>
        <actions>
            <name>Notification_par_mail_envoyer_au_responsable_d_activite_sontrat_signe</name>
            <type>Alert</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Contrat signé</value>
        </criteriaItems>
        <description>Au passage au statut «Contrat signé », une notification par mail est envoyée au CDG et au responsable d’activité</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO Remplissage type de formation 1</fullName>
        <actions>
            <name>MAJ_oppo_type_formation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Remplir le type de formation s&apos;il n&apos;est pas déjà rempli</description>
        <formula>AND( RecordType.DeveloperName = &quot;Intra_entreprise&quot;,  ISBLANK( Programme_chapeau__c), ISBLANK( TEXT(type_de_formation__c) )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO Remplissage type de formation 2</fullName>
        <actions>
            <name>MAJ_oppo_type_formation_2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Remplir le type de formation s&apos;il n&apos;est pas déjà rempli</description>
        <formula>AND( RecordType.DeveloperName = &quot;Intra_entreprise&quot;,  NOT(ISBLANK(  Programme_chapeau__c ))
, ISBLANK( TEXT(type_de_formation__c) )
)</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-CIN-002</fullName>
        <actions>
            <name>WF_OPPO_01_CIN_002</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation initiale</value>
        </criteriaItems>
        <description>FI : la date de rentrée est mise à jour au 01/09/ N (de l’exercice) après la modification du champ « Exercice »</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-CIN-002_bis</fullName>
        <actions>
            <name>WF_OPPO_01_CIN_002_bis</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Programme Long Diplômant,Formation courte,Formation intra-entreprise</value>
        </criteriaItems>
        <description>FC (long et court) : le champ « exercice » sera mis à jour après la modification de la date de rentrée</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-DON-001</fullName>
        <actions>
            <name>Ajouter_le_nom</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mettre à jour le nom de l&apos;opportunité avec le nom du produit &quot;programme chapeau&quot;</description>
        <formula>Programme_chapeau__c  &lt;&gt; &quot;&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-DON-002</fullName>
        <actions>
            <name>MAJ_RecordType_Opp_Dipl_mant</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Ce workflow permet de modifier le type d&apos;enregistrement de l&apos;opportunité en fonction du type d&apos;enregistrement du contact</description>
        <formula>OR(Contact_central__r.RecordType.DeveloperName = &quot;Professionnel&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-DON-003</fullName>
        <actions>
            <name>MAJ_RecordType_Opp_FI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>OR(Contact_central__r.RecordType.DeveloperName  = &quot;Prospect Etudiant&quot;,Contact_central__r.RecordType.DeveloperName  = &quot;Etudiant&quot;)</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-DON-004</fullName>
        <actions>
            <name>MAJ_Interet_Supp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mettre à jour le champ statut commercial &quot;Intérêt supplémentaire&quot; si le champ &quot;nbre oppo selon critères&quot; est supérieur ou égal à 1 (pour les opportunités en insertion)</description>
        <formula>!ISBLANK(Contact_central__c)  &amp;&amp;  Contact_central__r.nb_SIP_en_cours__c  &gt;= 1 &amp;&amp;  $Profile.Name = &quot;Interface&quot; &amp;&amp; RecordType.Name =&quot;Formation initiale&quot;</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-02-DON-004</fullName>
        <actions>
            <name>MAJ_Interet_Supp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <description>Mettre à jour le champ statut commercial &quot;Intérêt supplémentaire&quot; si le champ &quot;nbre oppo selon critères&quot; est supérieur ou égal à 1 (pour les opportunités en modification)</description>
        <formula>NOT(ISNEW())&amp;&amp; !ISBLANK(Contact_central__c)  &amp;&amp;  Contact_central__r.nb_SIP_en_cours__c  &gt; 1 &amp;&amp;  $Profile.Name = &quot;Interface&quot; &amp;&amp; RecordType.Name =&quot;Formation initiale&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opp_Dernier_Motif_Fermeture</fullName>
        <actions>
            <name>WF_Opp_Dernier_Motif_Fermeture</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <formula>ISCHANGED( Motif_de_fermeture__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opp_ExerciceNuméro_FI</fullName>
        <actions>
            <name>WF_Opp_ExerciceNum_ro_FI</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation initiale</value>
        </criteriaItems>
        <description>FI : Le champ Exercice rempli le champ ExerciceNuméro</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opp_MAJ_DateCréation</fullName>
        <actions>
            <name>WF_Opp_MAJ_DateCr_ation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>prend date de création standard et la met dans date de création fiche</description>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opp_StatutConclu_Compte</fullName>
        <actions>
            <name>WF_Opp_StatutConclu_Compte</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Partenariat Fundraising</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>Conclu</value>
        </criteriaItems>
        <description>Ce wf permet de cocher la case donateur au compte associé à une opp B2B qui est conclue.</description>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opportunite01</fullName>
        <actions>
            <name>Opportunite_tsk01</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <criteriaItems>
            <field>Opportunity.StageName</field>
            <operation>equals</operation>
            <value>A (ré)orienter</value>
        </criteriaItems>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <tasks>
        <fullName>Opportunite_tsk01</fullName>
        <assignedToType>owner</assignedToType>
        <description>Merci de réorienter ce contact.

Lorsque ce contact sera réorienté, fermer l&apos;opportunité actuel et si besoin créer une nouvelle opportunité.</description>
        <dueDateOffset>0</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <offsetFromField>Opportunity.CloseDate</offsetFromField>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Non démarré</status>
        <subject>Réorienter le contact</subject>
    </tasks>
</Workflow>
