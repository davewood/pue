package Pue::Config;

use 5.022;

use Dir::Self;
use Log::Any qw($log);
use Config::ZOMG;

sub get {
    my $root = __DIR__ . '/../..';
    my $zomg = Config::ZOMG->new(
        name => "Pue",
        path => "$root/etc",
    );
    $log->infof( "Loading config from %s", $_ ) for $zomg->find;
    my $config = $zomg->load;
    return $config;
}

1;
