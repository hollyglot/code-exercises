=begin
Create a module called MathHelpers with the exponent() method 
that takes two numbers as arguments and raises the first number 
to the power of the second number. 

Create a class called Calculator with a method called square_root() 
that takes the square root of the number (raises it to the power of 0.5). 
The square_root() method should use the exponent() method.
=end

module MathHelpers
  extend self  

  def exponent(num, pwr)
    # raises num to the power of pwr
    num ** pwr
  end

end


class Calculator

  def self.square_root(num)
    # raise to the power of 0.5
    MathHelpers.exponent(num, 0.5)
  end
end


