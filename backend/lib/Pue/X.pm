package Pue::X;
use Moose;
with qw(Throwable::X);

use Throwable::X -all;

has [qw(http_status)] => (
    is      => 'ro',
    default => 400,
    traits  => [Payload],
);

no Moose;
__PACKAGE__->meta->make_immutable;

package Pue::X::Forbidden;
use Moose;
extends 'Pue::X';
use Throwable::X -all;

has '+http_status' => ( default => 403 );

no Moose;
__PACKAGE__->meta->make_immutable;

package Pue::X::NotFound;
use Moose;
extends 'Pue::X';
use Throwable::X -all;

has '+http_status' => ( default => 404 );

no Moose;
__PACKAGE__->meta->make_immutable;

