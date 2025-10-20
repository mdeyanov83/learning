def testIterator():
    for i in range(10):
        yield i


def main():
    t = testIterator()
    print(t)

    for i in testIterator():
        print(i)



if __name__ == "__main__":
    main()

def test():
    a = int(10)
