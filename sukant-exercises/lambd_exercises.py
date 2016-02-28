everything = lambda x: True
nothing = lambda x: False

contains = lambda elem: lambda set: set(elem)

assert(contains("hello")(everything) == True)
assert(contains("hello")(nothing) == False)

single = lambda elem: lambda e: e == elem

assert(contains(1)(single(1)) == True)
assert(contains(2)(single(1)) == False)


evens = lambda e: e % 2 == 0
odds = lambda e: e % 2 == 1

assert(contains(1)(evens) == False)
assert(contains(2)(evens) == True)
assert(contains(1)(odds) == True)
assert(contains(2)(odds) == False)

insert = lambda elem: lambda set: lambda e: e == elem or set(e)

assert(contains(1)(insert(1)(nothing)) == True)
assert(contains(1)(insert(2)(nothing)) == False)

union = lambda set1: lambda set2: TODO

testSet1 = insert(1)(single(2))
testSet2 = insert(3)(single(1))

testUnion = union(testSet1)(testSet2)
assert(contains(1)(testUnion) == True)
assert(contains(2)(testUnion) == True)
assert(contains(3)(testUnion) == True)
assert(contains(4)(testUnion) == False)

intersect = lambda set1: lambda set2: TODO
assert(contains(1)(testUnion) == True)
assert(contains(2)(testUnion) == False)
assert(contains(3)(testUnion) == False)
assert(contains(4)(testUnion) == False)

print("SUCCESS: all tests pass")