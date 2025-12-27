import multiprocessing
import time


def square(n):
    print(f"Process {n}: {n}^2 = {n*n}")
    time.sleep(1)  # simulate heavy work

def main():
    numbers = [1, 2, 3, 4, 5]

    # Single process
    print("Single process")
    for n in numbers:
        square(n)

    # Multiprocessing
    print("Multiprocessing")
    processes = []
    for n in numbers:
        p = multiprocessing.Process(target=square, args=(n,))
        processes.append(p)
        p.start()
    for p in processes:
        p.join()


if __name__ == "__main__":
    main()
