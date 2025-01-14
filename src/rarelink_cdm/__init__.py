"""
Functions for working with the Common Data Model (CDM) for the RARELINK project.

This package provides access to all available versions of the RareLink CDM, including schema definitions,
data processing utilities, and other tools for working with the Common Data Model.

Available Versions:
- v2_0_0_dev0: Development version of the RareLink CDM version 2.0.0.

Exports:
- RarelinkCDM (from v2_0_0_dev0)
"""

from .v2_0_0_dev0 import load_schema

__all__ = [
    "load_schema"
]

# Optionally, you can define a default version to simplify usage:
RarelinkCDM = "2.0.0.dev0"

__version__ = "2.0.0.dev0"
