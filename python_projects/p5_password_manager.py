pwd = input("What is the master password? ")

def view():
    ...

def add():
    ...

while True:

    mode = input(
        "Would you like to add a new password or view existing ones (view, add), press Q to quit? "
        ).lower()
    if mode == "view":
        ...
    elif mode == "add":
        ...
    else:
        print("Invalid mode.")
        continue
