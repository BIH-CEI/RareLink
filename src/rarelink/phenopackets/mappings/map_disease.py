import logging
from phenopackets import Disease, OntologyClass, TimeElement
from rarelink.utils.processor import DataProcessor
from google.protobuf.timestamp_pb2 import Timestamp

logger = logging.getLogger(__name__)

def map_diseases(
    data: dict, 
    processor: DataProcessor) -> list:
    """
    Maps disease data directly using a hardcoded approach 
    for extracting and processing.

    Args:
        data (dict): Input data from the RareLink-CDM schema (or similar).
        processor (DataProcessor): Handles all data processing logic.

    Returns:
        list: A list of Phenopacket Disease blocks.
    """
    instrument_name = processor.mapping_config.get("redcap_repeat_instrument")
    try:
        repeated_elements = data.get("repeated_elements", [])
        if not repeated_elements:
            logger.warning("No repeated elements found in the data.")
            return []

        # Filter relevant disease elements
        disease_elements = [
            element for element in repeated_elements
            if element.get("redcap_repeat_instrument") == instrument_name
        ]
        
        # Disease.term
        diseases = []
        for disease_element in disease_elements:
            disease_data = disease_element.get("disease")
            if not disease_data:
                logger.warning("No disease data found in "
                               "this element. Skipping.")
                continue

            term_id = (
                disease_data.get(processor.mapping_config["term_field_1"]) or
                disease_data.get(processor.mapping_config["term_field_2"]) or
                disease_data.get(processor.mapping_config["term_field_3"]) or
                disease_data.get(processor.mapping_config["term_field_4"]) or
                disease_data.get(processor.mapping_config["term_field_5"])
            )

            term_label = processor.fetch_label(term_id)
            term = OntologyClass(id=term_id, label=term_label)


            # Disease.onset[0..1] ( -> prefer date over category)
            onset_date = disease_data.get(
                processor.mapping_config["onset_date_field"])
            onset_category_field = disease_data.get(
                processor.mapping_config["onset_category_field"])
            onset = None

            if onset_date:
                try:
                    timestamp = processor.process_date(onset_date)
                    if isinstance(timestamp, Timestamp):
                        onset = TimeElement(timestamp=timestamp)
                    else:
                        raise TypeError(
                            "Processed date is not a Timestamp object.")
                except Exception as e:
                    logger.error(f"Error processing onset date: {e}")

            if not onset and onset_category_field:
                try:
                    onset_label = processor.fetch_label(
                        onset_category_field, enum_class="AgeAtOnset")
                    onset_category = processor.process_code(
                        onset_category_field)
                    
                    if onset_label:
                        onset = TimeElement(
                            ontology_class=OntologyClass(
                                id=onset_category, label=onset_label)
                        )
                    else:
                        logger.warning(
                            f"No label found for onset category \
                                '{onset_category}'.")
                except Exception as e:
                        logger.error(
                            f"Error processing onset category \
                                '{onset_category}': {e}")
                    
            # Disease.excluded
            excluded_value = disease_data.get(
                processor.mapping_config["excluded_field"])
            excluded = None
            if excluded_value:
                mapped_value = processor.fetch_mapping_value(
                    "map_disease_verification_status", excluded_value)
                logger.debug(f"Excluded value: {excluded_value},\
                                Mapped value: {mapped_value}")
                if mapped_value == "true":
                    excluded = True
                else:
                    excluded = None # default value in Phenopackets

            # Disease.primary_site
            primary_site_id = disease_data.get(
                processor.mapping_config["primary_site_field"])
            primary_site = None
            if primary_site_id:
                primary_site_label = processor.fetch_label(primary_site_id)
                primary_site = OntologyClass(
                    id=primary_site_id, 
                    label=primary_site_label)

            # Create the Disease block
            disease = Disease(
                term=term,
                onset=onset,
                excluded=excluded,
                primary_site=primary_site,
            )

            diseases.append(disease)

        return diseases

    except Exception as e:
        logger.error(f"Failed to map diseases: {e}")
        raise
