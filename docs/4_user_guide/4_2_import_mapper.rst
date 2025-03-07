.. _4_2:

Semi-Automatic Import
===========================

While many rare disease centres and hospitals hold specialised data in 
unstructured formats, **RareLink's semi-automatic import guide** provides a means 
to standardize this information through `LinkML <https://linkml.io/>`_ to the :ref:`2_2`. 
Using `LinkML-Map <https://linkml.io/linkml-map/>`_, you can 
convert your local (tabular) data into a :ref:`rarelink_cdm_linkml` JSON 
representation conforming to the :ref:`2_2` for subsequent import to REDCap.

A fully automatic conversion tool is not possible, as the :ref:`2_2` is
based on :ref:`1_2` for which **manual and professional annotation of your data to the
ontology terms is required**. However, to make the process as efficient and user-friendly
as possible, we offer a semi-automatic guide with templates and examples that 
significantly speed up the process of importing your data. Once your data is
processed and validated against the :ref:`2_2`'s :ref:`rarelink_cdm_linkml`,
you can export it diretly to :ref:`1_3`, import it to your local :ref:`1_6` 
project and subsequently also export it to :ref:`1_4`. 

Make sure to read the following sections in this documentation to make yourself 
familiar with the model, the underlying data elements and its ontologies: 

- :ref:`1_2`
- :ref:`1_5`
- :ref:`2_2`

If questions remain and you would like to discuss your data import with us,
please do not hesitate to :ref:`12` us. RareLink is a community-driven project
and we are happy to collaborate wherever possible.

.. hint:: 
   In this process, **you are responsible for the semantic mapping and 
   ontology annotation** of your data elements. This step is critical for 
   ensuring that your data, including genetic mutations validated with HGVS, 
   conforms to the RareLink-CDM standard for Phenopackets and FHIR export and
   expresses the correct semantic meaning of your data.

_________________________

**Overview**

.. contents::
   :local:
   :depth: 3

_________________________

Overview of Components
------------------------
The semi-automatic import process involves several key components:

- **RareLink-CDM LinkML Schema**: 

  The target schema that defines the 
  structure of your data once converted. It is designed to be as close 
  as possible to the original REDCap data model while enabling export 
  to Phenopackets and FHIR. You can find it here:

  - :ref:`2_2`
  - :ref:`rarelink_cdm_linkml` 
  - `RareLink-CDM v2.0.0 LinkML yaml schema files <https://github.com/BIH-CEI/rarelink/tree/develop/src/rarelink_cdm/v2_0_0_dev1/schema_definitions>`_
  - `RareLink-CDM v2.0.0 LinkML python model and classes <https://github.com/BIH-CEI/rarelink/tree/develop/src/rarelink_cdm/v2_0_0_dev1/datamodel>`_
  
- **LinkML Map**: 

  A framework for specifying and executing mappings between 
  data models. You will use a SSSOM (Simple Standard for Sharing Ontological 
  Mappings) file to map your source data to the RareLink-CDM.
  
  - `LinkML Map Documentation <https://linkml.io/linkml-map/>`_
  
- **SSSOM Mapping File**: 
  
  A tab-delimited file that defines the mapping from 
  your local data fields to the target elements in the RareLink-CDM. In the 
  SSSOM file, the *object_id* column represents the target value—either the 
  literal value (e.g., a date) or a standardized code (e.g., SNOMEDCT codes for 
  sex/gender). A RareLink-CDM SSSOM mapping template is provided below 
  as a starting point for your mappings.

   - `SSSOM Specification <https://mapping-commons.github.io/sssom/>`_

