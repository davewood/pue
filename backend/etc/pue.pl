use 5.022;

use Dir::Self;

my $root = __DIR__ . '/../';

my $config = {
    root => $root,
    dsn  => "dbi:Pg:service=pue",
};

return $config;
