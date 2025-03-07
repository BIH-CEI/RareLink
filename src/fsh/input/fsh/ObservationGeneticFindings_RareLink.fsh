// ──────────────────────────────────────────────────────────────────────────
// Aliases (no conflicting redefinitions):
//   - LOINC = http://loinc.org
//   - THL7ObsCat = http://terminology.hl7.org/CodeSystem/observation-category
//   - THL7v2_0074 = http://terminology.hl7.org/CodeSystem/v2-0074
//   - HL7GRTbdCs = http://hl7.org/fhir/uv/genomics-reporting/CodeSystem/tbd-codes-cs
// ──────────────────────────────────────────────────────────────────────────

Alias: THL7ObsCat = http://terminology.hl7.org/CodeSystem/observation-category
Alias: THL7v2_0074 = http://terminology.hl7.org/CodeSystem/v2-0074
Alias: HL7GRTbdCs = http://hl7.org/fhir/uv/genomics-reporting/CodeSystem/tbd-codes-cs

// ──────────────────────────────────────────────────────────────────────────
// Profile 1: RareLinkGeneticVariant
// Parent = HL7 Genomics Reporting 'variant' (Observation)
// ──────────────────────────────────────────────────────────────────────────
Profile: RareLinkGeneticVariant
Parent: http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/variant
Id: rarelink-genetic-variant
Title: "RareLink Genetic Variant Observation"
Description: "
  A RareLink-specific profile for documenting genetic findings 
  (genetic_findings.variant), based on the HL7 Genomics Reporting variant profile.
"

// Fix the meta.profile to the official variant version 3.0.0
* meta.profile = "http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/variant|3.0.0" (exactly)

// We cannot assign resourceType again because it's already Observation.

// Observation.status = final
* status = #final (exactly)

// code => LOINC 69548-6 (Genetic variant assessment)
* code.coding.system = "http://loinc.org" (exactly)
* code.coding.code = #69548-6 (exactly)
* code.coding.version = "2.78"
* code.coding.display = "Genetic variant assessment"

// method => 0..1, codings => 0..*
* method 0..1
* method.coding 0..*
* method.coding from StructuralVariantMethodVS (extensible)

// category => rename slices to avoid conflicts with any existing slices
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "coding"
* category ^slicing.rules = #open

* category contains rarelinkLabCategory 1..1
* category[rarelinkLabCategory].coding 1..1
* category[rarelinkLabCategory].coding.system = "http://terminology.hl7.org/CodeSystem/observation-category" (exactly)
* category[rarelinkLabCategory].coding.code = #laboratory (exactly)

* category contains rarelinkGeCategory 1..1
* category[rarelinkGeCategory].coding 1..1
* category[rarelinkGeCategory].coding.system = "http://terminology.hl7.org/CodeSystem/v2-0074" (exactly)
* category[rarelinkGeCategory].coding.code = #GE (exactly)

// subject => must exist
* subject 1..1

// Slicing 'component' for each LOINC-coded item
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #open

// (1) genomic-hgvs => LOINC 81290-9
* component contains genomicHgvs 0..1
* component[genomicHgvs].code.coding.system = "http://loinc.org" (exactly)
* component[genomicHgvs].code.coding.code = #81290-9
* component[genomicHgvs].code.coding.version = "2.78"
* component[genomicHgvs].code.coding.display = "Genomic DNA change (gHGVS)"
* component[genomicHgvs].value[x] only CodeableConcept
* component[genomicHgvs].valueCodeableConcept.coding.system = "http://varnomen.hgvs.org" (exactly)


// (2) genomic-ref-seq => LOINC 48013-7
* component contains genomicRefSeq 0..1
* component[genomicRefSeq].code.coding.system = "http://loinc.org" (exactly)
* component[genomicRefSeq].code.coding.code = #48013-7
* component[genomicRefSeq].code.coding.version = "2.78"
* component[genomicRefSeq].code.coding.display = "Genomic reference sequence [ID]"
* component[genomicRefSeq].value[x] only CodeableConcept

// (3) representative-coding-hgvs => LOINC 48004-6
* component contains representativeCodingHgvs 0..1
* component[representativeCodingHgvs].code.coding.system = "http://loinc.org" (exactly)
* component[representativeCodingHgvs].code.coding.code = #48004-6
* component[representativeCodingHgvs].code.coding.version = "2.78"
* component[representativeCodingHgvs].code.coding.display = "DNA change (c.HGVS)"
* component[representativeCodingHgvs].value[x] only CodeableConcept
* component[representativeCodingHgvs].valueCodeableConcept.coding.system = "http://varnomen.hgvs.org" (exactly)


