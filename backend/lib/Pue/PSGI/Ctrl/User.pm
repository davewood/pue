package Pue::PSGI::Ctrl::User;
use 5.022;

use Moose;

has 'schema' => (
    is       => 'ro',
    isa      => 'Pue::Schema',
    required => 1,
);

sub users_GET {
    my ( $self, $req ) = @_;
    my @users = map {{id => $_->id}} $self->schema->resultset('Usr')->all;
    return $req->json_response( \@users );
}

__PACKAGE__->meta->make_immutable;
