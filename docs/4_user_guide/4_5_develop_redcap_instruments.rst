.. _4_5:

Develop REDCap Instruments  
===========================

This section provides a guide for developing REDCap instruments around the
:ref:`2_2`: that can also be processed by the Phenopacket and FHIR pipeline.
If the rules are followd upon development of the REDCap sheets, 
mapping and setup steps will be required to convert the data into the
Phenopackets or FHIR format. For example, see the section :ref:`phenopackets-other-redcap-data-models`
of the :ref:`rarelink-phenopacket-module`. 

_____________________________________________________________________________________

REDCap instrument structure
---------------------------

A REDCap instrument is a collection of fields that are grouped together to
collect data for a specific purpose. The fields can be of different types,
such as text fields, radio buttons, checkboxes, etc. The fields can be
grouped into sections, and the sections can be repeated for a specific number
of times. The fields can also be validated using REDCap's integrated
validators.

_____________________________________________________________________________________

.. _rule-set:

REDCap-inherent rules
----------------------

REDCap variables and choice codes have specific limitations and requirements
you **should or must** comply with when creating your REDCap shets.

- REDCap recommends a maximum of 26 characters for variable names. If possible,
  you should shorten the variable names to adhere to this limit.
- REDCap variables must be unique and must not contain spaces or special 
  characters, therefore only alphanumeric characters and underscores are allowed.

_____________________________________________________________________________________

RareLink obligatory rules
---------------------------

1) Data element output
________________________

The **output (i.e. the answer) to each question in your REDCap instrument MUST be encoded 
with** :ref:`1_2` codes or pass on a validated data field! This is crucial,  
so that the output of a data element is a code or a validated format that can
be processed by the RareLink framework.

   ... in regard to the different REDCap field types:

    - ``Single Choice Dropdown & Radio-Button fields``: the choices (i.e. the 
      data elemen'ts value set) **must** be encoded with :ref:`1_2` codes,
      their official BIOPORTAL prefixes and their respective  *preferred labels*. 

      - e.g.: **snomedct_32218000** or **hp_5200403**.

    - ``Checkboxes (Multiple Answers)fields`` **CANNOT** be processed by the  
      RareLink framework and **should not be used**. Even if the choices are
      encoded with ontology codes, the output are *`1`* or *`0`* for
      each choice while altering the variable names.

    - ``Text fields``: can be used for free text input, but the data **must** 
      either...
      
      - use REDCap's integrated validators, for example for dates, numbers, etc.
      A string or text should only be used when the target data element in 
      :ref:`1_4` or :ref:`1_3` is a string or text field.

      - or use an integrated `BioPortal <https://bioportal.bioontology.org/>`_
        **validation service** to validate the free text input. If you cannot 
        see this option in your REDCap setup, contact you REDCap administrator. 
        This can be set free of charge.


2) REDCap expression repository
________________________________

**REDCap expression repository**: for exporting data to FHIR or Phenopackets,
you will always need the versions of the :ref:`1_2` you are using. REDCap
does not natively include an expression repository, however you can use the
``Field Annotations`` field in each data element to store the version of the
ontology or terminology you are using. You can also use an Excel or word sheet, 
but we recommend keeping these in there so that they are part your project's 
:ref:`1_6` data dictionary.

- Like our :ref:`2_2`, you can also convert your model into a 
  :ref:`rarelink_cdm_linkml` which also provides the possibility to dedicating a 
  section to the codesystems used. (CAVE: this requires coding experince).

- To give more context to the data element, you can also include the mapping to
  the FHIR expression or the GA4GH Phenopacket Schema element, 
  like in the example below.

.. code-block:: bash

    Variable: 
    HP:0012824 | Severity  
    Choices: 
    - HP:0012827 | Borderline  
    - HP:0012825 | Mild  
    - HP:0012826 | Moderate  
    - HP:0012829 | Profound  
    - HP:0012828 | Severe  
    Version(s): 
    - HPO Version 2024-08-13  
    Mapping: 
    - HL7 FHIR Expression v4.0.1: Observation.interpretation  
    - GA4GH Phenopacket Schema v2.0 Element: PhenotypicFeature.severity


RareLink optional rules
-----------------------------

- The REDCap variable names should also be encoded with :ref:`1_2` codes and 
  their respective *preferred labels* and using their official prefix 
  (e.g. *hp_*, *snomedct_*, etc.) so that the concept of an element itself is 
  clear. Also, sometimes FHIR requires a *CodeableConcept* for a specific 
  element.

- If you include the codes in the variable names, you can use suffixes to 
  differentiate between the codes and the variable names. For example, 
  ``snomedct_123456_onset``, or ``snomedct_123456_age``.

- For repeating sections, we recommend using the REDCap **Repeating Instruments**
  feature for separate instruments, which allows you to repeat a section of 
  questions for a specific number of times. See :ref:`3_3` for more information
  on how to activate this feature.


Return to `top <#top>`_.