#!/usr/bin/perl
use strict;
use warnings;

# Example Perl script demonstrating various features

# String manipulation
my $greeting = "Hello, World!";
print "$greeting\n";

# Array operations
my @fruits = ("apple", "banana", "orange");
print "Fruits: " . join(", ", @fruits) . "\n";

# Hash demonstration
my %person = (
    name    => "John Doe",
    age     => 30,
    city    => "New York"
);

print "Person details:\n";
foreach my $key (keys %person) {
    print "$key: $person{$key}\n";
}

# File handling example
my $filename = "output.txt";
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh "This is a test file created by Perl script.\n";
close $fh;

# Reading from a file
open(my $read_fh, '<', $filename) or die "Could not open file '$filename' $!";
while (my $line = <$read_fh>) {
    print "Read from file: $line";
}
close $read_fh;

# Subroutine example
sub calculate_sum {
    my ($num1, $num2) = @_;
    return $num1 + $num2;
}

my $result = calculate_sum(5, 3);
print "Sum of 5 and 3 is: $result\n";

# Error handling example
eval {
    die "This is a test error";
};
if ($@) {
    print "Caught error: $@\n";
}

print "\nScript completed successfully!\n";
