from fastapi import APIRouter, Request, Depends
from custom_log import log


router = APIRouter(
    prefix="/dependencies",
    tags=["dependencies"],
    dependencies=[Depends(log)],
)

# These are mock functions and endpoints just to demonstrate as an example
# how to add additional functionality as a sepcific parameter to where we need it
# They don't actually do anything, than return the parameters they have access to


def convert_params(
    request: Request,
    separator: str = "--",
):
    query = []
    for key, value in request.query_params.items():
        query.append(f"{key} {separator} {value}")
    return query


def convert_headers(
    request: Request,
    separator: str = "--",
    query=Depends(convert_params),  # multi-level dependency
):
    out_headers = []
    for key, value in request.headers.items():
        out_headers.append(f"{key} {separator} {value}")
    return {
        "headers": out_headers,
        "query": query,
    }


@router.get("")
def get_items(
    test_query_param: str,
    separator: str = "--",
    headers_and_queries=Depends(convert_headers),
):
    return {
        "separator": separator,
        "items": ["a", "b", "c"],
        "headers": headers_and_queries,
    }


@router.post("/new")
def create_item(headers_and_queries=Depends(convert_headers)):
    return {
        "result": "new item created",
        "headers": headers_and_queries,
    }


class Account:
    def __init__(self, name: str, email: str):
        self.name = name
        self.email = email


@router.post("/user")
def create_user(
    name: str,
    email: str,
    password: str,
    # account: Account = Depends(Account),
    account: Account = Depends(),  # shorthand syntax, Depends() automaticaly receives the type of the parameter
):
    # account - performs whatever operations we want

    # The account will be automaticaly created with the defined parameters
    # we can pass the password as well and inside the class
    # validate it in some way, open the db and create the user

    # here we will have access to the created class instance:
    return {
        "name": account.name,
        "email": account.email,
    }
