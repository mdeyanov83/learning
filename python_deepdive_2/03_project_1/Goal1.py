class Polygon:
    def __init__(self, n, r):
        self._n = n
        self._r = r

    @property
    def edges(self):
        return self._n

    @property
    def vertices(self):
        return self._n

    @property
    def in_angle(self):
        return (self._n - 2) * 180 / self._n

    @property
    def edge_len(self):
        from math import sin, pi
        return 2 * self._r * sin(pi / self._n)

    @property
    def apothem(self):
        from math import cos, pi
        return self._r * cos(pi / self._n)

    @property
    def area(self):
        return 1/2 * self._n * self.edge_len * self.apothem

    @property
    def perimeter(self):
        return self._n * self.edge_len


def main():
    p = Polygon(3, 5)

    print(p.edges)
    print(p.vertices)
    print(p.in_angle)
    print(p.edge_len)
    print(p.apothem)
    print(p.area)
    print(p.perimeter)



if __name__ == "__main__":
    main()
