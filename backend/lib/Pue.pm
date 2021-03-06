package Pue;
use 5.022;

our $VERSION = '0.001';

use Bread::Board;
use Module::Runtime 'use_module';
use Pue::Config;
use Pue::X;

my $c = container 'Pue' => as {
    container 'App' => as {
        service 'Config' => (
            class     => 'Pue::Config',
            lifecycle => 'Singleton',
            block     => sub {
                return Pue::Config::get();
            }
        );
        service 'pue.pl' => (
            class        => 'Pue::Server',
            lifecycle    => 'Singleton',
            dependencies => {
                psgi => '/PSGI/App',
            }
        );
    };
    container 'DB' => as {
        service 'Schema' => (
            class        => 'Pue::Schema',
            lifecycle    => 'Singleton',
            dependencies => { config => '/App/Config' },
            block        => sub {
                my $s = shift;
                my $config = $s->params->{config};
                Pue::Schema->connect( $config->{dsn}, undef, undef );
            },
        );
    };
    container 'PSGI' => as {
        service 'App' => (
            class        => 'Pue::PSGI',
            lifecycle    => 'Singleton',
            dependencies => {
                config    => '/App/Config',
                router    => '/PSGI/Router',
                user_ctrl => '/Controller/User',
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
        service 'User' => (
            lifecycle => 'Singleton',
            class     => 'Pue::PSGI::Ctrl::User',
            dependencies => {
                schema => '/DB/Schema'
            }
        );
    };
};

sub init {
    return $c;
}

1;
