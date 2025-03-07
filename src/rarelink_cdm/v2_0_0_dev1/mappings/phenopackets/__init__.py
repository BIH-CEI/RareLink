"""
RareLink-CDM v2.0.0.dev1 specific mapping to the Phenopacket schema Blocks

    
"""

from .mapping_dicts import mapping_dicts
from .label_dicts import label_dicts
from .individual import INDIVIDUAL_BLOCK
from .vitalstatus import VITAL_STATUS_BLOCK
from .genetics import (
    INTERPRETATION_BLOCK,
    VARIATION_DESCRIPTOR_BLOCK
)
from .phenotype import PHENOTYPIC_FEATURES_BLOCK
from .disease import DISEASE_BLOCK
from .measurements import MEASUREMENT_BLOCK
from .resources import RARELINK_CODE_SYSTEMS
from .ontology_paths import ONTOLOGY_PATHS




__all__ = [
    "mapping_dicts",
    "label_dicts",
    "INDIVIDUAL_BLOCK",
    "VITAL_STATUS_BLOCK",
    "INTERPRETATION_BLOCK",
    "PHENOTYPIC_FEATURES_BLOCK",
    "DISEASE_BLOCK",
    "MEASUREMENT_BLOCK",
    "RARELINK_CODE_SYSTEMS",
    "VARIATION_DESCRIPTOR_BLOCK",
    "ONTOLOGY_PATHS"
]