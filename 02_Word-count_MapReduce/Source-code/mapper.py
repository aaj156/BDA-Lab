#!/usr/bin/env python3
import sys

for line in sys.stdin:
    line = line.strip()
    for word in line.split():
        print(f"{word}\t1")
