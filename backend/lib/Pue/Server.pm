package Pue::Server;
use 5.022;
use Moose;

use HTTP::Server::PSGI;

use Log::Any qw($log);

has 'psgi' => (
    is       => 'ro',
    isa      => 'Pue::PSGI',
    required => 1,
);

sub run {
    my $self = shift;

    my $port = $ENV{PUE_PORT} || 8080;
    my $host = $ENV{PUE_HOST} || '127.0.0.1';
    my $server = HTTP::Server::PSGI->new(
        port => $port,
    );
    $log->infof( "Starting up on http://%s:%i/index.html", $host, $port );
    $server->run( $self->psgi->app );
}

__PACKAGE__->meta->make_immutable;
