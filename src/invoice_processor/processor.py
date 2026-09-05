def process_invoice(content: bytes) -> bytes:
    """
    Apply the cloud-neutral invoice transformation.

    The current AWS MVP transforms invoice content to uppercase.
    """
    if content is None:
        raise ValueError("Invoice content cannot be None.")

    return content.upper()
