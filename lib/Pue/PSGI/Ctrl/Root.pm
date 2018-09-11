package Pue::PSGI::Ctrl::Root;
use 5.022;

use Moose;

sub index {
    my ( $self, $req ) = @_;
    return $req->json_response(
        {   version => $Pue::VERSION,
            claim   => 'frameworkless perl api and vuejs demo'
        }
    );
}

__PACKAGE__->meta->make_immutable;
