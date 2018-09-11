package Pue::PSGI;
use 5.022;
use Moose;

use Plack::Builder;
use Pue::PSGI::Request;

sub app {
    my $self = shift;

    my $app = sub {
        my $env = shift;
        return [ 404, [], ['not found'] ];
    };

    my $builder = Plack::Builder->new;
    return $builder->wrap($app);
}

__PACKAGE__->meta->make_immutable;
