import logging
import os
from urllib.parse import unquote, urlparse

import azure.functions as func
from azure.storage.blob import BlobServiceClient

from processor import process_invoice


app = func.FunctionApp()


@app.function_name(name="invoice_processor")
@app.event_grid_trigger(arg_name="event")
def invoice_processor(event: func.EventGridEvent) -> None:
    """
    Process BlobCreated events delivered by Azure Event Grid.

    Event Grid is filtered by Terraform so that only blobs created
    under the raw container are delivered to this function.
    """

    event_data = event.get_json()

    blob_url = event_data.get("url")

    if not blob_url:
        raise ValueError("Event Grid event does not contain a blob URL.")

    parsed_url = urlparse(blob_url)
    path = unquote(parsed_url.path).lstrip("/")

    path_parts = path.split("/", 1)

    if len(path_parts) != 2:
        raise ValueError(f"Unable to determine blob path from URL: {blob_url}")

    source_container = path_parts[0]
    blob_name = path_parts[1]

    expected_source_container = os.getenv("RAW_CONTAINER", "raw")
    processed_container = os.getenv("PROCESSED_CONTAINER", "processed")

    if source_container != expected_source_container:
        logging.warning(
            "Ignoring blob from unexpected container '%s'. Expected '%s'.",
            source_container,
            expected_source_container,
        )
        return

    storage_connection_string = os.environ["InvoiceStorage"]

    blob_service_client = BlobServiceClient.from_connection_string(
        storage_connection_string
    )

    source_blob = blob_service_client.get_blob_client(
        container=source_container,
        blob=blob_name,
    )

    destination_blob = blob_service_client.get_blob_client(
        container=processed_container,
        blob=blob_name,
    )

    logging.info(
        "Processing invoice blob '%s' from container '%s'.",
        blob_name,
        source_container,
    )

    source_content = source_blob.download_blob().readall()

    processed_content = process_invoice(source_content)

    destination_blob.upload_blob(
        processed_content,
        overwrite=True,
    )

    logging.info(
        "Successfully processed invoice '%s' into container '%s'.",
        blob_name,
        processed_container,
    )
