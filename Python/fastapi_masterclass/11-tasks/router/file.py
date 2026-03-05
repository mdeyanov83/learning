from fastapi import APIRouter, File, UploadFile
from fastapi.responses import FileResponse
import shutil

router = APIRouter(
    prefix="/file",
    tags=["file"],
)


@router.post("/file")
def get_file(file: bytes = File(...)):
    # assume that file is text based
    content = file.decode("utf-8")
    lines = content.split("\n")
    return {"lines": lines}


@router.post("/uploadfile")
def get_uploadfile(upload_file: UploadFile = File(...)):

    # to store the file locally,
    # interpolate its path/fileneme for the local file first
    path = f"files/{upload_file.filename}"

    # write the to a local file using a context manager
    with open(path, 'w+b') as buffer:
        shutil.copyfileobj(upload_file.file, buffer)

    return {
        "filename": path,
        "type": upload_file.content_type
    }


@router.get("/download/{name}", response_class=FileResponse)
def download_file(name: str):
    # we can have any logic we want here

    path = f"files/{name}"
    return path
