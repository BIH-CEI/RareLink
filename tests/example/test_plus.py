import pytest
import rarelink


@pytest.mark.parametrize("a, b, expected", [
    (1, 1, 2),
    (1, 2, 3),
    (2, 1, 3),
    (2, 2, 4),
    (-1, 1, 0),
    (1, -1, 0),
    (-1, -1, -2),
    (0, 0, 0),
    (0, 1, 1),
    (1, 0, 1),
    (0, -1, -1),
    (-1, 0, -1),
])
def test_minus(a, b, expected):
    assert rarelink.example.plus.plus(a, b) == expected