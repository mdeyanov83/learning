def log(tag="", message=""):
    with open("log.txt", "a+") as log:
        # log.write(f"{tag}: {message}")
        # use print to print on a new line
        print(f"{tag}: {message}", file=log)