// (4) representative-transcript-ref-seq => LOINC 51958-7
* component contains representativeTranscriptRefSeq 0..1
* component[representativeTranscriptRefSeq].code.coding.system = "http://loinc.org" (exactly)
* component[representativeTranscriptRefSeq].code.coding.code = #51958-7
* component[representativeTranscriptRefSeq].code.coding.version = "2.78"
* component[representativeTranscriptRefSeq].code.coding.display = "Transcript reference sequence [ID]"
* component[representativeTranscriptRefSeq].value[x] only CodeableConcept

// (5) representative-protein-hgvs => LOINC 48005-3
* component contains representativeProteinHgvs 0..1
* component[representativeProteinHgvs].code.coding.system = "http://loinc.org" (exactly)
* component[representativeProteinHgvs].code.coding.code = #48005-3
* component[representativeProteinHgvs].code.coding.version = "2.78"
* component[representativeProteinHgvs].code.coding.display = "Amino acid change (pHGVS)"
* component[representativeProteinHgvs].value[x] only CodeableConcept
* component[representativeProteinHgvs].valueCodeableConcept.coding.system = "http://varnomen.hgvs.org" (exactly)


// (6) representative-protein-ref-seq => from tbd-codes-cs
* component contains representativeProteinRefSeq 0..1
* component[representativeProteinRefSeq].code.coding.system = "http://hl7.org/fhir/uv/genomics-reporting/CodeSystem/tbd-codes-cs" (exactly)
* component[representativeProteinRefSeq].code.coding.code = #protein-ref-seq
* component[representativeProteinRefSeq].code.coding.version = "3.0.0"
* component[representativeProteinRefSeq].code.coding.display = "An identifier for the protein reference sequence."
* component[representativeProteinRefSeq].value[x] only CodeableConcept

// (7) reference-sequence-assembly => LOINC 62374-4
* component contains referenceSequenceAssembly 0..1
* component[referenceSequenceAssembly].code.coding.system = "http://loinc.org" (exactly)
* component[referenceSequenceAssembly].code.coding.code = #62374-4
* component[referenceSequenceAssembly].code.coding.version = "2.78"
* component[referenceSequenceAssembly].code.coding.display = "Human reference sequence assembly version"
* component[referenceSequenceAssembly].value[x] only CodeableConcept
* component[referenceSequenceAssembly].valueCodeableConcept from ReferenceGenomeVS (required)

// (8) gene-studied => LOINC 48018-6
* component contains geneStudied 0..1
* component[geneStudied].code.coding.system = "http://loinc.org" (exactly)
* component[geneStudied].code.coding.code = #48018-6
* component[geneStudied].code.coding.version = "2.78"
* component[geneStudied].code.coding.display = "Gene studied [ID]"
* component[geneStudied].value[x] only CodeableConcept
* component[geneStudied].valueCodeableConcept.coding.system = "http://www.genenames.org" (exactly)

// (9) allelic-state => LOINC 53034-5
* component contains allelicState 0..1
* component[allelicState].code.coding.system = "http://loinc.org" (exactly)
* component[allelicState].code.coding.code = #53034-5
* component[allelicState].code.coding.version = "2.78"
* component[allelicState].code.coding.display = "Allelic state"
* component[allelicState].value[x] only CodeableConcept
* component[allelicState].valueCodeableConcept from ZygosityVS (extensible)

// (10) genomic-source-class => LOINC 48002-0
* component contains genomicSourceClass 0..1
* component[genomicSourceClass].code.coding.system = "http://loinc.org" (exactly)
* component[genomicSourceClass].code.coding.code = #48002-0
* component[genomicSourceClass].code.coding.version = "2.78"
* component[genomicSourceClass].code.coding.display = "Genomic source class [Type]"
* component[genomicSourceClass].value[x] only CodeableConcept
* component[genomicSourceClass].valueCodeableConcept from GenomicSourceClassVS (required)

// (11) coding-change-type => LOINC 48019-4
* component contains codingChangeType 0..1
* component[codingChangeType].code.coding.system = "http://loinc.org" (exactly)
* component[codingChangeType].code.coding.code = #48019-4
* component[codingChangeType].code.coding.version = "2.78"
* component[codingChangeType].code.coding.display = "DNA change type"
* component[codingChangeType].value[x] only CodeableConcept
* component[codingChangeType].valueCodeableConcept from DNAChangeTypeVS (extensible)

// Optional: narrative
* text.status = #generated
* text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p><strong>RareLink Observation</strong></p>
  <p>This observation is generated as part of the RareLink REDCap project and its Common Data Model (CDM).</p>
