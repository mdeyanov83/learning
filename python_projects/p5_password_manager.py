master_pwd = input("What is the master password? ")

def view():
    ...

def add():
    name = input("Account Name: ")
    pwd = input("password: ")

    with open('password.txt', 'a') as f:
        f.write(f"{name}|{pwd}")


while True:

    mode = input(
        "Would you like to add a new password or view existing ones (view, add), press Q to quit? "
        ).lower()
    if mode == "view":
        view()
    elif mode == "add":
        add()
    else:
        print("Invalid mode.")
        continue
