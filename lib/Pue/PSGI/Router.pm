package Pue::PSGI::Router;
use 5.022;

use Router::Simple;

sub routes {
    my $self = shift;

    my $router = Router::Simple->new();
    $router->connect( '/',
        { controller => 'root_ctrl', action => 'index' } );
    return $router;
}

1;
