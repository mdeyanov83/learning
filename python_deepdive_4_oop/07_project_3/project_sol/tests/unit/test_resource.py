"""
Tests for Resource class
Command line: python -m pytest tests/unit/test_resource.py
"""


import pytest

from app.models import inventory

@pytest.fixture
def resource_values():
    return {
        'name': 'Parrot',
        'manufacturer': 'Pirates A-Hoy',
        'total': 100,
        'allocated': 50
    }

@pytest.fixture
def resource(resource_values):
    return inventory.Resource(**resource_values)


def test_create_resource(resource_values, resource):
    resource = inventory.Resource('Parrot', 'Pirates A-Hoy', 100, 50)
    assert resource.name == 'Parrot'
    assert resource.manufacturer == 'Pirates A-Hoy'
    assert resource.total == 100
    assert resource.allocated == 50


def test_create_invalid_total_type():
    with pytest.raises(TypeError):
        inventory.Resource('Parrot', 'Pirates A-Hoy', 10.5, 5)
