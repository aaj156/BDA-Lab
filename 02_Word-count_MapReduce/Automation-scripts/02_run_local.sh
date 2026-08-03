#!/bin/bash
echo "Running Local WordCount..."
cat input.txt | python3 mapper.py > mapper.out
sort mapper.out | python3 reducer.py > reducer.out
cat reducer.out
