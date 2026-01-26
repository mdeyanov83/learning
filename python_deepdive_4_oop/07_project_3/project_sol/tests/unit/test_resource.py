"""
Tests for Resource class
Command line: python -m pytest tests/unit/test_resource.py
"""


import pytest

from app.models import inventory

def test_create_resource():
    resource = inventory.Resource('Parrot', 'Pirates A-Hoy', 100, 50)
    assert resource.name == 'Parrot'
    assert resource.manufacturer == 'Pirates A-Hoy'
    assert resource.total == 100
    assert resource.allocated == 50


def test_create_invalid_total_type():
    with pytest.raises(TypeError):
        inventory.Resource('Parrot', 'Pirates A-Hoy', 10.5, 5)