- **Semantic Ontology Annotation**

  The process of encoding each data element with an ontology term defined in the
  value sets of the :ref:`2_2` or the ontologies defiend for the respective 
  fields. This step ensures that the semantic meaning of your data is preserved
  and that the mappings are interoperable. This process requires the most 
  attention and is crucial for the correct interpretation of your data. 
  To improve the quality of your mappings, you should use the `ISO/TS 21564 MapQual <https://www.iso.org/standard/71088.html>`_
  standard for evaluating the quality of data mappings between health information
  systems.

  The **ISO/TS 21564 MapQual** is an ISO technical specification that defines
  best practices for evaluating the quality of data mappings between
  health information systems. It provides guidelines for assessing the
  semantic consistency, accuracy, and completeness of mappings, ensuring
  that data is correctly annotated and interoperable. 

  Key steps in the encoding process include:

   - **Identification:** Identify source data elements that require mapping.
   - **Mapping Selection:** Choose appropriate target ontology terms or codes.
   - **Semantic Alignment:** Ensure that each mapping preserves the intended
     meaning of the source data.
   - **Dual Encoding:** Perform encoding and mapping independently by at least
     two experts to improve objectivity and reliability.
   - **Quality Assessment:** Evaluate mappings for accuracy and completeness
     against the established standards.
   - **Documentation:** Record mapping decisions, justifications, and quality
     metrics for transparency and future reference.

_________________________

Steps When Importing Data
--------------------------
The semi-automatic import process consists of the following steps:

1. Mapping
____________

You begin by defining mappings from your local, tabular database to the 
RareLink-CDM using a SSSOM mapping file provided by RareLink. The RareLink-CDM 
has no strict minimal requirements beyond the formal criteria fields. However, 
if an instrument is used, the corresponding required fields must be mapped. 
Depending on the purpose of your data, additional fields should be included; 
for instance, registry data should map consent fields, while analyses involving 
measurements and genetics require the respective clinical and laboratory fields.

.. tip:: 
   For more precise analyses and a more balanced cohort, we recommend defining a
   ruleset for the fields mapped and encoded of your local database.

____


1.1 Understanding the RareLink-CDM data model
""""""""""""""""""""""""""""""""""""""""""""""""

You should familiarize yourself with the RareLink-CDM schema in detail to 
understand the target data model, the structure of the data elements and 
REDCap instruments, and the recommended ontologies. For this, please go through 
the data model and its derivate in REDCap in detail: 

- :ref:`1_5`
- Read the `paper on the RareLink-CDM <https://www.nature.com/articles/s41597-025-04558-z>`_
- :ref:`2_2` and its :ref:`rarelink_cdm_linkml`

.. note:: 
   When selecting one data field from a REDCap instrument, you must also map 
   all fields or define the code or a constant for all fields that are required
   by the instrument. You can find the required fields in the :ref:`cdm_overview` 
   documentation where the cardinality is set to **required (1..1)**.

____

1.2 Mapping Your Data
""""""""""""""""""""""""

Use the provided SSSOM template file to map your local data to the RareLink-CDM.
This template defines standard target predicates and codes, ensuring consistency
in your mappings and facilitating interoperability.

**RareLink-CDM SSSOM Template File**

This template file is designed to assist users in creating mappings from their 
local data sources to the RareLink-CDM target schema. It follows the SSSOM 
(Simple Standard for Sharing Ontological Mappings) specification and includes 
both required and additional optional columns to improve traceability and 
clarity of the mapping process.

The template contains the following columns:

- **subject_id**:  
  A unique identifier for the source record or data element. This value 
  identifies which record in your local database is being mapped.

- **subject_label**:  
  A human-readable label for the source record. This provides context 
  for the mapping and helps users quickly identify the data element.

- **predicate_id**:  
  The mapping relation that specifies the target element in the :ref:`rarelink_cdm_linkml` of 
  the :ref:`2_2`. Use the ``default_prefix:slot_name`` from the
  RareLink-CDM schema, for example:

  - ``rarelink_cdm:snomedct_184099003`` for 2.1 Date of birth, or 
  - ``rarelink_cdm:snomedct_281053000`` for 2.2 Sex at birth. 