</div>
"""

// ──────────────────────────────────────────────────────────────────────────
// Profile 2: RareLinkDiagnosticImplication
// Parent = HL7 Genomics Reporting 'diagnostic-implication' (Observation)
// ──────────────────────────────────────────────────────────────────────────
Profile: RareLinkDiagnosticImplication
Parent: http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/diagnostic-implication
Id: rarelink-diagnostic-implication
Title: "RareLink Diagnostic Implication Observation"
Description: "
  A RareLink-specific profile extending the HL7 Genomics Reporting 'diagnostic-implication' profile 
  for documenting diagnostic significance, evidence levels, and associated phenotypes 
  (genetic_findings.diagnostic_implication).
"

// meta.profile => official diagnostic-implication version
* meta.profile = "http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/diagnostic-implication|3.0.0" (exactly)

// Can't fix resourceType again; it's already Observation.

// status => final
* status = #final (exactly)

// code => 'diagnostic-implication' from the tbd-codes-cs
* code.coding.system = "http://hl7.org/fhir/uv/genomics-reporting/CodeSystem/tbd-codes-cs" (exactly)
* code.coding.code = #diagnostic-implication (exactly)
* code.coding.version = "3.0.0"
* code.coding.display = "Diagnostic Implication"

// category => rename slices to avoid duplicates
* category ^slicing.discriminator[0].type = #pattern
* category ^slicing.discriminator[0].path = "coding"
* category ^slicing.rules = #open

* category contains rarelinkLabCategory 1..1
* category[rarelinkLabCategory].coding 1..1
* category[rarelinkLabCategory].coding.system = "http://terminology.hl7.org/CodeSystem/observation-category" (exactly)
* category[rarelinkLabCategory].coding.code = #laboratory (exactly)

* category contains rarelinkGeCategory 1..1
* category[rarelinkGeCategory].coding 1..1
* category[rarelinkGeCategory].coding.system = "http://terminology.hl7.org/CodeSystem/v2-0074" (exactly)
* category[rarelinkGeCategory].coding.code = #GE (exactly)

// derivedFrom => rename slice to avoid collision w/ parent's "variant"
* derivedFrom ^slicing.discriminator[0].type = #pattern
* derivedFrom ^slicing.discriminator[0].path = "$this"
* derivedFrom ^slicing.rules = #open

* derivedFrom contains rarelinkVariant 1..1
* derivedFrom[rarelinkVariant].reference 1..1

// Slicing for component
* component ^slicing.discriminator[0].type = #pattern
* component ^slicing.discriminator[0].path = "code"
* component ^slicing.rules = #open

// (1) evidence-level => LOINC 93044-6
* component contains evidenceLevel 0..1
* component[evidenceLevel].code.coding.system = "http://loinc.org" (exactly)
* component[evidenceLevel].code.coding.code = #93044-6
* component[evidenceLevel].code.coding.version = "2.78"
* component[evidenceLevel].code.coding.display = "Level of evidence"
* component[evidenceLevel].value[x] only CodeableConcept
* component[evidenceLevel].valueCodeableConcept from LevelOfEvidenceVS (required)

// (2) clinical-significance => LOINC 53037-8
* component contains clinicalSignificance 0..1
* component[clinicalSignificance].code.coding.system = "http://loinc.org" (exactly)
* component[clinicalSignificance].code.coding.code = #53037-8
* component[clinicalSignificance].code.coding.version = "2.78"
* component[clinicalSignificance].code.coding.display = "Genetic variation clinical significance [Imp]"
* component[clinicalSignificance].value[x] only CodeableConcept
* component[clinicalSignificance].valueCodeableConcept from ClinicalSignificanceVS (required)

// (3) predicted-phenotype => LOINC 81259-4
* component contains predictedPhenotype 0..1
* component[predictedPhenotype].code.coding.system = "http://loinc.org" (exactly)
* component[predictedPhenotype].code.coding.code = #81259-4
* component[predictedPhenotype].code.coding.version = "2.78"
* component[predictedPhenotype].code.coding.display = "Associated phenotype"
* component[predictedPhenotype].value[x] only CodeableConcept

* component[predictedPhenotype].valueCodeableConcept.coding ^slicing.discriminator[0].type = #value
* component[predictedPhenotype].valueCodeableConcept.coding ^slicing.discriminator[0].path = "system"
* component[predictedPhenotype].valueCodeableConcept.coding ^slicing.rules = #closed

* component[predictedPhenotype].valueCodeableConcept.coding contains mondo 0..* and omim 0..*
* component[predictedPhenotype].valueCodeableConcept.coding[mondo].system = "http://purl.obolibrary.org/obo/mondo.owl" (exactly)
* component[predictedPhenotype].valueCodeableConcept.coding[omim].system = "http://omim.org" (exactly)

// Narrative text
* text.status = #extensions
* text.div = """
<div xmlns="http://www.w3.org/1999/xhtml">
  <p><strong>RareLink Observation</strong></p>
  <p>This observation is generated as part of the RareLink REDCap project and its CDM.</p>
