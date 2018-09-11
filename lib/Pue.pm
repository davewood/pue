package Pue;
use 5.022;

our $VERSION = '0.001';

use Bread::Board;
use Module::Runtime 'use_module';
use Pue::X;

my $c = container 'Pue' => as {
    container 'App' => as {
        service 'pue.pl' => (
            class        => 'Pue::Async',
            lifecycle    => 'Singleton',
            dependencies => {
                psgi => '/PSGI/App',
                loop => '/Async/Loop',
            }
        );
    };
    container 'PSGI' => as {
        service 'App' => (
            class        => 'Pue::PSGI',
            lifecycle    => 'Singleton',
            dependencies => {
                router    => '/PSGI/Router',
                root_ctrl => '/Controller/Root',
            }
        );
        service 'Router' => (
            class     => 'Router::Simple',
            lifecycle => 'Singleton',
            block     => sub {
                use_module('Pue::PSGI::Router');
                return Pue::PSGI::Router->routes;
            }
        );
    };
    container 'Controller' => as {
        service 'Root' => (
            lifecycle => 'Singleton',
            class     => 'Pue::PSGI::Ctrl::Root',
        );
    };
    container 'Async' => as {
        service 'Loop' => (
            lifecycle => 'Singleton',
            class     => 'IO::Async::Loop',
        );
    };
};

sub init {
    return $c;
}

1;
