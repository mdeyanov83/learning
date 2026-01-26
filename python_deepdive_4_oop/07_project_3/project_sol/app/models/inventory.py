"""Inventory models"""


from app.utils.validators import validate_integer

class Resource:
    """Base class for resources"""

    def __init__(self, name, manufacturer, total, allocated):
        """_summary_

        Args:
            name (str): display name of recources
            manufacturer (str): 
            total (int): _description_
            allocated (int): _description_
        """
