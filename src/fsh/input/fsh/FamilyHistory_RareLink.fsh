Alias: SNOMEDCT = http://snomed.info/sct

Profile: RareLinkFamilyHistory
Parent: FamilyMemberHistory
Id: rarelink-familyhistory
Title: "RareLink Family History"
Description: "A RareLink-specific FamilyMemberHistory profile based on the FamilyMemberHistory resource."

* meta.profile = "http://hl7.org/fhir/StructureDefinition/FamilyMemberHistory|4.0.1" (exactly)
* status 1..1
* status from http://hl7.org/fhir/ValueSet/family-history-status (required)

* patient 1..1
* patient.reference = "Patient/{id}"

* relationship 1..1
* relationship.coding 1..1
* relationship.coding.system from SNOMEDCT (required)
* relationship.coding.code from FamilyRelationshipVS (required)

* sex 0..1
* sex.coding 1..1
* sex.coding.system from http://hl7.org/fhir/ValueSet/administrative-gender (required)
* sex.coding.code from FamilySexVS (extensible)

* born[x] 0..1
* age[x] 0..1

* deceased[x] 0..1
* condition 0..*

* text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p><strong>RareLink Family History</strong></p>
  <p>This profile is based on the RareLink-CDM Section (6.4) Family History and the FamilyMemberHistory resource.</p>
</div>
"""

* extension contains Propositus named propositus 0..1
* extension contains Consanguinity named consanguinity 0..1

* extension[Propositus]
Extension: Propositus
Id: propositus
Title: "Propositus"
Description: "Indicates whether the family member is the propositus."
* value[x] only CodeableConcept
* valueCodeableConcept.coding 1..1
* valueCodeableConcept.coding.system = "https://www.snomed.org/snomed-ct"
* valueCodeableConcept.coding.code from PropositusVS (extensible)

* extension[Consanguinity]
Extension: Consanguinity
Id: consanguinity
Title: "Consanguinity"
Description: "Indicates whether there is consanguinity in the family relationship."
* value[x] only CodeableConcept
* valueCodeableConcept.coding 1..1
* valueCodeableConcept.coding.system = "https://www.snomed.org/snomed-ct"
* valueCodeableConcept.coding.code from ConsanguinityVS (extensible)

ValueSet: PropositusVS
Id: propositus-vs
Title: "Propositus Value Set"
Description: "Value set for indicating whether the family member is the propositus."
* SNOMEDCT#373066001 "Yes"
* SNOMEDCT#373067005 "No"
* SNOMEDCT#261665006 "Unknown"
* SNOMEDCT#1220561009 "Not recorded"

ValueSet: ConsanguinityVS
Id: consanguinity-vs
Title: "Consanguinity Value Set"
Description: "Value set for indicating whether there is consanguinity in the family relationship."
* SNOMEDCT#373066001 "Yes"
* SNOMEDCT#373067005 "No"
* SNOMEDCT#261665006 "Unknown"
* SNOMEDCT#1220561009 "Not recorded"

ValueSet: FamilyRelationshipVS
Id: family-relationship-vs
Title: "Family Relationship Value Set"
Description: "Value set for capturing family member relationships."
* SNOMEDCT#65656005 "Natural mother"
* SNOMEDCT#9947008 "Natural father"
* SNOMEDCT#83420006 "Natural daughter"
* SNOMEDCT#113160008 "Natural son"
* SNOMEDCT#60614009 "Natural brother"
* SNOMEDCT#73678001 "Natural sister"
* SNOMEDCT#11286003 "Twin sibling"
* SNOMEDCT#45929001 "Half-brother"
* SNOMEDCT#2272004 "Half-sister"
* SNOMEDCT#62296006 "Natural grandfather"
* SNOMEDCT#17945006 "Natural grandmother"
* SNOMEDCT#1220561009 "Not recorded"

ValueSet: FamilySexVS
Id: family-sex-vs
Title: "Family Member Sex Value Set"
Description: "Value set for capturing the sex of a family member."
* SNOMEDCT#248152002 "Female"
* SNOMEDCT#248153007 "Male"
* SNOMEDCT#184115007 "Patient sex unknown"
* SNOMEDCT#32570691000036108 "Intersex"
* SNOMEDCT#1220561009 "Not recorded"
