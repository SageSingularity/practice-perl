#!/usr/bin/perl

# YOU CAN RUN THIS SCRIPT WITH THE FOLLOWING COMMAND (LINUX):
# perl learn_perl_script.pl

# Always use strict and warnings when debugging
use strict; # This line tells Perl to use strict mode, which helps catch common errors.
use warnings; # This line tells Perl to use warnings, which helps catch potential issues.

# Types of Variables
# Scalars ($var) — single values (strings, numbers)
# Arrays (@arr) — ordered lists
# Hashes (%hash) — key-value pairs

# Control Structures: Control structures are used to control the flow of execution in a program.
# if, elsif, else: if, elsif, else is a control structure that allows you to execute different blocks of code based on the value of a variable.
# for, foreach: for, foreach is a control structure that allows you to execute a block of code a specific number of times.
# while, until: while, until is a control structure that allows you to execute a block of code repeatedly until a condition is met.

# Loops and Iteration: Loops and iteration are used to repeat a block of code a specific number of times or until a condition is met.
# unless: unless is a control structure that allows you to execute a block of code if a condition is not met.
# for, foreach: for, foreach is a control structure that allows you to execute a block of code a specific number of times.
# while, until: while, until is a control structure that allows you to execute a block of code repeatedly until a condition is met.

# Subroutines (Functions): Subroutines are used to group code together and reuse it.
# Defined with sub: subroutines are defined with the sub keyword.
# Parameters passed via @_: parameters are passed via the @_ array.
# Return values via return: return values are returned via the return keyword.

# File Handling: File handling is used to read and write to files.
# open(my $fh, '<', 'file.txt') or die $!; # This line opens a file for reading.
# while (my $line = <$fh>) { # This line reads each line in the file.
#     print $line; # This line prints each line in the file.
# }
# close($fh); # This line closes the file.

# Accessing Variables
my $scalar = "hello"; # This line defines a scalar variable.
my @array = (1, 2, 3); # This line defines an array variable.
my %hash  = (name => "Alice", age => 30); # This line defines a hash variable.

# my: Variables declared with 'my' are only accessible within the block where they are declared

print "this is a $scalar\n"; # This line prints a message to the console indicating that we're starting the first section of the script.

# Define an array
my @fruits = ('apple', 'banana', 'cherry', 'date'); # This line defines an array of fruits.

# Read each item using a foreach loop
foreach my $fruit (@fruits) { # This line reads each item in the array.
    print "Fruit: $fruit\n"; # This line prints each item in the array.
}

print "\n=== 2. Slicing arrays ===\n"; # This line prints a message to the console indicating that we're starting the second section of the script.

# Array slicing: Get specific elements by index
my @selected = @fruits[1, 3];  # banana and date

# Print the sliced array
print "Selected fruits: @selected\n"; # This line prints the sliced array.
# split(' '): [selected, fruits:, @selected]

print "\n=== 3. Slicing strings ===\n"; # This line prints a message to the console indicating that we're starting the third section of the script.

# Define a string
my $text = "Hello, Perl World!"; # This line defines a string.

# Get a substring (slice)
my $slice = substr($text, 7, 4);  # From index 7, take 4 characters
# slice = "Perl"

print "Substring slice: '$slice'\n";  # Output: 'Perl'

print "\n=== 4. Reading from a file ===\n"; # This line prints a message to the console indicating that we're starting the fourth section of the script.

# Define file name
my $file = 'example.txt'; # This line defines the file name.
# This script should be in the same directory as example.txt or specify the full path to the file.
# 'example.txt'
# 'C:\Users\user\Desktop\example.txt'
# '~/Documents/example.txt' (~ is shorthand for home directory)

# This defaults to printing to stdout
print "this shows up in the console";

# Print out to stderr
# logger.erro('This is an error message')''

# Create the file if it doesn't exist
unless (-e 'example.txt') { # -e is used to check if the file exists.
    # open('create a file handler', '>', 'file name')
    open(my $out, '+<', 'example.txt') or die "Can't create file: $!"; # Die is used to stop the script and print an error message.
    # What permissions does out have to work on this file?
    #  < : Open for reading only (default)
    # >> : Open for appending (adds to end of file)
    # +< : Open for both reading and writing
    # +> : Open for both reading and writing, but truncates the file first
    
    # Define an array of lines to write
    my @lines = ("First line", "Second line", "Third line", "Fourth line", "Fifth line");
    
    # Write each line using a for loop
    for my $line (@lines) {
        print $out "$line\n";
    }
    
    close($out); # This line closes the file.
    print "Created file 'example.txt'\n"; # This line prints a message to the console indicating that the file has been created.
}

# Open the file for reading
open(my $in, '<', $file) or die "Can't open file: $!"; # This line opens the file.

# Read each line and print it
while (my $line = readline($in)) { # This line reads each line in the file.
    chomp($line);  # Chomp is used to remove the newline character.
    print "Line: $line\n"; # This line prints each line to the console.
}

close($in); # This line closes the file.
