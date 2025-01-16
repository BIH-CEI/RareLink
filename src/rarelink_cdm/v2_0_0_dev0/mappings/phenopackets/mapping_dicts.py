"""
These are specific mappings from the Rarelink CDM v2.0.0 to the Phenopackets 
schema where specific codes are required. These mappings are used to convert
the codes in the CDM to the required codes in the Phenopackets schema.
"""

mapping_dicts = [
    {
        "name": "map_sex",
        "mapping": {
            "snomed_248152002": "FEMALE",
            "snomed_248153007": "MALE",
            "snomed_184115007": "UNKNOWN_SEX",
            "snomed_32570691000036108": "OTHER_SEX",
            "snomed_1220561009": "UNKNOWN_SEX"
        },
    },
    {
        "name": "map_karyotypic_sex",
        "mapping": {
            "snomed_261665006": "UNKNOWN_KARYOTYPE",
            "snomed_734875008": "XX",
            "snomed_734876009": "XY",
            "snomed_80427008": "XO",
            "snomed_65162001": "XXY",
            "snomed_35111009": "XXX",
            "snomed_403760006": "XXYY",
            "snomed_78317008": "XXXY",
            "snomed_10567003": "XXXX",
            "snomed_48930007": "XYY",
            "snomed_74964007": "OTHER_KARYOTYPE"
        },
    },
    {
        "name": "map_vital_status",
        "mapping": {
            "snomed_438949009": "ALIVE",
            "snomed_419099009": "DECEASED",
            "snomed_399307001": "UNKNOWN_STATUS",
            "snomed_185924006": "UNKNOWN_STATUS",
            "snomed_261665006": "UNKNOWN_STATUS"
        },
    },
    {
        "name": "map_disease_verification_status",
        "mapping": {
            "hl7fhir_unconfirmed": "false",
            "hl7fhir_provisional": "false",
            "hl7fhir_differential": "false",
            "hl7fhir_confirmed": "false",
            "hl7fhir_refuted": "true",
            "hl7fhir_entered-in-error": "false"
        },
    },
    {
        "name": "map_acmg_classification",
        "mapping": {
            "loinc_la6668_3": "PATHOGENIC",
            "loinc_la26332_9": "LIKELY_PATHOGENIC",
            "loinc_la26333_7": "UNCERTAIN_SIGNIFICANCE",
            "loinc_la26334_5": "LIKELY_BENIGN",
            "loinc_la6675_8": "BENIGN",
            "loinc_la4489_6": "NOT_PROVIDED"
        }
    },
    {
        "name": "phenotypic_feature_status",
        "mapping": {
            "snomed_410605003" : "false",
            "snomed_723511001" : "true"
        }
    }
]

# Utility function to fetch a mapping by name
def get_mapping_by_name(name):
    for mapping_dict in mapping_dicts:
        if mapping_dict["name"] == name:
            return mapping_dict["mapping"]
    raise KeyError(f"No mapping found for name: {name}")

