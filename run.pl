#!/usr/bin/perl
use strict;
use warnings;
use lib qw(. db);
use OracleDB;

# This is the main script that runs the Project/Demo

# Create database connection
my $db = OracleDB->new(
    dsn      => 'dbi:Oracle:host=host.docker.internal;sid=XE;port=1521',
    username => 'SYSTEM',
    password => 'myCurrentPassword$523'
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