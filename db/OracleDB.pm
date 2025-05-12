package OracleDB;

use strict;
use warnings;
use DBI;
use Carp;

sub new {
    my ($class, %params) = @_;
    my $self = {
        dsn      => $params{dsn},
        username => $params{username},
        password => $params{password},
        dbh      => undef
    };
    return bless $self, $class;
}

sub connect {
    my $self = shift;
    $self->{dbh} = DBI->connect(
        $self->{dsn},
        $self->{username},
        $self->{password},
        {
            RaiseError => 1,
            PrintError => 0,
            AutoCommit => 1
        }
    ) or croak "Failed to connect to database: $DBI::errstr";
    return $self->{dbh};
}

sub disconnect {
    my $self = shift;
    if ($self->{dbh}) {
        $self->{dbh}->disconnect();
        $self->{dbh} = undef;
    }
}

sub get_dbh {
    my $self = shift;
    return $self->{dbh};
}

1; 