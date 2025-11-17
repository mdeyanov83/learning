name = input("Type your name: ")
print(f"Welcome {name} to this adventure!")


answer = input(
    "You are on a dirt road, it has come to an end and you can go left or right. Which way would youl like to go?: "
    ).lower()

if answer == "left":
    answer = input(
        "You come to a river, you can walk around it or swim across? Type walk to walk around or swim to swim around?: "
        ).lower()
    if answer == "swim":
        print("You swam across and were eaten by an alligator.")
    elif answer == "walk":
        print("You walked for many miles, ran out of water and you lost the game.")
    else:
        print("Not a valid option. You lose.")

elif answer == "right":
    print()
else:
    print("Not a valid option. You lose.")
