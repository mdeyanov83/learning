class Polygon:
    def __init__(self, n, r):
        self.n = n
        self.r = r

    def edges(self):
        return self.n

    def vertices(self):
        return self.n

    def in_angle(self):
        from math import pi
        return (self.n - 2) * 180 / pi

    def edge_len(self):
        from math import sin, pi
        return 2 * self.r * sin(pi / self.n)

    def apothem(self):
        from math import cos, pi
        return self.r * cos(pi / self.n)

    def area(self):
        return 1/2 * self.n * self.edge_len() * self.apothem()

    def perimeter(self):
        return self.n * self.edge_len()


def main():
    p = Polygon(3)

    print(p.edges())
    print(p.vertices())
    print(p.


if __name__ == "__main__":
    main()
