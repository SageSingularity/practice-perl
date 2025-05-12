#!/usr/bin/perl
use strict;
use warnings;
use lib qw(. db);
use crud::UserCRUD;

# Create database connection
my $db = UserCRUD->new(
    dsn      => 'dbi:Oracle:host=localhost;sid=XE',
    username => 'your_username',
    password => 'your_password'
);

# Connect to database
eval {
    $db->connect();
};
if ($@) {
    die "Failed to connect to database: $@\n";
}

# Example: Create a new user
my $user_id = $db->create_user(
    username => 'john_doe',
    email    => 'john@example.com'
);
print "Created user with ID: $user_id\n";

# Example: Read user
my $user = $db->get_user($user_id);
print "Retrieved user: " . $user->{username} . " (" . $user->{email} . ")\n";

# Example: Update user
$db->update_user($user_id,
    username => 'john_doe_updated',
    email    => 'john.updated@example.com'
);
print "Updated user\n";

# Example: List users
my $users = $db->list_users(10, 0);
print "\nListing users:\n";
foreach my $u (@$users) {
    print "User ID: $u->{user_id}, Username: $u->{username}, Email: $u->{email}\n";
}

# Example: Delete user
$db->delete_user($user_id);
print "\nDeleted user with ID: $user_id\n";

# Disconnect from database
$db->disconnect(); 