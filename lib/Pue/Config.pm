package Pue::Config;

use 5.022;

use Config::ZOMG;
use Dir::Self;

sub get {
    my $home = __DIR__ . '/../..';
    my $zomg = Config::ZOMG->new(
        name => "Pue",
        path => $home,
    );
    my $config = $zomg->load;
    return $config;
}

1;
