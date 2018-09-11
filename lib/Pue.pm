package Pue;
use 5.022;

our $VERSION = '0.001';

use Bread::Board;

my $c = container 'Pue' => as {
    container 'App' => as {
        service 'pue.pl' => (
            class        => 'Pue::Async',
            lifecycle    => 'Singleton',
            dependencies => {
                psgi       => '/PSGI/App',
                loop       => '/Async/Loop',
            }
        );
    };
    container 'PSGI' => as {
        service 'App' => (
            class     => 'Pue::PSGI',
            lifecycle => 'Singleton',
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
