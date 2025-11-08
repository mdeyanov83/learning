import multiprocessing
import time


def square(n):
    print(f"Process {n}: {n}^2 = {n*n}")
    time.sleep(1)  # simulate heavy work


if __name__ == "__main__":
    numbers = [1, 2, 3, 4]
    processes = []

    for n in numbers:
        p = multiprocessing.Process(target=square, args=(n,))
        processes.append(p)
        p.start()

    for p in processes:
        p.join()
