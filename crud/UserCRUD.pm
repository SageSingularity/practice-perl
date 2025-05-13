package UserCRUD;

use strict;
use warnings;
use base 'OracleDB';
use Carp;
use DBD::Oracle qw(:ora_types);

# Create a new user
sub create_user {
    my ($self, %user_data) = @_;
    my $dbh = $self->get_dbh();
    
    my $sql = q{
        INSERT INTO users (username, email, created_at, updated_at)
        VALUES (:username, :email, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
        RETURNING user_id INTO :user_id
    };
    
    my $sth = $dbh->prepare($sql);
    $sth->bind_param(':username', $user_data{username});
    $sth->bind_param(':email', $user_data{email});
    $sth->bind_param(':user_id', \my $user_id, { ora_type => ORA_NUMBER });
    
    eval {
        $sth->execute();
    };
    
    if ($@) {
        croak "Failed to create user: $@";
    }
    
    return $user_id;
}

# Read user by ID
sub get_user {
    my ($self, $user_id) = @_;
    my $dbh = $self->get_dbh();
    
    my $sql = q{
        SELECT user_id, username, email, created_at, updated_at
        FROM users
        WHERE user_id = :user_id
    };
    
    my $sth = $dbh->prepare($sql);
    $sth->bind_param(':user_id', $user_id);
    
    eval {
        $sth->execute();
    };
    
    if ($@) {
        croak "Failed to retrieve user: $@";
    }
    
    return $sth->fetchrow_hashref();
}

# Update user
sub update_user {
    my ($self, $user_id, %user_data) = @_;
    my $dbh = $self->get_dbh();
    
    my $sql = q{
        UPDATE users
        SET username = :username,
            email = :email,
            updated_at = CURRENT_TIMESTAMP
        WHERE user_id = :user_id
    };
    
    my $sth = $dbh->prepare($sql);
    $sth->bind_param(':username', $user_data{username});
    $sth->bind_param(':email', $user_data{email});
    $sth->bind_param(':user_id', $user_id);
    
    eval {
        $sth->execute();
    };
    
    if ($@) {
        croak "Failed to update user: $@";
    }
    
    return $sth->rows();
}

# Delete user
sub delete_user {
    my ($self, $user_id) = @_;
    my $dbh = $self->get_dbh();
    
    my $sql = q{
        DELETE FROM users
        WHERE user_id = :user_id
    };
    
    my $sth = $dbh->prepare($sql);
    $sth->bind_param(':user_id', $user_id);
    
    eval {
        $sth->execute();
    };
    
    if ($@) {
        croak "Failed to delete user: $@";
    }
    
    return $sth->rows();
}

# List all users
sub list_users {
    my ($self, $limit, $offset) = @_;
    my $dbh = $self->get_dbh();
    
    $limit  ||= 10;
    $offset ||= 0;
    
    my $sql = q{
        SELECT user_id, username, email, created_at, updated_at
        FROM users
        ORDER BY user_id
        OFFSET :offset ROWS FETCH NEXT :limit ROWS ONLY
    };
    
    my $sth = $dbh->prepare($sql);
    $sth->bind_param(':limit', $limit, { ora_type => ORA_NUMBER });
    $sth->bind_param(':offset', $offset, { ora_type => ORA_NUMBER });
    
    eval {
        $sth->execute();
    };
    
    if ($@) {
        croak "Failed to list users: $@";
    }
    
    my @users;
    while (my $row = $sth->fetchrow_hashref()) {
        push @users, $row;
    }
    
    return \@users;
}

1; 