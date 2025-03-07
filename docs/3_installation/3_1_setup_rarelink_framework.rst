.. _3_1:

Set up the RareLink Framework
=============================

.. attention:: 
   RareLink v2.0.0.dev1 is under testing and development. Please :ref:`12` us 
   before using it to ensure you have the latest updates and guidance.


Getting Started
---------------

Follow these steps to set up the project locally and run tests.

1. Clone the repository:

.. code-block:: bash

      git clone https://github.com/BIH-CEI/rarelink.git
      cd rarelink

2. Create a virtual environment:

.. code-block:: bash

      python3 -m venv .venv
      source .venv/bin/activate  # On macOS/Linux
      .venv\Scripts\activate     # On Windows

3. Install dependencies:

.. code-block:: bash

      pip install .

4. Configure all api keys necessary to use rarelink by running the following
command:

.. code-block:: bash

    rarelink setup keys 

    This command will prompt you to enter the following keys:
    - BioPortal API key
    - REDCap API key
    - REDCap URL
    - REDCap project ID

.. note:: 
    You can create your free BioPortal account here: `BioPortal <https://bioportal.bioontology.org/>`_

5. Run tests:
   Use `pytest` to run the test suite.
   
.. code-block:: bash

      pytest

_____________________________________________________________________________________

RareLink Framework CLI config
------------------------------------

Use the following commands to update the framework and its components, view 
its status or reset the framework. See :ref:`2_3` for more information.

.. code-block:: bash

    rarelink framework --help
    rarelink framework update
    rarelink framework status
    rarelink framework reset

_____________________________________________________________________________________


Import Mapper Configuration
___________________________

Via the RareLink CLI type:

.. code-block:: bash

    to be implemented

This command guides you through setting up the Import Mapper pipeline for RareLink.
You will be prompted to enter:
- Your location of your local (tabular) database.
- Your REDCap project URL and API token.
- Your location where to store the Import Mapper configurations.

_____________________________________________________________________________________

Phenopacket Pipeline Configuration
___________________________________

Via the RareLink CLI type:

.. code-block:: bash

    to be implemented

This command guides you through setting up the Phenopacket pipeline for RareLink.
You will be prompted to enter:
- Your location where to store the Phenopackets.

_____________________________________________________________________________________

FHIR Pipeline Configuration
___________________________

.. code-block:: bash

    rarelink fhir setup

This command guides you through setting up the FHIR pipeline for RareLink. 
You will be prompted to enter:

- Your FHIR server URL.
- If required, your FHIR server username & password.

.. note:: 
    All sensitive information will also be stored in the 
    hidden configuration file.

