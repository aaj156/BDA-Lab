# Part 2 – Python MapReduce Program Development

## 1. Create mapper.py

```python
#!/usr/bin/env python3
import sys

for line in sys.stdin:
    for word in line.strip().split():
        print(f"{word}\t1")
```

Make executable:

```bash
chmod +x mapper.py
```

---

## 2. Create reducer.py

```python
#!/usr/bin/env python3
import sys

current_word=None
current_count=0

for line in sys.stdin:
    word,count=line.strip().split("\t")
    count=int(count)

    if current_word==word:
        current_count+=count
    else:
        if current_word:
            print(f"{current_word}\t{current_count}")
        current_word=word
        current_count=count

if current_word:
    print(f"{current_word}\t{current_count}")
```

```bash
chmod +x reducer.py
```

---

## 3. Local Testing

Mapper:

```bash
cat input.txt | python3 mapper.py
```

Complete pipeline:

```bash
cat input.txt | python3 mapper.py | sort | python3 reducer.py
```

Expected:

```text
Big 1
Data 1
Hadoop 3
Hello 3
MapReduce 1
Python 2
```
