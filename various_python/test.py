# Union Find datastructure(Disjoint Set Union)
# Union by rank(tree depth) + Path Compression

from typing import List

class DSU:
    def __init__(self, size):
        self.parent = [i for i in range(size)]
        self.rank = [0] * size

    def find(self, x):
        if self.parent[x] != x:
            self.parent[x] = self.find(self.parent[x])
        return self.parent[x]

    def union(self, x, y):
        root_x = self.find(x)
        root_y = self.find(y)

        if root_x == root_y:
            return

        if self.rank[root_x] < self.rank[root_y]:
            self.parent[root_x] = root_y
        elif self.rank[root_x] > self.rank[root_y]:
            self.parent[root_y] = root_x
        else:
            self.parent[root_y] = root_x
            self.rank[root_x] += 1

class Solution:
    def processQueries(self, c: int, connections: List[List[int]], queries: List[List[int]]) -> List[int]:
        dsu = DSU(c + 1)
        for p in connections:
            dsu.union(p[0], p[1])

        online = [True] * (c + 1)
        offline_counts = [0] * (c + 1)
        minimum_online_stations = {}

        # Queries will be processed in reverse order. From this perspective, an offline operation
        # becomes an online operation. As each power plant comes back online, maitaining the minimum
        # identifier among all online power plants simply requires repeatedly taking the min and updating it

        #  Pre-process the final stage of each power plant
        for q in queries:
            operation, x = q[0], q[1]
            if operation == 2:
                online[x] = False
                offline_counts[x] +=1

        for i in range(1, c + 1):
            root = dsu.find(i)
            if root not in minimum_online_stations:
                minimum_online_stations[root] = -1

            station = minimum_online_stations[root]
            if online[i]:
                if station == -1 or station > i:
                    minimum_online_stations[root] = i

        ans = []

        for q in reversed(queries):
            operation, x = q[0], q[1]
            root = dsu.find(x)
            station = minimum_online_stations[root]

            if operation == 1:
                if online[x]:
                    ans.append(x)
                else:
                    ans.append(station)

            if operation == 2:
                if offline_counts[x] > 1:
                    offline_counts[x] -= 1
                else:
                    online[x] = True
                    if station == -1 or station > x:
                        minimum_online_stations[root] = x

        return ans[::-1]


def main():
    sol = Solution()




if __name__ == "__main__":
    main()