- **predicate_label**:  
  The title of the target element from the schema, i.e. the *name* of the element
  itself. This column provides a human-readable description of the target element being mapped.
  For the examples above, these would be ``2.1 Date of birth`` and 
  ``2.2 Sex at birth``respectively.

- **object_id**:  
  The target value in the RareLink-CDM. For literal fields, such as dates, 
  this is the actual value (e.g., "1970-02-15"). For coded fields, such as 
  sex, the object_id is the standardized code from the value set
  (e.g., "SNOMEDCT:248152002" for female) or the code from the code system defined
  by the data element (e.g., "HP:0001250" for a phenotype in element 6.2.1).

- **object_label**: The human-readable label for the target value either from the
  RareLink-CDM value sets or the code system defined by the data element. In 
  the case of dates, a "-" is sufficient.

- **match_type**:  
  Describes the type of mapping used. Commonly this is set to "lexical" 
  when the mapping is based on a direct textual match.

- **mapping_date**:  
  The date when the mapping was created. This column adds traceability 
  and helps with versioning of your mappings.

- **mapping_tool**:  
  The tool or method used to generate the mapping. For example, "manual" 
  indicates that the mapping was curated by a human expert.

.. hint::

   :download:`Download the RareLink-CDM SSSOM template file <../../res/import_mapper_tsvs/rarelink_cdm_sssom_template.tsv>`.

This template provides a minimal yet robust framework for defining your 
mappings. It ensures that each mapping row clearly specifies which source 
element is linked to which target element and how that connection was made. 
By following this template, you can ensure that your mappings are consistent, 
interoperable, and well-documented—key requirements for successful data 
integration in the RareLink-CDM.

Below you can find a **snippet of the RareLink-CDM SSSOM Template File:**

