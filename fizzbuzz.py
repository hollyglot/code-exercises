
'''

  Write a program that prints the numbers from 1 to 100. 
  But for multiples of three print "Fizz" instead of the 
  number and for the multiples of five print "Buzz". 
  For numbers which are multiples of both three and 
  five print "FizzBuzz".
  
'''

for value in range(1,100):
    if value % 15 == 0:
        print "FizzBuzz"
    elif value % 3 == 0:
        print "Fizz"
    elif value % 5 == 0:
        print "Buzz"
    else:
        print value
