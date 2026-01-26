"""
Tests the validator functions
Command line: python -m pytest tests/unit/test_validators.py
"""

import pytest

from app.utils.validators import validate_integer

class TestIntegerValidator:
    def test_valid(self):
        validate_integer('arg', 10, 0, 20, 'custom min msg', 'custom max msg')

    def test_type_error(self):
        with pytest.raises(TypeError):
            validate_integer('arg', 1.5)
