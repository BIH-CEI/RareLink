from phenopackets import Phenopacket
from rarelink.utils.processor import DataProcessor
from rarelink.phenopackets.mappings import (
    map_individual,
    map_vital_status,
    map_metadata,
    map_diseases,
    map_interpretations,
    map_variation_descriptor,
    map_phenotypic_features,
    map_measurements
)
from rarelink_cdm.v2_0_0_dev1.mappings.phenopackets import (
    INDIVIDUAL_BLOCK,
    VITAL_STATUS_BLOCK,
    DISEASE_BLOCK,
    INTERPRETATION_BLOCK,
    VARIATION_DESCRIPTOR_BLOCK,
    RARELINK_CODE_SYSTEMS,
    PHENOTYPIC_FEATURES_BLOCK,
    MEASUREMENT_BLOCK
)
import logging

logger = logging.getLogger(__name__)

def create_phenopacket(data: dict, created_by: str) -> Phenopacket:
    """
    Creates a Phenopacket for an individual record.

    Args:
        data (dict): Input dictionary containing all data.
        created_by (str): Creator's name for metadata.

    Returns:
        Phenopacket: A fully constructed Phenopacket.
    """
    try:
        

        # Individual ---------------------------------------------------------------
        # First, create an individual processor to extract the date of birth
        individual_processor = DataProcessor(mapping_config=INDIVIDUAL_BLOCK)
        dob_field = individual_processor.get_field(data, "date_of_birth_field")
        dob_str = dob_field

        # VitalStatusBlock
        vital_status_processor = DataProcessor(mapping_config=VITAL_STATUS_BLOCK)
        vital_status = map_vital_status(
            data, 
            vital_status_processor, 
            dob=dob_str)

        # IndividualBlock
        individual = map_individual(
            data, 
            individual_processor, 
            vital_status=vital_status)

        
        # PhenotypicFeature -------------------------------------------------------
        phenotypic_feature_processor = DataProcessor(
            mapping_config=PHENOTYPIC_FEATURES_BLOCK
        )
        phenotypic_features = map_phenotypic_features(
            data,
            phenotypic_feature_processor,
            dob = individual.date_of_birth
        )
        
        # Measurements ------------------------------------------------------------
        measurement_processor = DataProcessor(
            mapping_config=MEASUREMENT_BLOCK
        )
        measurements = map_measurements(
            data, 
            measurement_processor, 
            dob=individual.date_of_birth
        )  

        # Disease -----------------------------------------------------------------
        # DiseaseBlock
        disease_processor = DataProcessor(mapping_config=DISEASE_BLOCK)
        diseases = map_diseases(data, 
                                disease_processor,
                                dob = individual.date_of_birth)
        
        # Genetics ----------------------------------------------------------------
        ## Variation Descriptor
        variation_descriptor_processor = DataProcessor(
            mapping_config=VARIATION_DESCRIPTOR_BLOCK
        )
        variation_descriptor = map_variation_descriptor(
            data,
            variation_descriptor_processor
        )
        
        ## Interpretation (handles genomic interpretations internally)
        interpretation_processor = DataProcessor(
            mapping_config=INTERPRETATION_BLOCK
        )
        interpretations = map_interpretations(
            data,
            interpretation_processor,
            subject_id=individual.id,
            variation_descriptor=variation_descriptor
        )
        
        # Metadata ---------------------------------------------------------------  
        metadata = map_metadata(
            created_by=created_by,
            code_systems=RARELINK_CODE_SYSTEMS
        )

        # Construct Phenopacket --------------------------------------------------
        return Phenopacket(
            id=data["record_id"],
            subject=individual,
            phenotypic_features=phenotypic_features,
            measurements=measurements,
            diseases=diseases,
            meta_data=metadata,
            interpretations=interpretations
            
        )
     
    except Exception as e:
        logger.error(f"Error creating Phenopacket: {e}")
        raise
