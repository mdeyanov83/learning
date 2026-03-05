from fastapi import APIRouter, Request, BackgroundTasks
from fastapi.templating import Jinja2Templates
from fastapi.responses import HTMLResponse
from schemas import ProductBase
from custom_log import log


router = APIRouter(
    prefix="/templates",
    tags=["templates"],
)

templates = Jinja2Templates(directory="templates")


# @router.get("/products/{id}", response_class=HTMLResponse)
# def get_product(id: str, request: Request):
#     return templates.TemplateResponse(
#         "product.html",
#         {
#             "request": request,
#             "id": id,
#         },
#     )


@router.post("/product/{id}", response_class=HTMLResponse)
def get_product(
    id: str,
    product: ProductBase,
    request: Request,
    bt: BackgroundTasks,
):
    # add the background task
    bt.add_task(log_template_call, f"Template read for product with id {id}")
    return templates.TemplateResponse(
        "product.html",
        {
            "request": request,
            "id": id,
            "title": product.title,
            "description": product.description,
            "price": product.price,
        },
    )


def log_template_call(message: str):
    log("MyAPI", message)
