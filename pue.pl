use 5.022;

use Dir::Self;

my $home = __DIR__;

my $config = {
    dsn => "dbi:SQLite:$home/pue.db"
};

return $config;
