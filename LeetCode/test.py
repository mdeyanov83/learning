from typing import List

class Fn:
    def __init__(self, id):
        self.id = id
        self.running_time = 0
        self.state = None
        self.started_time = None

    def start(self, timestamp):
        self.state = "running"
        self.started_time = timestamp

    def end(self, timestamp):
        self.state = "ended"
        self.running_time += timestamp - self.started_time + 1
        self.started_time = None

    def pause(self, timestamp):
        self.state = "idle"
        self.running_time += timestamp - self.started_time
        self.started_time = None

    def cont(self, timestamp):
        self.state = "running"
        self.started_time = timestamp + 1


class Func:
    def __init__(self, n):
        self.funcs = []
        for i in range(n):
            self.funcs.append(Fn(i))
        self.running_stack = []

    def times(self):
        return [f.running_time for f in self.funcs]

    def print_all(self):
        for fn in self.funcs:
            print(fn.id, fn.state, fn.running_time)

    def execute(self, id, action, timestamp):
        if action == "start":
            if self.running_stack:
                self.funcs[self.running_stack[-1]].pause(timestamp)
            self.funcs[id].start(timestamp)
            self.running_stack.append(id)

        if action == "end":
            self.funcs[id].end(timestamp)
            self.running_stack.pop()
            if self.running_stack:
                self.funcs[self.running_stack[-1]].cont(timestamp)



class Solution:
    def exclusiveTime(self, n: int, logs: List[str]) -> List[int]:

        def parse_log(log):
            parts = log.split(':')
            id = int(parts[0])
            timestamp = int(parts[2])
            action = parts[1]
            return id, action, timestamp

        program = Func(n)


        for log in logs:
            id, action, timestamp = parse_log(log)
            program.execute(id, action, timestamp)

        program.print_all()

        return program.times()


def main():
    sol = Solution()
    n = 2
    logs = ["0:start:0","1:start:2","1:end:5","0:end:6"]

    print(sol.exclusiveTime(n, logs))



if __name__ == "__main__":
    main()
