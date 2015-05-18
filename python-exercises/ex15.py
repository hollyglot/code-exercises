# import sys module. import argv argument
from sys import argv

# Unpack argv argument into 2 variables
script, filename = argv

# open filename and assign the file to the txt variable
txt = open(filename)

# print to terminat the following string with the filename
print "Here's your file %r:" % filename

# Run the read method on the file and print the results of read to the terminal.
print txt.read()

# print these instructions to the terminal
print "Type the filename again:"

# receive input from the user, i.e. the filename
file_again = raw_input("> ")

# open the file and assign it to a variable: txt_again
txt_again = open(file_again)

# Run the read method on the file and print the results of read to the terminal.
print txt_again.read()