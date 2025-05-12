package OracleDB;

use strict;
use warnings;
use DBI;
use Carp;

sub new {
    my ($class, %params) = @_;
    my $self = {
        _dsn      => $params{dsn}      || 'dbi:Oracle:host=localhost;sid=XE',
        _username => $params{username} || '',
        _password => $params{password} || '',
        _dbh      => undef,
    };
    bless $self, $class;
    return $self;
}

sub connect {
    my $self = shift;
    
    eval {
        $self->{_dbh} = DBI->connect(
            $self->{_dsn},
            $self->{_username},
            $self->{_password},
            {
                RaiseError => 1,
                AutoCommit => 1,
                ora_charset => 'AL32UTF8'
            }
        );
    };
    
    if ($@) {
        croak "Failed to connect to Oracle database: $@";
    }
    
    return $self->{_dbh};
}

sub disconnect {
    my $self = shift;
    
    if ($self->{_dbh}) {
        $self->{_dbh}->disconnect();
        $self->{_dbh} = undef;
    }
}

sub get_dbh {
    my $self = shift;
    return $self->{_dbh};
}

1; 