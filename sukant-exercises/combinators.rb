require 'test/unit'
extend Test::Unit::Assertions

class StringMatches

  def matches(s)
    raise "implement me!"
  end

  def or_(m2)
    OrMatches.new(self, m2)
  end
end


class OrMatches < StringMatches
  attr_reader :m1, :m2

                # parameter list
  def initialize(m1, m2)
    @m1 = m1
    @m2 = m2
  end

  def matches(s)
    m1.matches(s) || m2.matches(s)
  end
end

class StartsWith < StringMatches
  attr_reader :prefix

  def initialize(prefix)
    @prefix = prefix
  end

  def matches(s)
    s.start_with? prefix
  end
end

assert(StartsWith.new("a").matches("ab") == true)
assert(StartsWith.new("a").or_(StartsWith.new("b")).matches("ab") == true)

assert(StartsWith.new("a").or_(StartsWith.new("b")).matches("ba") == true)
assert(StartsWith.new("b").or_(StartsWith.new("a")).matches("ab") == true)
assert(StartsWith.new("b").or_(StartsWith.new("a")).matches("ba") == true)
assert(StartsWith.new("b").or_(StartsWith.new("a")).matches("ca") == false)





# assert(or_(isDigit)(startsWith("1"))("123") == true)
# assert(or_(isAlpha)(startsWith("2"))("123") == false)
# assert(or_(isAlpha)(le("2"))("123") == true)
# assert(or_(isAlpha)(gt("2"))("123") == false)






print "SUCCESS: all tests pass\n"