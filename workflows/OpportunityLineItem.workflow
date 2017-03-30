<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Champ_syst_me_clonage</fullName>
        <field>Champ_syst_me_pour_clonage__c</field>
        <formula>&quot;clonage&quot;</formula>
        <name>Champ système clonage</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Eligibilite_Oppo</fullName>
        <field>Eligibilite__c</field>
        <formula>Eligible__c</formula>
        <name>MAJ Eligibilite Oppo</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_InterfaceExternalId</fullName>
        <description>Lorsqu&apos;il n&apos;existe pas, insertion de l&apos;externalId</description>
        <field>InterfaceExternalId__c</field>
        <formula>Product2.ProductCode+Opportunity.ExerciceNum_ro__c+ LOWER(Opportunity.Contact_central__r.Login__c)</formula>
        <name>MAJ InterfaceExternalId</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_lieu_formation_opp</fullName>
        <description>Met à jour le champ lieu de formation de l&apos;opportunité en récupérant la valeur stockée dans le champ lieu sur l&apos;objet session</description>
        <field>Lieu_de_formation__c</field>
        <formula>IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS10&quot;), $Label.Lieu1 , IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS20&quot;),$Label.Lieu2, IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS30&quot;),$Label.Lieu3, IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS40&quot;),$Label.Lieu4, IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS50&quot;),$Label.Lieu5, IF( ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS60&quot;),$Label.Lieu6,&quot;&quot; ))))))</formula>
        <name>MAJ lieu formation opp</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_nom_opportunit</fullName>
        <field>Name</field>
        <formula>PricebookEntry.Product2.Name</formula>
        <name>MAJ nom opportunité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_nom_opportunite</fullName>
        <field>Name</field>
        <formula>PricebookEntry.Product2.Name</formula>
        <name>MAJ nom opportunité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_opportunit_Lieu</fullName>
        <description>pour le devis</description>
        <field>Lieu_de_formation__c</field>
        <formula>IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS10&quot;), $Label.Lieu1 ,
IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS20&quot;),$Label.Lieu2,
IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS30&quot;),$Label.Lieu3,
IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS40&quot;),$Label.Lieu4,
IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS50&quot;),$Label.Lieu5,
IF(
 ISPICKVAL(Session_de_formation__r.Lieu_ls__c, &quot;SF-LS60&quot;),$Label.Lieu6,&quot;&quot;
))))))</formula>
        <name>MAJ opportunité Lieu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_opportunit_info_session</fullName>
        <field>Information_session__c</field>
        <formula>&quot;Du &quot; &amp;TEXT(MONTH(Session_de_formation__r.Date_de_debut_de_session__c))&amp; &quot;/&quot;&amp; TEXT(YEAR(Session_de_formation__r.Date_de_debut_de_session__c)) &amp;&quot; à &quot;&amp; TEXT(MONTH( Session_de_formation__r.Date_de_fin_de_session__c )) &amp; &quot;/&quot;&amp;  TEXT(YEAR(Session_de_formation__r.Date_de_fin_de_session__c))</formula>
        <name>MAJ opportunité info session</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_Jour_Remplissage_Dossier_CANEL</fullName>
        <description>Met à jour le champ Taux de remplissage dossier CANEL de l&apos;opportunité</description>
        <field>Remplissage_Dossier_CANEL__c</field>
        <formula>RemplissageDossierCANEL__c</formula>
        <name>Mise à Jour Remplissage Dossier CANEL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_Jour_Statut_Dossier_CANEL</fullName>
        <description>Met à jour le champ statut dossier CANEL à l&apos;aide de la valeur contenue dans Statut dossier CANEL du poste opportunité</description>
        <field>Statut_Dossier_CANEL__c</field>
        <formula>Statut_dossier__c</formula>
        <name>Mise à Jour Statut Dossier CANEL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_du_prix</fullName>
        <field>UnitPrice</field>
        <formula>Session_de_formation__r.Prix_specifique__c</formula>
        <name>Mise à jour du prix</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Poste_opportunit_MAJ_Code_Agresso</fullName>
        <description>Dedui à partir du compteur de l&apos;opportunité et incrémenté avec le nb de postes pour le rendre unique</description>
        <field>CodeAgresso_Poste_Opportunite__c</field>
        <formula>CASE( Opportunity.RecordType.DeveloperName, 
&quot;Formation_courte&quot;, &quot;FC&quot;, 
&quot;Programme_Long_Dipl_mant&quot;, &quot;FC&quot;, 
&quot;&quot;) 
&amp; 
RIGHT(TEXT(YEAR( DATEVALUE(CreatedDate) )),2) 
&amp; &quot;-&quot; &amp; 
 Code_PO__c</formula>
        <name>Poste opportunité MAJ Code Agresso</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Poste_opportunit_MAJ_lieu</fullName>
        <field>Lieu_de_formation__c</field>
        <formula>Session_de_formation__r.Lieu__c</formula>
        <name>Poste opportunité MAJ lieu</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Poste_opportunit_MAJ_nb_heures</fullName>
        <field>Nombre_d_heures__c</field>
        <formula>Product2.Nombre_d_heures__c</formula>
        <name>Poste opportunité MAJ nb heures</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Poste_opportunit_MAJ_nb_jours</fullName>
        <field>Nombre_de_jours__c</field>
        <formula>Product2.Nombre_de_jours__c</formula>
        <name>Poste opportunité MAJ nb jours</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Poste_opportunite_MAJ_type_produit</fullName>
        <field>Type_produit__c</field>
        <formula>Product2.RecordType.Name</formula>
        <name>Poste opportunité MAJ type produit</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PriorValuer_SF</fullName>
        <field>Session_formation_ancienne_valeur__c</field>
        <formula>PRIORVALUE( Session_Formation_pour_WF__c )</formula>
        <name>PriorValuer SF</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>PriorValuer_SS1</fullName>
        <field>Session_selection_ancienne_valeur__c</field>
        <formula>PRIORVALUE( session_de_selection__c )</formula>
        <name>PriorValuer SS1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>REMISEINTERENTERPRISE</fullName>
        <field>Discount</field>
        <formula>Opportunity.Remise_interentreprise__c</formula>
        <name>REMISE INTERENTERPRISE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_date_derniere_modif</fullName>
        <field>SF_Date_derniere_modification__c</field>
        <formula>NOW()</formula>
        <name>SF date derniere modification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SF_date_derniere_modification</fullName>
        <field>SF_Date_derniere_modification__c</field>
        <formula>NOW()</formula>
        <name>SF date derniere modification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>SS_date_derniere_modification</fullName>
        <field>SS_Date_derniere_modification__c</field>
        <formula>NOW()</formula>
        <name>SS date derniere modification</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Statut_CANEL</fullName>
        <field>Statut_Canel__c</field>
        <formula>TEXT( Statut_candidature__c )</formula>
        <name>Statut CANEL</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Votre_formation</fullName>
        <field>Votre_formation__c</field>
        <formula>Session_de_formation__r.Name</formula>
        <name>Votre formation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_CASEACOCHER</fullName>
        <field>NB_d_heure_et_jour_calculer__c</field>
        <literalValue>1</literalValue>
        <name>WF-CASEACOCHER</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_Eligibilite_Age</fullName>
        <field>Eligibilit_de_l_ge__c</field>
        <formula>C1_eligible_age__c</formula>
        <name>WF-OPPO-01-Eligibilite_Age</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_Eligibilite_Domaine</fullName>
        <field>Eligibilit_du_domaine_d_tudes__c</field>
        <formula>C4_eligible_domaine_d_tudes__c</formula>
        <name>WF-OPPO-01-Eligibilite_Domaine</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_Eligibilite_Niveau</fullName>
        <field>Eligibilit_du_niveau_d_tudes__c</field>
        <formula>C2_eligible_niveau_d_tudes__c</formula>
        <name>WF-OPPO-01-Eligibilite_Niveau</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPPO_01_Eligibilite_NiveauXpPro</fullName>
        <field>Eligibilit_du_niveau_d_exp_rience_pro__c</field>
        <formula>C3_eligible_niveau_xp_pro__c</formula>
        <name>WF-OPPO-01-Eligibilite_NiveauXpPro</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_OPP_NomOpp_FC_COURTE</fullName>
        <field>Name</field>
        <formula>PricebookEntry.Product2.ProductCode &amp;&quot; &quot;&amp;
