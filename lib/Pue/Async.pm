package Pue::Async;
use 5.022;
use Moose;

use Net::Async::HTTP::Server::PSGI;

use Log::Any qw($log);

has 'loop' => (
    is       => 'ro',
    isa      => 'IO::Async::Loop',
    required => 1,
);

has 'psgi' => (
    is       => 'ro',
    isa      => 'Pue::PSGI',
    required => 1,
);

sub run {
    my $self = shift;

    my $httpserver =
        Net::Async::HTTP::Server::PSGI->new( app => $self->psgi->app );

    $self->loop->add($httpserver);

    my $port = $ENV{PUE_PORT} || 8080;
    $httpserver->listen(
        addr => {
            family   => "inet",
            socktype => "stream",
            port     => $port,
        },
        on_listen_error => sub { die "Cannot listen - $_[-1]\n" },
    );
    $log->infof( "Starting up on http://localhost:%i", $port );

    $self->loop->run;
}

__PACKAGE__->meta->make_immutable;
