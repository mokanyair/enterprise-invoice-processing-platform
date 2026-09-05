import logging

import azure.functions as func

from processor import process_invoice


app = func.FunctionApp()


@app.function_name(name="invoice_processor")
@app.blob_trigger(
    arg_name="input_blob",
    path="raw/{name}",
    connection="InvoiceStorage"
)
@app.blob_output(
    arg_name="output_blob",
    path="processed/{name}",
    connection="InvoiceStorage"
)
def invoice_processor(
    input_blob: func.InputStream,
    output_blob: func.Out[bytes]
) -> None:
    logging.info(
        "Processing invoice blob: %s (%s bytes)",
        input_blob.name,
        input_blob.length,
    )

    source_content = input_blob.read()

    processed_content = process_invoice(source_content)

    output_blob.set(processed_content)

    logging.info(
        "Successfully processed invoice blob: %s",
        input_blob.name,
    )
