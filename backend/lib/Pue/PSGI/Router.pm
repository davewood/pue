package Pue::PSGI::Router;
use 5.022;

use Router::Simple;

sub routes {
    my $self = shift;

    my $router = Router::Simple->new();
    $router->connect( '/',
        { controller => 'root_ctrl', action => 'index' } );
    $router->connect( '/users',
        { controller => 'user_ctrl', action => 'users', rest => 1 } );
    return $router;
}

1;
