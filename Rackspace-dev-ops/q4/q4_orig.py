import itertools
from sys import argv

script, filename = argv

strg = open(filename).read().rstrip()

def compact(strg):
    p = ""
    result = ""
    for s in strg:
        if not s.isspace() and s is not p:
            result += s
        p = s
    return result

print compact(strg)