.. code-block:: tsv

   # RareLink-CDM SSSOM Template File
   # This template maps source data elements from a registry CSV file to the target RareLink-CDM schema.
   # SSSOM documentation: https://mapping-commons.github.io/sssom/
   # RareLink-CDM LinkML schema: https://github.com/BIH-CEI/rarelink/tree/develop/src/rarelink_cdm/v2_0_0_dev1/schema_definitions
   #
   # Columns:
   #   subject_id      : Unique identifier for the source record (<record_id>).
   #   subject_label   : Human-readable label for the source record (<source_label>).
   #   predicate_id    : Fully qualified target element (e.g., rarelink_cdm:snomedct_184099003).
   #   predicate_label : Title of the target element from the schema.
   #   object_id       : Target value – a literal (e.g., date, numeric) or a standardized code with prefix.
   #   object_label    : Human-readable label for the target value (use "-" for dates/numerics when no label is needed).
   #   match_type      : Mapping derivation type (e.g., "lexical").
   #   mapping_date    : Date when the mapping was created (<mapping_date>).
   #   mapping_tool    : Method used to create the mapping (e.g., "manual").
   #
   subject_id	subject_label	predicate_id	predicate_label	object_id	object_label	match_type	mapping_date	mapping_tool
   # === Formal Criteria (Singular) ===
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_422549004	"1.1 Pseudonym"	<record_id>	<record_id>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_399423000	"1.2 Date of admission"	<record_id>	<record_id>	lexical	<mapping_date>	manual
   #
   # === Personal Information (Singular) ===
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_184099003	"2.1 Date of birth"	<dob>	-	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_281053000	"2.2 Sex at birth"	<SNOMEDCT_sex_code>	<sex_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_1296886006	"2.3 Karyotypic Sex"	<karyotype_code>	<karyotype_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_263493000	"2.4 Gender Identity"	<SNOMEDCT_gender_code>	<gender_identity_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_370159000	"2.5 Country of birth"	<ISO3166_code>	<ISO3166_code>	lexical	<mapping_date>	manual
   #
   # === Patient Status (Repeating Allowed) ===
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_278844005	"3.1 Vital Status"	<vital_status_code>	<vital_status_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_398299004	"3.2 Time of Death"	<death_date>	<death_date>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_184305005	"3.3 Cause of Death"	<cause_of_death_code>	<cause_of_death_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_105727008	"3.4 Age Category"	<age_category_code>	<age_category_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_412726003	"3.5 Length of Gestation at Birth"	<gestation_length>	<gestation_length>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_723663001	"3.6 Undiagnosed RD Case"	<undiagnosed_flag>	<undiagnosed_flag>	lexical	<mapping_date>	manual
   #
   # === Care Pathway (Repeating Allowed) ===
   <record_id>	"<source_label>"	rarelink_cdm:hl7fhir_enc_period_start	"4.1 Encounter Start"	<encounter_start_date>	-	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:hl7fhir_enc_period_end	"4.2 Encounter End"	<encounter_end_date>	-	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_305058001	"4.3 Encounter Status"	<encounter_status_code>	<encounter_status_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:hl7fhir_encounter_class	"4.4 Encounter Class"	<encounter_class_code>	<encounter_class_label>	lexical	<mapping_date>	manual
   #
   # === Disease Information (Repeating Allowed) ===
   <record_id>	"<source_label>"	rarelink_cdm:disease_coding	"5.0 Disease Coding System"	<disease_coding>	<disease_coding>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_64572001_mondo	"5.1 Disease [MONDO]"	<disease_mondocode>	<disease_label>	lexical	<mapping_date>	manual
   # [...]
   # === Phenotypic Features (Repeating Allowed) ===
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	<phenotype1_code>	<phenotype1_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_363778006	"6.2.2 Phenotypic Feature Status"	<phenotype1_status_code>	<phenotype1_status_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	<phenotype1_onset>	-	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_8116006_resolut	"6.2.4 Resolution Date"	<phenotype1_resolution>	-	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:hp_0003674	"6.2.5 Age of Onset"	<phenotype_age_onset>	<phenotype_age_onset>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:hp_0011008	"6.2.6 Temporal Pattern"	<temporal_pattern_code>	<temporal_pattern_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:hp_0012824	"6.2.7 Phenotype Severity"	<phenotype_severity_code>	<phenotype_severity_label>	lexical	<mapping_date>	manual
   # additional phenotype (if applicable)
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	<phenotype2_code>	<phenotype2_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	<phenotype2_onset>	-	lexical	<mapping_date>	manual
   #
   # === Measurements (Repeating Allowed) ===
   # Measurement 1 
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	<assay_A_code>	<assay_A_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c25712	"6.3.2 Measurement Value"	<measurement_A_value>	<measurement_A_value>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c92571	"6.3.3 Unit"	<unit_A_code>	<unit_A_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c41255	"6.3.4 Interpretation"	<measurement_A_interpretation_code>	<measurement_A_interpretation_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	<time_A_observed>	-	lexical	<mapping_date>	manual
   # Measurement 2 
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	<assay_B_code>	<assay_B_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c25712	"6.3.2 Measurement Value"	<measurement_B_value>	<measurement_B_value>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c92571	"6.3.3 Unit"	<unit_B_code>	<unit_B_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c41255	"6.3.4 Interpretation"	<measurement_B_interpretation_code>	<measurement_B_interpretation_label>	lexical	<mapping_date>	manual
   <record_id>	"<source_label>"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	<time_B_observed>	-	lexical	<mapping_date>	manual
   # [...]
   #
   # you cn find the entire template file here: https://github.com/BIH-CEI/rarelink/tree/develop/docs/_static/res/import_mapper_tsvs

.. tip:: 
   You can view and download all the example csv and sssom mapping files:
   
   - `RareLink-CDM SSSOM Mapping Examples <https://github.com/BIH-CEI/rarelink/tree/develop/docs/_static/res/import_mapper_tsvs>`_ or
   
   - :download:`download the TSV template file directly <../../res/import_mapper_tsvs/rarelink_cdm_sssom_template.tsv>`.

____


2. Semantic Ontology Annotation
_________________________________

