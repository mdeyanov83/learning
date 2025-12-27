from math import sin, cos, pi

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
        return 2 * self._r * sin(pi / self._n)

    @property
    def apothem(self):
        return self._r * cos(pi / self._n)

    @property
    def area(self):
        return 1/2 * self._n * self.edge_len * self.apothem

    @property
    def perimeter(self):
        return self._n * self.edge_len

    def __repr__(self):
        return f'Polygon: Vertices={self.edges}, Radius={self._r}'

    def __eq__(self, other):
        if isinstance(other, Polygon):
            return self._n == other._n and self._r == other._r
        else:
            raise TypeError('Object must be of type Polygon')

    def __gt__(self, other):
        if isinstance(other, Polygon):
            return self._n > other._n
        else:
            raise TypeError('Object must be of type Polygon')



class Poly_Sequence:
    def __init__(self, n, r):
        self._n = n
        self._r = r

    @property
    def max_efficiency_poly(self):
        ...

    def __getitem__(self, x):
        ...

    def __len__(self, n):
        ...



def main():
    p = Polygon(3, 5)

    print(p.edges)
    print(p.vertices)
    print(p.in_angle)
    print(p.edge_len)
    print(p.apothem)
    print(p.area)
    print(p.perimeter)

    print(p)

    p2 = Polygon(5, 8)
    p3 = Polygon(3, 5)
    print(p == p3)
    print(p2 > p)


if __name__ == "__main__":
    main()
