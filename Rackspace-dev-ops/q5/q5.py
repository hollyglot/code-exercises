from itertools import chain
from sys import argv

script, filename = argv
arr = [line.rstrip().split(' ') for line in open(filename)]

def peel_matrix_clockwise(arr):
    while arr:
        yield arr[0]
        arr = list(reversed(zip(*arr[1:])))

print ' '.join(list(chain(*peel_matrix_clockwise(arr))))