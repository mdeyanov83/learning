from fastapi import FastAPI, File, UploadFile
import shutil
import pytesseract


app = FastAPI()


@app.post("/ocr")
def ocr(image: UploadFile = File(...)):
    filePath = "file_to_ocr"
    with open(filePath, "w+b") as file:
        shutil.copyfileobj(image.file, file)
    return pytesseract.image_to_string(filePath, lang="eng")
