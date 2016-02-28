# String => String => Boolean
startsWith = lambda p: lambda s: s.startswith(p)

# String => Boolean
isDigit = lambda s: s.isdigit()

# String => Boolean
isAlpha = lambda s: s.isalpha()

# String => String => Boolean
gt = lambda a: lambda s: a < s

# String => String => Boolean
le = lambda a: lambda s: a >= s

counter = lambda current: {
   "inc": lambda x: counter(current + 1),
   "dec": lambda x: counter(current - 1),
   "show": lambda x: print_(current, counter(current))
}

def print_(x, y):
    print(x)
    return y 

counter

# (String => Boolean) => (String => Boolean) => String => Boolean
or_ = lambda a: lambda b: lambda c: a(c) or b(c)

assert(or_(isDigit)(startsWith("1"))("123") == True)
assert(or_(isAlpha)(startsWith("2"))("123") == False)
assert(or_(isAlpha)(le("2"))("123") == True)
assert(or_(isAlpha)(gt("2"))("123") == False)
 
# (String => Boolean) => (String => Boolean) => String => Boolean)
and_ = lambda a: lambda b: lambda c: a(c) and b(c)

assert(and_(isDigit)(startsWith("a"))("ab") == False)
assert(and_(isAlpha)(startsWith("a"))("ab") == True)
assert(and_(isDigit)(startsWith("b"))("ab") == False)
assert(and_(isAlpha)(startsWith("b"))("ab") == False)


assert(and_(isAlpha)(gt("ab")) ("abc") == True)

assert(and_(le("abc"))(isAlpha)("ab") == True)


class StringMatch(object):

    def match(s):
        raise "implement me!"

    def or_(self, m2):
        return OrMatch(self, m2)


class OrMatch(StringMatch):

    def __init__(self, m1, m2):
        self.m1 = m1
        self.m2 = m2

    def match(self, s):
        return self.m1.match(s) or self.m2.match(s)

class StartsWith(StringMatch):

    def __init__(self, prefix):
        self.prefix = prefix

    def match(self, s):
        return s.startswith(self.prefix)


assert(StartsWith("a").match("ab") == True)
assert(StartsWith("a").or_(StartsWith("b")).match("ab") == True)

assert(StartsWith("a").or_(StartsWith("b")).match("ba") == True)
assert(StartsWith("b").or_(StartsWith("a")).match("ab") == True)
assert(StartsWith("b").or_(StartsWith("a")).match("ba") == True)
assert(StartsWith("b").or_(StartsWith("a")).match("ca") == False)





















































# (String => Boolean) => String => Boolean
not_ = lambda a: lambda b: not a(b)

assert(not_(gt("233"))("23") == True)


print "SUCCESS: all tests pass"