</div>
"""

// ──────────────────────────────────────────────────────────────────────────
// Value Sets
// ──────────────────────────────────────────────────────────────────────────

// 1) Structural Variant Method ValueSet
ValueSet: StructuralVariantMethodVS
Id: structural-variant-method-vs
Title: "Structural Variant Method Value Set"
Description: "LOINC LA codes enumerating methods for detecting structural variants."
* LOINC#LA26406-1 "Karyotyping"
* LOINC#LA26404-6 "FISH"
* LOINC#LA26418-6 "PCR"
* LOINC#LA26419-4 "qPCR (real-time PCR)"
* LOINC#LA26400-4 "SNP array"
* LOINC#LA26813-8 "Restriction fragment length polymorphism (RFLP)"
* LOINC#LA26810-4 "DNA hybridization"
* LOINC#LA26398-0 "Sequencing"
* LOINC#LA26415-2 "MLPA"
* LOINC#LA46-8 "Other"

// 2) Reference Genome ValueSet
ValueSet: ReferenceGenomeVS
Id: reference-genome-vs
Title: "Reference Genome Value Set"
Description: "LOINC LA codes specifying the reference genome build."
* LOINC#LA14032-9 "NCBI Build 34 (hg16)"
* LOINC#LA14029-5 "GRCh37 (hg19)"
* LOINC#LA14030-3 "NCBI Build 36.1 (hg18)"
* LOINC#LA14031-1 "NCBI Build 35 (hg17)"
* LOINC#LA26806-2 "GRCh38 (hg38)"

// 3) Zygosity ValueSet
ValueSet: ZygosityVS
Id: zygosity-vs
Title: "Zygosity Value Set"
Description: "LOINC LA codes enumerating various zygosity states."
* LOINC#LA6705-3 "Homozygous"
* LOINC#LA6706-1 "(simple) Heterozygous"
* LOINC#LA26217-2 "Compound heterozygous"
* LOINC#LA26220-6 "Double heterozygous"
* LOINC#LA6707-9 "Hemizygous"
* LOINC#LA6703-8 "Heteroplasmic"
* LOINC#LA6704-6 "Homoplasmic"

// 4) Genomic Source Class ValueSet
ValueSet: GenomicSourceClassVS
Id: genomic-source-class-vs
Title: "Genomic Source Class Value Set"
Description: "LOINC LA codes enumerating germline, somatic, fetal, etc."
* LOINC#LA6683-2 "Germline"
* LOINC#LA6684-0 "Somatic"
* LOINC#LA10429-1 "Fetal"
* LOINC#LA18194-3 "Likely germline"
* LOINC#LA18195-0 "Likely somatic"
* LOINC#LA18196-8 "Likely fetal"
* LOINC#LA18197-6 "Unknown genomic origin"
* LOINC#LA26807-0 "De novo"

// 5) DNA Change Type ValueSet
ValueSet: DNAChangeTypeVS
Id: dna-change-type-vs
Title: "DNA Change Type Value Set"
Description: "LOINC LA codes enumerating various DNA change types."
* LOINC#LA9658-1 "Wild type"
* LOINC#LA6692-3 "Deletion"
* LOINC#LA6686-5 "Duplication"
* LOINC#LA6687-3 "Insertion"
* LOINC#LA6688-1 "Insertion/Deletion"
* LOINC#LA6689-9 "Inversion"
* LOINC#LA6690-7 "Substitution"

// 6) Clinical Significance ValueSet
ValueSet: ClinicalSignificanceVS
Id: clinical-significance-vs
Title: "Clinical Significance Value Set"
Description: "LOINC LA codes for the clinical significance of a variant."
* LOINC#LA6668-3 "Pathogenic"
* LOINC#LA26332-9 "Likely pathogenic"
* LOINC#LA26333-7 "Uncertain significance"
* LOINC#LA26334-5 "Likely benign"
* LOINC#LA6675-8 "Benign"
* LOINC#LA4489-6 "Unknown"

// 7) Level of Evidence ValueSet
ValueSet: LevelOfEvidenceVS
Id: level-of-evidence-vs
Title: "Level of Evidence Value Set"
Description: "LOINC LA codes describing evidence strength for a variant."
* LOINC#LA30200-2 "Very strong evidence pathogenic"
* LOINC#LA30201-0 "Strong evidence pathogenic"
* LOINC#LA30202-8 "Moderate evidence pathogenic"
* LOINC#LA30203-6 "Supporting evidence pathogenic"
* LOINC#LA30204-4 "Supporting evidence benign"
* LOINC#LA30205-1 "Strong evidence benign"
* LOINC#LA30206-9 "Stand-alone evidence pathogenic"