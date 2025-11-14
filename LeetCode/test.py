class Fn:
    def __init__(id):
        self.id = id
        self.running_time = 0
        self.state = None
        self.started_time = None

    def start(timestamp):
        self.state = "running"
        self.started_time = timestamp

    def end(timestamp):
        self.state = "ended"
        self.running_time += timestamp - self.started_time + 1

    def pause(timestamp):
        self.state = "idle"
        self.running_time += timestamp - self.started_time + 1

    def cont(timestamp):
        self.state = "running"
        self.started_time = timestamp


class Func:
    def __init__(init):
        self.funcs = []
        for i in range(n):
            self.funcs[i] = Fn(i)





class Solution:
    def exclusiveTime(self, n: int, logs: List[str]) -> List[int]:

        def parse_log(log):
            parts = log.split(':')
            id = int(parts[0])
            timestamp = int(parts[2])
            action = parts[1]
            return id, action, timestamp

        times = [0] * n
        stack = []

        # Handle first log (every consecutive log/operation will have a previous operation to pause)
        # Avoid trying to pause previous function if there isn't one
        id, action, timestamp = parse_log(logs[0])
        stack.append([id, start, timestamp])

        for log in logs[1:]:
            id, action, timestamp = parse_log(log)

            if action == "start":
                stack.append([stack[-1]])
                stack[-1][3] = timestamp
                stack.append([id, start, timestamp, None])

            else:
                _, _, start_timestamp, paused = stack.pop()
                times[id] += timestamp - start_timestamp + 1
            print(stack)



        return times