According to your mappings, you must encode each data element with its 
recommended ontology term of its 

- **value set** (e.g.: 2.2. Sex at Birth) or 
- **an ontology term of the coding system** defined (e.g. 5.1 Disease [MONDO]).

This step ensures that the semantic meaning of your 
data is preserved and that the mappings are interoperable. Within the 
:ref:`2_2`'s :ref:`rarelink_cdm_linkml` you will find the slot names, the value set 
encodings and the codesystems required for the encoding.

.. note:: 

   As explained above, the `ISO/TS 21564 MapQual <https://www.iso.org/standard/71088.html>`_
   should be followed to ensure the quality of your mappings! In the above 
   section on components you find more details.

Then, write the results into the SSSOM mapping file using the template provided above
into the columns ``object_id`` and ``object_label`` while selecting the correct 
``predicate_id`` and ``predicate_label`` from the RareLink-CDM schema's data elements. 

.. tip:: 
   
   Use the user-friendly Ontology Lookup Service (OLS) to find the correct 
   ontology terms for your data elements. You can access the OLS here: https://www.ebi.ac.uk/ols4/ontologies.
   Do not forget to note the versions of the ontologies used and save it as 
   metadata for your dataset.

____


3. Preparation
_________________________________

Prepare for command execution by ensuring you have:  

   - A valid source data file (e.g., an Excel or CSV export of your local database)  
   - Your SSSOM mapping file  
   - The RareLink-CDM schema file (e.g., ``rarelink_cdm.yaml``)  

LinkML-Map will use these inputs to transform your data into JSON that conforms 
to the RareLink-CDM model.

Then you can run LinkML Map: 

.. code-block:: bash

   linkml-tr map-data -T tr.yaml -s <path_to_rarelink_cdm.yaml> <path_to_my-data.yaml>

____


4. Execution and Validation
_________________________________

Run the integrated RareLink CLI command (e.g., ``rarelink import``) to perform 
the conversion. As part of the execution, validate your data against the RareLink-CDM 
LinkML schema using the following command:

.. code-block:: bash

    linkml-validate --schema src/rarelink_cdm/v2_0_0_dev1/schema_definitions/rarelink_cdm.yaml <path_to_your_data.json>

This validation step ensures that your data conforms to the model before 
proceeding to further export (such as to Phenopackets) or upload to REDCap.

____

5. Next Steps
_________________________________

After validation, your RareLink-CDM data is ready. You may now choose to export 
the data as Phenopackets or upload it to your REDCap project using the command:

.. code-block:: bash

   rarelink redcap upload-records

or export it directly to Phenopackets using: 

.. code-block:: bash

   rarelink phenopackets export

____

Examples
----------
Below we provide an example of a semi-structured tabular database with five 
individuals along with their corresponding SSSOM mapping files.

.. tip:: 
   You can view and download all the example csv and sssom mapping files here: 
   `RareLink-CDM SSSOM Mapping Examples <https://github.com/BIH-CEI/rarelink/tree/develop/docs/_static/res/import_mapper_tsvs>`_.

____

Example: Adult Rare Disease Registry
____________________________________________

Includes clinical, laboratory, patient status, and genetic data.

