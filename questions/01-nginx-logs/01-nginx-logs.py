from collections import Counter
import re

log_file = "access.log"
ip_counts = Counter()

def solve(log_file):
    with open(log_file, "r") as file:
        for line in file:
            # Extract IP and HTTP status code
            match = re.match(r'^(\S+).*?"\s+(\d{3})\s+', line)

            if not match:
                continue

            ip = match.group(1)
            status = int(match.group(2))

            # HTTP 5xx
            if 500 <= status <= 599:
                ip_counts[ip] += 1

    # Print top 5 IPs
    for ip, count in ip_counts.most_common(5):
        print(f"{ip:15} {count}")

solve(log_file)