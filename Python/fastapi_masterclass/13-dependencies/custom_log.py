from fastapi import Request

# Now log can be used as a generic logger, as well as take the request
def log(tag="MyApp", message="no message", request: Request = None):
    with open("log.txt", "a+") as log:
        # log.write(f"{tag}: {message}")
        # use print to print on a new line
        print(f"{tag}: {message}", file=log)
        if request is not None:
            print(f"\t{request.url}", file=log)