.. code-block:: csv

   Pseudonym,Sex,Gender,DOB,Disease_Diagnosis,Symptoms,Symptom_Dates,Lab_Measurements,Lab_Measurement_Dates,Patient_Status,Time_at_Last_Visit,Consent_Given,Genetic_Mutation,Zygosity,Mutation_Type,Genomic_Diagnosis
   ADR001,Female,Female,1970-02-15,Wilson Disease,"Hepatic dysfunction; tremors","2020-03-10;2020-04-15","Serum ceruloplasmin:12 mg/dL; ALT:85 U/L","2020-03-12;2020-03-12",Alive,2022-10-01,Y,ATP7B:c.3207C>A,Heterozygous,Missense,Wilson Disease confirmed
   ADR002,Male,Male,1982-07-30,Fabry Disease,"Angiokeratomas; Acroparesthesias","2019-06-20;2019-07-01","α-Gal A activity:Low; Creatinine:1.2 mg/dL","2019-06-22;2019-06-22",Alive,2021-12-15,Y,GLA:c.936+919G>A,Hemizygous,Deletion,Fabry Disease suspected
   ADR003,Female,Female,1965-11-05,Wilson Disease,"Jaundice; Neurological impairment","2018-02-05;2018-03-10","Serum ceruloplasmin:9 mg/dL; Bilirubin:3.2 mg/dL","2018-02-07;2018-02-07",Dead,2018-03-15,N,ATP7B:c.2304insG,Homozygous,Frameshift,Wilson Disease confirmed
   ADR004,Female,Female,1978-04-10,Fabry Disease,"Corneal verticillata; Peripheral neuropathy","2021-01-15;2021-01-20","α-Gal A activity:Borderline; ECG:Abnormal","2021-01-16;2021-01-16",Alive,2022-05-10,Y,GLA:c.937G>T,Hemizygous,Nonsense,Fabry Disease confirmed
   ADR005,Male,Male,1980-12-20,Fabry Disease,"Renal insufficiency; Cardiac issues","2020-11-05;2020-11-05","α-Gal A activity:Low; eGFR:45 mL/min","2020-11-06;2020-11-06",Alive,2022-08-22,Y,GLA:c.937G>A,Hemizygous,Missense,Fabry Disease confirmed

This dataset comprises records for adult patients diagnosed with rare diseases  
such as Wilson Disease and Fabry Disease. It includes essential clinical data  
(e.g., date of birth, sex at birth, disease diagnosis, symptoms, lab measurements,  
patient status, time at last visit, and genetic mutation details). The accompanying  
SSSOM mapping template guides you in mapping these source fields to the RareLink-CDM  
schema.

