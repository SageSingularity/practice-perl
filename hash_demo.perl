#!/usr/bin/perl
use strict;
use warnings;

# Function to find most common value in a hash
sub find_most_common_value {
    my ($hash_ref) = @_;
    my %value_count;
    
    # Count occurrences of each value
    foreach my $value (values %$hash_ref) {
        $value_count{$value}++;
    }
    
    # Find the value with highest count
    my $max_count = 0;
    my $most_common;
    foreach my $value (keys %value_count) {
        if ($value_count{$value} > $max_count) {
            $max_count = $value_count{$value};
            $most_common = $value;
        }
    }
    
    return ($most_common, $max_count);
}

# Basic hash creation and access
print "1. Basic Hash Operations:\n";
my %employee = (
    name     => "John Doe",
    age      => 30,
    position => "Developer",
    skills   => ["Perl", "Python", "SQL"]
);

print "Name: $employee{name}\n";
print "Age: $employee{age}\n";
print "Position: $employee{position}\n";
print "Skills: @{$employee{skills}}\n\n";

# Hash operations
print "2. Hash Operations:\n";
# Adding new key-value pair
$employee{salary} = 75000;
print "Added salary: $employee{salary}\n";

# Checking if key exists
if (exists $employee{position}) {
    print "Position exists in hash\n";
}

# Deleting a key-value pair
delete $employee{age};
print "After deleting age, keys are: " . join(", ", keys %employee) . "\n\n";

# Nested hash demonstration
print "3. Nested Hash:\n";
my %company = (
    name => "Tech Corp",
    departments => {
        engineering => {
            manager => "Jane Smith",
            employees => 50,
            projects => ["Web", "Mobile", "Cloud"]
        },
        marketing => {
            manager => "Bob Wilson",
            employees => 20,
            projects => ["SEO", "Social Media"]
        }
    }
);

# Accessing nested hash values
print "Company: $company{name}\n";
print "Engineering Manager: $company{departments}{engineering}{manager}\n";
print "Marketing Employees: $company{departments}{marketing}{employees}\n";
print "Engineering Projects: @{$company{departments}{engineering}{projects}}\n\n";

# Hash functions demonstration
print "4. Hash Functions:\n";
my %fruits = (
    apple  => 5,
    banana => 3,
    orange => 4,
    grape  => 2
);

# Getting all keys
print "Keys: " . join(", ", sort keys %fruits) . "\n";

# Getting all values
print "Values: " . join(", ", sort values %fruits) . "\n";

# Getting key-value pairs
print "Key-Value pairs:\n";
while (my ($fruit, $count) = each %fruits) {
    print "$fruit: $count\n";
}

# Hash size
print "\nNumber of fruits: " . scalar keys %fruits . "\n\n";

# Hash merging demonstration
print "5. Hash Merging:\n";
my %inventory1 = (apple => 5, banana => 3);
my %inventory2 = (orange => 4, grape => 2);

# Merging hashes
my %combined_inventory = (%inventory1, %inventory2);
print "Combined inventory: " . join(", ", map { "$_=$combined_inventory{$_}" } sort keys %combined_inventory) . "\n\n";

# Hash of arrays demonstration
print "6. Hash of Arrays:\n";
my %students = (
    math => ["Alice", "Bob", "Charlie"],
    science => ["David", "Eve", "Frank"],
    history => ["Grace", "Henry", "Ivy"]
);

foreach my $subject (sort keys %students) {
    print "$subject students: @{$students{$subject}}\n";
}

# Hash slice demonstration
print "\n7. Hash Slice:\n";
my @keys_to_get = qw(apple banana);
my @values = @fruits{@keys_to_get};
print "Selected fruits: " . join(", ", @values) . "\n";

# Hash reference demonstration
print "\n8. Hash Reference:\n";
my $employee_ref = \%employee;
print "Name through reference: $employee_ref->{name}\n";
print "Position through reference: $employee_ref->{position}\n";

# Demonstrating the new function
print "\n9. Most Common Value Function:\n";
my %sample_data = (
    key1 => "apple",
    key2 => "banana",
    key3 => "apple",
    key4 => "cherry",
    key5 => "apple"
);

my ($most_common, $count) = find_most_common_value(\%sample_data);
print "Most common value: $most_common (appears $count times)\n"; 