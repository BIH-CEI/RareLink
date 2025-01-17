INTERPRETATION_BLOCK = {
    "redcap_repeat_instrument": "rarelink_6_1_genetic_findings",
    "id_field": "snomed_422549004",
    "progress_status_field": "ga4gh_progress_status",
    "summary_field": "loinc_lp7824_8",
}
DIAGNOSIS_BLOCK = {
    "diagnosis_field_1": "snomed_106221001_mondo",
    "diagnosis_field_2": "snomed_106221001_omim_p",
}
GENOMIC_INTERPRETATIONS_BLOCK = {
    "subject_or_biosample_id_field": "snomed_422549004",
    "interpretation_status_field": "ga4gh_interpretation"
}
VARIANT_INTERPRETATION_BLOCK = {
    "reference_genome_field": "loinc_62374_4",
    "acmg_pathogenicity_classification_field": "loinc_53037_8",
    "therapeutic_actionability" : "ga4gh_therap_action"  
}
GENE_DESCRIPTOR_BLOCK = {
    "value_id_field": "loinc_48018_6",
}
VARIATION_DESCRIPTOR_BLOCK = {
    "id_field": "snomed_422549004",
    "expression_field_1": "loinc_81290_9",
    "expression_field_2": "loinc_48004_6",
    "expression_field_3": "loinc_48005_3",
    "allelic_state_field_1": "loinc_53034_5",
    "allelic_state_field_2": "loinc_53034_5_other"
}
