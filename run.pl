#!/usr/bin/perl
use strict;
use warnings;
use lib qw(. db);
use OracleDB;
use JSON;

# This is the main script that runs the Project/Demo

# Create database connection
my $db_host = $ENV{DB_HOST} || 'host.docker.internal';
my $db_port = $ENV{DB_PORT} || '1521';
my $db_sid = $ENV{DB_SID} || 'XE';
my $db_user = $ENV{DB_USER} || 'SYSTEM';
my $db_password = $ENV{DB_PASSWORD} || 'myCurrentPassword$523';

# Print connection details for debugging
print "\nDatabase Connection Details:\n";
print "==========================\n";
print "Host: $db_host\n";
print "Port: $db_port\n";
print "SID: $db_sid\n";
print "User: $db_user\n";
print "==========================\n\n";

my $db = OracleDB->new(
    dsn      => "dbi:Oracle:host=$db_host;sid=$db_sid;port=$db_port",
    username => $db_user,
    password => $db_password
);

# Connect to database
eval {
    $db->connect();
};
if ($@) {
    die "Failed to connect to database: $@\n";
}

# Query to get list of tables you added, excluding system tables
my $query = "SELECT table_name FROM user_tables 
             WHERE table_name NOT LIKE 'BIN\$%' 
             AND table_name NOT LIKE 'DR\$%'
             AND table_name NOT LIKE 'MVIEW\$%'
             AND table_name NOT LIKE 'SYS_%'
             AND table_name NOT LIKE 'APEX%'
             AND table_name NOT LIKE 'CTX%'
             AND table_name NOT LIKE 'DBA%'
             AND table_name NOT LIKE 'V_\$%'
             AND table_name NOT LIKE 'AQ\$_%'
             AND table_name NOT LIKE 'LOGMNR%'
             AND table_name NOT LIKE 'MVIEW\$_%'
             AND table_name NOT LIKE 'ROLLING\$%'
             AND table_name NOT LIKE 'HELP'
             AND table_name NOT LIKE 'LOGSTDBY\$%'
             AND table_name NOT LIKE 'OL\$%'
             AND table_name NOT LIKE 'REDO_%'
             AND table_name NOT LIKE 'REPL_%'
             AND table_name NOT LIKE 'SCHEDULER_%'
             AND table_name NOT LIKE 'SQLPLUS_PRODUCT_PROFILE'
             ORDER BY table_name";
my $dbh = $db->get_dbh();
my $sth = $dbh->prepare($query);
$sth->execute();

print "\nAvailable user tables in the database:\n";
print "====================================\n";
while (my $row = $sth->fetchrow_hashref()) {
    print $row->{TABLE_NAME} . "\n";
}
print "====================================\n\n";

# Disconnect from database
$db->disconnect(); 

# Step 1: Define the data (as a hash)
my %data = (
    name   => 'Melissa the Mechanic',
    title  => 'Shield Technician',
    status => 'Lost in Wormhole J142118',
);

# Print the data in a readable format
print "Data:\n";
foreach my $key (keys %data) {
    print "  $key: $data{$key}\n";
}

# Step 2: Convert to JSON
my $json_text = encode_json(\%data);
print "\nJSON: $json_text\n";

# Step 3: Write to a file
my $output_dir = '/usr/src/practice-perl/output';
mkdir $output_dir unless -d $output_dir;  # Create output directory if it doesn't exist
my $output_file = "$output_dir/status_report.json";

open(my $fh, '>', $output_file) or die "Cannot open file: $!";
print $fh $json_text;
close($fh);

print "\nFile written successfully to: $output_file\n";