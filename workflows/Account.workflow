<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Adresse_facturation_R_gion</fullName>
        <field>BillingState</field>
        <formula>Adresse_facturation_R_gion__c</formula>
        <name>Adresse facturation: Région</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adresse_facturation_code_postal</fullName>
        <field>BillingPostalCode</field>
        <formula>Adresse_facturation_Code_Postal__c</formula>
        <name>Adresse facturation: code postal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adresse_facturation_pays</fullName>
        <field>BillingCountry</field>
        <formula>Adresse_facturation_Pays__r.Name</formula>
        <name>Adresse facturation: pays</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adresse_facturation_rue</fullName>
        <description>Mettre à jour le champ standard Adresse facturation rue</description>
        <field>BillingStreet</field>
        <formula>Adresse_Facturation_Rue__c</formula>
        <name>Adresse facturation: rue</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Adresse_facturation_ville</fullName>
        <field>BillingCity</field>
        <formula>Adresse_facturation_ville__c</formula>
        <name>Adresse facturation: ville</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Code_Agresso</fullName>
        <field>Code_tiers_societe__c</field>
        <formula>Code_Compte__c</formula>
        <name>Code Agresso compte</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compte_Niveau_de_partenariat</fullName>
        <field>Commentaire_Taxe__c</field>
        <formula>Parent.Niveau_de_partenariat_groupe__c</formula>
        <name>Compte Niveau de partenariat</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compte_Niveau_de_partenariat_groupe</fullName>
        <description>Dans les Comptes filiales, le champ &quot;Niveau de partenariat groupe&quot; reprend la valeur du champ &quot;Niveau de partenariat groupe&quot; du Compte Parent</description>
        <field>Niveau_de_partenariat_groupe__c</field>
        <formula>Parent.Niveau_de_partenariat_groupe__c</formula>
        <name>Compte Niveau de partenariat groupe</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Compte_versement</fullName>
        <description>Dans les Comptes filiales, le champ &quot;versement consolidation&quot; reprend la valeur du champ &quot;versement consolidation&quot; du Compte Parent</description>
        <field>Versement_consolid_par_gorupe__c</field>
        <formula>Parent.Versement_consolid_par_gorupe__c</formula>
        <name>Compte versement</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Code_Postal</fullName>
        <field>Adresse_facturation_Code_Postal__c</field>
        <formula>Code_Postal__c</formula>
        <name>MAJ Code Postal</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Facturation_Ligne_2</fullName>
        <field>Adresse_facturation_Ligne_2__c</field>
        <formula>Rue_2__c</formula>
        <name>MAJ Facturation Ligne 2</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Facturation_Ligne_3</fullName>
        <field>Adresse_facturation_Ligne_3__c</field>
        <formula>Ligne_3__c</formula>
        <name>MAJ Facturation Ligne 3</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Rue_Facturation</fullName>
        <field>Adresse_Facturation_Rue__c</field>
        <formula>Adresse_Rue__c</formula>
        <name>MAJ Rue Facturation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>MAJ_Ville_Facturation</fullName>
        <field>Adresse_facturation_ville__c</field>
        <formula>Adresse_Ville__c</formula>
        <name>MAJ Ville Facturation</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Mise_jour_champ_site</fullName>
        <field>Site</field>
        <formula>IF(Adresse_Rue__c !=null, Adresse_Rue__c  &amp; &quot; - &quot;,&quot;&quot;) &amp;  IF(Code_Postal__c!=null,Code_Postal__c &amp; &quot; - &quot;,&quot;&quot;) &amp;  IF(Adresse_Ville__c!=null,Adresse_Ville__c &amp; &quot; - &quot;,&quot;&quot;) &amp;  IF(CodePays__r.Name!=null,CodePays__r.Name,&quot;&quot;)</formula>
        <name>Mise à jour champ site</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <fieldUpdates>
        <fullName>Niveau_de_partenariat_groupe_sans_princi</fullName>
        <field>Niveau_de_partenariat_groupe__c</field>
        <formula>IF(ISPICKVAL(Tranche_verseur__c, &quot;&quot;), &quot;&quot;, 
IF(ISPICKVAL(Tranche_verseur__c, &quot;H&quot;), &quot;&quot;, 
&quot;G&quot;&amp;TEXT(Tranche_verseur__c)))</formula>
        <name>Niveau de partenariat groupe sans princi</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Adresse facturation</fullName>
        <actions>
            <name>Adresse_facturation_R_gion</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Adresse_facturation_code_postal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Adresse_facturation_pays</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Adresse_facturation_rue</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>Adresse_facturation_ville</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <booleanFilter>1 OR 2 OR 3 OR 4 OR 5 OR 6</booleanFilter>
        <criteriaItems>
            <field>Account.Adresse_Facturation_Rue__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_ville__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_R_gion__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_Code_Postal__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.D_partement_pour_WF__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_Pays_WF__c</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <description>Cette règle permet de mettre à jour tous les champs standard &quot;Adresse facturation&quot;</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Code Agresso compte</fullName>
        <actions>
            <name>Code_Agresso</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Remplir le champ code tiers societe automatiquement à partir du code compte (compteur)</description>
        <formula>Code_tiers_societe__c = &quot;&quot;</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compte et niveau de partenariat groupe</fullName>
        <actions>
            <name>Compte_Niveau_de_partenariat_groupe</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Compte_Groupe__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.ParentId</field>
            <operation>notEqual</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compte et niveau de partenariat groupe sans compte principal</fullName>
        <actions>
            <name>Niveau_de_partenariat_groupe_sans_princi</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Compte_Groupe__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <criteriaItems>
            <field>Account.ParentId</field>
            <operation>equals</operation>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>Compte et versement groupe</fullName>
        <actions>
            <name>Compte_versement</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <criteriaItems>
            <field>Account.Compte_Groupe__c</field>
            <operation>equals</operation>
            <value>Faux</value>
        </criteriaItems>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF Gestion champ site pour fusion comptes</fullName>
        <actions>
            <name>Mise_jour_champ_site</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <description>Gère la mise à jour du champ site qui est utilisé lors des fusions de comptes. Ce champ stocke les infos d&apos;adresse du compte pour mieux pouvoir identifier les comptes lors des opérations de fusion.</description>
        <formula>1=1</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Compte01_Adresse facturation</fullName>
        <actions>
            <name>MAJ_Code_Postal</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Facturation_Ligne_2</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Facturation_Ligne_3</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Rue_Facturation</name>
            <type>FieldUpdate</type>
        </actions>
        <actions>
            <name>MAJ_Ville_Facturation</name>
            <type>FieldUpdate</type>
        </actions>
        <active>false</active>
        <booleanFilter>1 AND 2 AND 3 AND 4 AND 5 AND 6 AND 7 AND 8</booleanFilter>
        <criteriaItems>
            <field>Account.Adresse_Facturation_Rue__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_ville__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_R_gion__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_Code_Postal__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.D_partement_pour_WF__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_Pays_WF__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_Ligne_2__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <criteriaItems>
            <field>Account.Adresse_facturation_Ligne_3__c</field>
            <operation>equals</operation>
        </criteriaItems>
        <description>Cette règle permet de mettre à jour  les champs &quot;Adresse facturation&quot; &apos;Rue, code postal et ville) lorsque l&apos;adresse facturation n&apos;est pas renseignée.</description>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <rules>
        <fullName>WF_Compte_ChangementSeuil_B2B</fullName>
        <actions>
            <name>Changement_de_seuil_B2B</name>
            <type>Task</type>
        </actions>
        <active>false</active>
        <description>envoie une tâche  aux personnes ayant rôles Fundraising B2B lors d&apos;un changement de seuil</description>
        <formula>OR(  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;&quot;), Somme_Montant_Don__c &gt; 0),  AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_Mont Blanc&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil1_B2B)), AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_Kilimandjaro&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil2_B2B)), AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_McKinley&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil3_B2B)), AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_Annapura&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil4_B2B)), AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_K2&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil5_B2B)), AND(ISPICKVAL(Programme_de_reconnaissance__c,&quot;B2B_Everest&quot;), Somme_Montant_Don__c  &gt;=  VALUE($Label.ProgrammeReconnaissance_Seuil6_B2B)) )</formula>
        <triggerType>onAllChanges</triggerType>
    </rules>
    <tasks>
        <fullName>Changement_de_seuil_B2B</fullName>
        <assignedTo>Fundraising_B2B</assignedTo>
        <assignedToType>role</assignedToType>
        <dueDateOffset>10</dueDateOffset>
        <notifyAssignee>false</notifyAssignee>
        <priority>Normal</priority>
        <protected>false</protected>
        <status>Non démarré</status>
        <subject>Changement de seuil B2B</subject>
    </tasks>
</Workflow>
