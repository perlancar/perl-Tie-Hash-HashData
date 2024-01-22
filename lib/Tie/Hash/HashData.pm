package Tie::Hash::HashData;

use strict;
use warnings;

# AUTHORITY
# DATE
# DIST
# VERSION

sub TIEHASH {
    require Module::Load::Util;

    my $class = shift;
    my ($hashdata) = @_;

    die "Please specify a HashData module to instantiate (string or 2-element array)" unless $hashdata;
    my $hdobj = Module::Load::Util::instantiate_class_with_optional_args({ns_prefix=>"HashData"}, $hashdata);

    return bless {
        _hdobj => $hdobj,
    }, $class;
}

sub FETCH {
    my ($self, $key) = @_;
    if ($self->{_hdobj}->has_item_at_key($key)) {
        $self->{_hdobj}->get_item_at_key($key);
    } else {
        undef;
    }
}

sub STORE {
    my ($self, $key, $value) = @_;
    die "Not supported";
}

sub DELETE {
    my ($self, $key) = @_;
    die "Not supported";
}

sub CLEAR {
    my ($self) = @_;
    die "Not supported";
}

sub EXISTS {
    my ($self, $key) = @_;
    $self->{_hdobj}->has_item_at_key($key);
}

sub FIRSTKEY {
    my ($self) = @_;
    $self->{_hdobj}->reset_iterator;
    if ($self->{_hdobj}->has_next_item) {
        my $res = $self->{_hdobj}->get_next_item;
        $res->[0];
    } else {
        undef;
    }
}

sub NEXTKEY {
    my ($self, $lastkey) = @_;
    if ($self->{_hdobj}->has_next_item) {
        my $res = $self->{_hdobj}->get_next_item;
        $res->[0];
    } else {
        undef;
    }
}

sub SCALAR {
    my ($self) = @_;
    $self->{_hdobj}->get_item_count;
}

sub UNTIE {
    my ($self) = @_;
    #die "Not supported";
}

# DESTROY

1;
# ABSTRACT: Access HashData object as a tied hash

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Tie::Hash::HashData;

 tie my %hash, 'Tie::Hash::HashData', 'Sample::DeNiro';

 # use like you would a regular hash
 say $hash{'Taxi Driver'}; # => 1976
 ...


=head1 DESCRIPTION


=head1 SEE ALSO

L<HashData>

=cut
