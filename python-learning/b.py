def exclusiveTime(n, logs):
    exclusive_times = [0] * n
    stack = []

    for log in logs:
        log_parts = log.split(":")
        function_id, event, timestamp = int(log_parts[0]), log_parts[1], int(log_parts[2])

        if event == "start":
            if stack:
                # If there's a function currently running, update its exclusive time
                running_function_id, start_time = stack[-1]
                exclusive_times[running_function_id] += timestamp - start_time

            # Add the new function to the stack
            stack.append((function_id, timestamp))

        else:  # event == "end"
            running_function_id, start_time = stack.pop()
            exclusive_times[running_function_id] += timestamp - start_time + 1

            # Adjust the start time for the next function on the stack
            if stack:
                stack[-1] = (stack[-1][0], timestamp + 1)

    return exclusive_times




n=int(input())