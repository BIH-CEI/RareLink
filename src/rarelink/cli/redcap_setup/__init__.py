from .download import app as downloads_app
from .redcap_api_setup import app as redcap_api_setup_app
from .redcap_project_setup import app as redcap_project_setup_app
from .upload_data_dictionary import app as upload_data_dictionary_app

import typer

app = typer.Typer()

# REDCap setup commands
app.add_typer(downloads_app, name="download")
app.add_typer(redcap_api_setup_app, name="redcap-api-setup")
app.add_typer(redcap_project_setup_app, name="redcap-project-setup")
app.add_typer(upload_data_dictionary_app, name="upload-data-dictionary")