from fastapi import APIRouter, Header, Cookie, Form
from fastapi.responses import Response, HTMLResponse, PlainTextResponse
from typing import Optional, List
from custom_log import log

router = APIRouter(
    prefix="/product",
    tags=["product"],
)

# Dummy data for demostration
products = ["watch", "camera", "phone"]


@router.post("/new")
def create_product(name: str = Form(...)):
    products.append(name)
    return products


@router.get("/all")
def get_all_products():

    log("MyAPI", "Call to get all products")
    # return products

    # return the data not as json but as plain text
    data = " ".join(products)  # the conversion to the type of data we want to return
    response = Response(content=data, media_type="text/plain")
    response.set_cookie(
        key="test_cookie", value="teset_cookie_value"
    )  # set the cookie in the response object
    return response  # return the custom response object


@router.get("/withheader")
def get_products(
    response: Response,
    custom_header: Optional[List[str]] = Header(None),
    test_cookie: Optional[str] = Cookie(None),
):
    if custom_header:
        response.headers["custom_response_header"] = ", ".join(custom_header)
    return {"data": products, "custom_header": custom_header, "my_cookie": test_cookie}


@router.get(
    "/{id}",
    responses={
        200: {
            "content": {"text/html": {"example": "<div>Product</div>"}},
            "description": "Returns the HTML for an object",
        },
        404: {
            "content": {"text/plain": {"Product not found"}},
            "description": "A cleartext error message",
        },
    },
)
def get_product(id: int):
    if id > len(products):
        out = "Produt not available"
        return PlainTextResponse(status_code=404, content=out, media_type="text/plain")
    else:
        product = products[id]
        out = f"""
        <head>
            <style>
            .product {{
                width: 500px;
                height: 30px;
                border: 2px inset green;
                background-color: lightblue;
                text-align: center;
            }}
            </style>
        </head>
        <div class="product">{product}</div>
        """
        return HTMLResponse(content=out, media_type="text/html")