.. code-block:: tsv

   # Adult Rare Disease Registry SSSOM Mapping Template
   # This template maps key fields from an adult rare disease registry CSV file
   # to the RareLink-CDM target schema.
   #
   subject_id	subject_label	predicate_id	predicate_label	object_id	object_label	match_type	mapping_date	mapping_tool
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_422549004	"1.1 Pseudonym"	ADR001	ADR001	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_184099003	"2.1 Date of birth"	1970-02-15	-	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_281053000	"2.2 Sex at birth"	SNOMEDCT:248152002	Female	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_263493000	"2.4 Gender Identity"	SNOMEDCT:446141000124107	Female gender identity	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_278844005	"3.1 Vital Status"	SNOMEDCT:438949009	Alive	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_64572001_mondo	"5.1 Disease [MONDO]"	MONDO:0012345	Wilson Disease	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:loinc_99498_8	"5.2 Verification status"	HL7FHIR:confirmed	Confirmed	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_106221001_mondo	"6.1.1 Genetic Diagnosis [MONDO]"	MONDO:0012345	Wilson Disease	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:loinc_lp7824_8	"6.1.6 Genetic Mutation String"	ATP7B:c.3207C>A	-	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:loinc_53034_5	"6.1.11 Zygosity"	LOINC:LA6706-1	Heterozygous	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:loinc_48019_4_other	"6.1.13 DNA Change Type"	LOINC:LA6698-0	Missense	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_309370004	"7.1 Consent Status"	hl7fhir_active	"Active"	lexical	2025-01-01	manual
   # Repeating elements: Patient ADR001 has two phenotypic features.
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	HP:0002480	hepatic encephalopathy	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	2020-03-10	-	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	HP:0001337	tremors	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	2020-04-15	-	lexical	2025-01-01	manual
   # Repeating elements: Patient ADR001 has two measurements.
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	LOINC:2064-4	Ceruloplasmin [Mass/volume]	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c25712	"6.3.2 Measurement Value"	12	12	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c92571	"6.3.3 Unit"	UO:0010067	milligram per deciliter	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	2020-03-12	-	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	LOINC:1742-6	Alanine aminotransferase [Enzymatic activity/volume] in Serum or Plasma	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c25712	"6.3.2 Measurement Value"	85	-	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c92571	"6.3.3 Unit"	UO:0000179	unit per liter	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	2020-03-12	-	lexical	2025-01-01	manual
   #
   # Mappings for a second patient (ADR002)
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_422549004	"1.1 Pseudonym"	ADR002	ADR002	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_184099003	"2.1 Date of birth"	1982-07-30	1982-07-30	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_281053000	"2.2 Sex at birth"	SNOMEDCT:248153007	Male	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_278844005	"3.1 Vital Status"	SNOMEDCT:438949009	Alive	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_64572001_mondo	"5.1 Disease [MONDO]"	MONDO:0010526	Fabry Disease	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:loinc_99498_8	"5.2 Verification status"	HL7FHIR:differential	Differential	lexical	2025-01-01	manual
   ADR001	"Patient ADR001"	rarelink_cdm:snomedct_106221001_mondo	"6.1.1 Genetic Diagnosis [MONDO]"	MONDO:0010526	Fabry Disease	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:loinc_lp7824_8	"6.1.6 Genetic Mutation String"	GLA:c.936+919G>A	-	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:loinc_53034_5	"6.1.11 Zygosity"	LOINC:LA6707-9	Hemizygous	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:loinc_48019_4	"6.1.13 DNA Change Type"	LOINC:LA6692-3	Deletion	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_309370004	"7.1 Consent Status"	hl7fhir_active	"Active"	lexical	2025-01-01	manual
   # Repeating elements: Patient ADR002 has two phenotypic features.
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	HP:0001071	Angiokeratoma corporis diffusum	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	2019-06-20	-	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_8116006	"6.2.1 Phenotypic Feature"	HP:0031006	Acroparesthesias	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:snomedct_8116006_onset	"6.2.3 Determination Date"	2019-07-01	-	lexical	2025-01-01	manual
   # Repeating elements: Patient ADR002 has two measurements.
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	LOINC:55908-8	Alpha galactosidase A [Enzymatic activity/volume] in DBS	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c41255	"6.3.4 Interpretation"	NCIT:C78801	Value Below Reference Range	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	2019-06-22	-	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c60819	"6.3.1 Assay"	LOINC:2160-0	Creatinine [Mass/volume] in Serum or Plasma	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c25712	"6.3.2 Measurement Value"	1.2	-	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c92571	"6.3.3 Unit"	UO:0010067	milligram per deciliter	lexical	2025-01-01	manual
   ADR002	"Patient ADR002"	rarelink_cdm:ncit_c82577	"6.3.5 Time Observed"	2019-06-22	-	lexical	2025-01-01	manual
   #
   # Mappings for Patient three, four and five are within the file below.

.. tip:: 
   You can view and download all the example csv and sssom mapping files here: 
   `RareLink-CDM SSSOM Mapping Examples <https://github.com/BIH-CEI/rarelink/tree/develop/docs/_static/res/import_mapper_tsvs>`_.

_____

Additional Resources
----------------------
- `LinkML Map Documentation <https://linkml.io/linkml-map/>`_
- `SSSOM Specification <https://mapping-commons.github.io/sssom/>`_
- `RareLink-CDM Documentation <https://rarelink.readthedocs.io/en/latest/2_rarelink_framework/2_2_rarelink_cdm.html>`_
- `RareLink GitHub Repository <https://github.com/BIH-CEI/rarelink>`_
- `RareLink-CDM SSSOM Mapping Examples <https://github.com/BIH-CEI/rarelink/tree/develop/docs/_static/res/import_mapper_tsvs>`_
- :download:`Download the RareLink-CDM SSSOM template file <../../res/import_mapper_tsvs/rarelink_cdm_sssom_template.tsv>`