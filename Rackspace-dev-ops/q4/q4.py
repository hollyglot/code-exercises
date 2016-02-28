from itertools import groupby
from sys import argv

script, filename = argv
strg = open(filename).read()

def compact(strg):
    unique = (i[0] for i in groupby(strg) if not i[0].isspace())
    return ''.join(unique)

print compact(strg)