PricebookEntry.Product2.Name</formula>
        <name>WF_OPP_NomOpp_FC_COURTE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PACKALACARTE</fullName>
        <field>Pack_la_carte__c</field>
        <literalValue>1</literalValue>
        <name>WF-PACKALACARTE</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Literal</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eli_C1</fullName>
        <field>C1_eligible_age__c</field>
        <formula>IF( ISNULL(PricebookEntry.Product2.Age_maximum__c),&quot;Critère non actif pour le produit&quot;, 
IF( ISNULL(Opportunity.Contact_central__r.Age__c),&quot;Manque critère&quot;, 
IF(PricebookEntry.Product2.Age_maximum__c&gt;=Opportunity.Contact_central__r.Age__c, 
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligilbilite_C1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eli_C2</fullName>
        <field>C2_eligible_niveau_d_tudes__c</field>
        <formula>IF(ISNULL(PricebookEntry.Product2.Niveau_d_etudes_numero__c),&quot;Critère non actif pour le produit&quot;, 
IF(ISNULL(Opportunity.Contact_central__r.Niveau_detudes_numero__c),&quot;Manque critère&quot;, 
IF(PricebookEntry.Product2.Niveau_d_etudes_numero__c &lt;= Opportunity.Contact_central__r.Niveau_detudes_numero__c, 
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eli_C3</fullName>
        <field>C3_eligible_niveau_xp_pro__c</field>
        <formula>IF(ISNULL(PricebookEntry.Product2.Niveau_xp_pro_num_ro__c),&quot;Critère non actif pour le produit&quot;, 
IF(ISNULL(Opportunity.Contact_central__r.Niveau_xp_pro_num_ro__c),&quot;Manque critère&quot;, 
IF(PricebookEntry.Product2.Niveau_xp_pro_num_ro__c &lt;= Opportunity.Contact_central__r.Niveau_xp_pro_num_ro__c, 
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eli_C4</fullName>
        <field>C4_eligible_domaine_d_tudes__c</field>
        <formula>IF(ISBLANK(PricebookEntry.Product2.Domaine_tudes_formule__c),&quot;Critère OK&quot;, 
IF( 
(ISBLANK(TEXT(Opportunity.Contact_central__r.Domaine__c))) 
,&quot;Critère OK&quot;, 
IF( 
OR( 
CONTAINS(PricebookEntry.Product2.Domaine_tudes_formule__c,TEXT(Opportunity.Contact_central__r.Domaine__c)), 
(ISPICKVAL(Opportunity.Contact_central__r.Domaine__c, &quot;Non renseigné&quot;)) 
) 
,&quot;Critère OK&quot;,&quot;Critère OK&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eligibilite_C2</fullName>
        <field>C2_eligible_niveau_d_tudes__c</field>
        <formula>IF(ISNULL(PricebookEntry.Product2.Niveau_d_etudes_numero__c),&quot;Critère non actif pour le produit&quot;,
IF(ISNULL(Opportunity.Contact_central__r.Niveau_detudes_numero__c),&quot;Manque critère&quot;,
IF(PricebookEntry.Product2.Niveau_d_etudes_numero__c &lt;= Opportunity.Contact_central__r.Niveau_detudes_numero__c,
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eligibilite_C3</fullName>
        <field>C3_eligible_niveau_xp_pro__c</field>
        <formula>IF(ISNULL(PricebookEntry.Product2.Niveau_xp_pro_num_ro__c),&quot;Critère non actif pour le produit&quot;,
IF(ISNULL(Opportunity.Contact_central__r.Niveau_xp_pro_num_ro__c),&quot;Manque critère&quot;,
IF(PricebookEntry.Product2.Niveau_xp_pro_num_ro__c &lt;= Opportunity.Contact_central__r.Niveau_xp_pro_num_ro__c,
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eligibilite_C4</fullName>
        <field>C4_eligible_domaine_d_tudes__c</field>
        <formula>IF(ISBLANK(PricebookEntry.Product2.Domaine_tudes_formule__c),&quot;Critère non actif pour le produit&quot;, 
IF(
(ISBLANK(TEXT(Opportunity.Contact_central__r.Domaine__c)))
,&quot;Manque critère&quot;, 
IF(
OR(
CONTAINS(PricebookEntry.Product2.Domaine_tudes_formule__c,TEXT(Opportunity.Contact_central__r.Domaine__c)),
(ISPICKVAL(Opportunity.Contact_central__r.Domaine__c, &quot;non renseignée&quot;)) 
)
,&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligibilite_C4</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_PosteOpportunite_eligilbilite_C1</fullName>
        <field>C1_eligible_age__c</field>
        <formula>IF( ISNULL(PricebookEntry.Product2.Age_maximum__c),&quot;Critère non actif pour le produit&quot;, 
IF( ISNULL(Opportunity.Contact_central__r.Age__c),&quot;Manque critère&quot;, 
IF(PricebookEntry.Product2.Age_maximum__c&gt;=Opportunity.Contact_central__r.Age__c,
&quot;Critère OK&quot;,&quot;Critère KO&quot;)))</formula>
        <name>WF_PosteOpportunite_eligilbilite_C1</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>WF_Posteopportunit</fullName>
        <field>InterfaceExternalId__c</field>
        <formula>Product2.ProductCode+Opportunity.ExerciceNum_ro__c+ LOWER(Opportunity.Contact_central__r.Login__c)</formula>
        <name>WF_Posteopportunité</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>date_de_d_but</fullName>
        <field>Date_de_d_but__c</field>
        <formula>Session_de_formation__r.Date_de_debut_de_session__c</formula>
        <name>date de début</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>date_de_fin_session</fullName>
        <field>Date_fin_formation__c</field>
        <formula>Session_de_formation__r.Date_de_fin_de_session__c</formula>
        <name>date de fin session</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
        <targetObject>OpportunityId</targetObject>
    </fieldUpdates>
    <rules>
        <fullName>Champ système clonage</fullName>
        <actions>
            <name>Champ_syst_me_clonage</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onCreateOnly</triggerType>
    </rules>
    <rules>
        <fullName>InterfaceExternalId Poste</fullName>
        <actions>
            <name>WF_Posteopportunit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Interface ExternalID Poste</description>
        <formula>AND( 
Opportunity.RecordType.Name  =&quot;Formation initiale&quot;, 
NOT (ISBLANK (Opportunity.Contact_central__r.Login__c )) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>REMISE INTERENTERPRISE</fullName>
        <actions>
            <name>REMISEINTERENTERPRISE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation courte,Programme Long Diplômant</value>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.Contrat_cadre__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Statut CANEL</fullName>
        <actions>
            <name>Statut_CANEL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Statut Dossier CANEL</fullName>
        <actions>
            <name>Mise_Jour_Statut_Dossier_CANEL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>1=1</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
    <rules>
        <fullName>WF Mise à jour Remplissage Dossier CANEL</fullName>
        <actions>
            <name>Mise_Jour_Remplissage_Dossier_CANEL</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Met à jour le champ Taux de Remplissage Dossier CANEL au niveau de l&apos;opportunité toutes les fois que le champ Remplissage dossier CANEL du poste opportunité évolue</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF Poste opportunité MAJ Code Agresso</fullName>
        <actions>
            <name>Poste_opportunit_MAJ_Code_Agresso</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.CodeAgresso_Poste_Opportunite__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Opportunity.RecordTypeId</field>
            <operation>equals</operation>
            <value>Formation courte,Programme Long Diplômant</value>
        </criteriaItems>
        <description>Remplir le champ code agresso opportunité automatiquement en se basant sur ( RecordType + Date de création (year) + compteur opp)</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF SFormation ancienne valeur</fullName>
        <actions>
            <name>PriorValuer_SF</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SF_date_derniere_modif</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( Session_de_formation__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF SSelection ancienne valeur</fullName>
        <actions>
            <name>PriorValuer_SS1</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>SS_date_derniere_modification</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>ISCHANGED( session_de_selection__c )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF lieu formation sur opp</fullName>
        <actions>
            <name>MAJ_lieu_formation_opp</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>ce wf gère la localisation sur l&apos;opportunité du lieu de formation déclaré au niveau session de formation</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-CASEACOCHERNBJOURHEURE</fullName>
        <actions>
            <name>WF_CASEACOCHER</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2</booleanFilter>
        <criteriaItems>
            <field>Product2.Pack_la_carte__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <criteriaItems>
            <field>Product2.RecordTypeId</field>
            <operation>notEqual</operation>
            <value>Pack</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-EligibiliteAJ</fullName>
        <actions>
            <name>MAJ_Eligibilite_Oppo</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>OpportunityLineItem.Eligible__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-Eligibilite_Age</fullName>
        <actions>
            <name>WF_OPPO_01_Eligibilite_Age</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-Eligibilite_Domaine</fullName>
        <actions>
            <name>WF_OPPO_01_Eligibilite_Domaine</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-Eligibilite_Niveau</fullName>
        <actions>
            <name>WF_OPPO_01_Eligibilite_Niveau</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-OPPO-01-Eligibilite_NiveauXpPro</fullName>
        <actions>
            <name>WF_OPPO_01_Eligibilite_NiveauXpPro</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>TRUE</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF-PACKALACARTE</fullName>
        <actions>
            <name>WF_PACKALACARTE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Product2.Pack_la_carte__c</field>
            <operation>equals</operation>
            <value>Vrai</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opportunite02</fullName>
        <actions>
            <name>MAJ_nom_opportunite</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour du nom</description>
        <formula>AND( Opportunity.RecordType.Name &lt;&gt;&quot;Formation courte&quot;,  OR(Product2.RecordType.DeveloperName = &quot;Programme&quot;, Product2.RecordType.DeveloperName = &quot;Pack&quot;,  AND ( Opportunity.Parcours__c =false ,Product2.RecordType.DeveloperName = &quot;Module&quot;) )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opportunite02_FC_COURTE</fullName>
        <actions>
            <name>WF_OPP_NomOpp_FC_COURTE</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour du nom pour FC COURTE</description>
        <formula>AND(  Opportunity.RecordType.Name =&quot;Formation courte&quot;,  OR(Product2.RecordType.DeveloperName = &quot;Programme&quot;, Product2.RecordType.DeveloperName = &quot;Pack&quot;,  AND ( Opportunity.Parcours__c =false ,Product2.RecordType.DeveloperName = &quot;Module&quot;) )  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opportunite03</fullName>
        <actions>
            <name>MAJ_InterfaceExternalId</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>rempli l&apos;interface external id  de l&apos;opportunité</description>
        <formula>AND(  ISBLANK (Opportunity.InterfaceExternalId__c),  OR( Opportunity.RecordType.Name =&quot;Formation initiale&quot;),  NOT (ISBLANK (Opportunity.Contact_central__r.Login__c ))  )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Opportunite_infos_devis</fullName>
        <actions>
            <name>MAJ_opportunit_Lieu</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_opportunit_info_session</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Votre_formation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>date_de_d_but</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>date_de_fin_session</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Mise à jour des champs descriptifs pour le devis</description>
        <formula>OR( Product2.RecordType.DeveloperName  = &quot;Pack&quot;,  AND ( Opportunity.Parcours__c =false ,Product2.RecordType.DeveloperName = &quot;Module&quot;) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_Remplissage depuis produit</fullName>
        <actions>
            <name>Poste_opportunit_MAJ_lieu</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Poste_opportunit_MAJ_nb_heures</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Poste_opportunit_MAJ_nb_jours</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Poste_opportunite_MAJ_type_produit</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_eligibilite_C2</fullName>
        <actions>
            <name>WF_PosteOpportunite_eli_C2</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_eligibilite_C3</fullName>
        <actions>
            <name>WF_PosteOpportunite_eli_C3</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_eligibilite_C4</fullName>
        <actions>
            <name>WF_PosteOpportunite_eli_C4</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_eligilbilite_C1</fullName>
        <actions>
            <name>WF_PosteOpportunite_eli_C1</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>true</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_PosteOpportunite_mise_a_jour_prix</fullName>
        <actions>
            <name>Mise_jour_du_prix</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND(ISCHANGED(Session_de_formation__c), NOT(ISNULL(Session_de_formation__r.Prix_specifique__c ) ))</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
</Workflow>
