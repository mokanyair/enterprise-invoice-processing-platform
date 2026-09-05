import pytest

from src.invoice_processor.processor import process_invoice


def test_process_invoice_uppercases_content():
    source = b"invoice id: inv-1001"
    expected = b"INVOICE ID: INV-1001"

    assert process_invoice(source) == expected


def test_process_invoice_empty_content():
    assert process_invoice(b"") == b""


def test_process_invoice_rejects_none():
    with pytest.raises(ValueError, match="Invoice content cannot be None"):
        process_invoice(None)
