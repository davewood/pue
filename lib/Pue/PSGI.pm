package Pue::PSGI;
use 5.022;
use Moose;

use Plack::Builder;
use Pue::PSGI::Request;
use Pue::X;

has 'router' => (
    is       => 'ro',
    isa      => 'Router::Simple',
    required => 1,
);

has 'root_ctrl' => (
    is       => 'ro',
    isa      => 'Pue::PSGI::Ctrl::Root',
    required => 1,
);

has 'user_ctrl' => (
    is       => 'ro',
    isa      => 'Pue::PSGI::Ctrl::User',
    required => 1,
);

sub app {
    my $self = shift;

    my $app = sub {
        my $env = shift;

        if ( my $match = $self->router->match($env) ) {
            my $req    = Pue::PSGI::Request->new_from_env($env);
            my $ctrl   = delete $match->{controller};
            my $action = delete $match->{action};
            if ( delete $match->{rest} ) {
                $action .= '_' . $req->method;
            }

            unless ( $self->$ctrl->can($action) ) {
                return [
                    405,
                    [],
                    [         $req->method
                            . ' not allowed on '
                            . $env->{REQUEST_URI}
                    ]
                ];
            }
            my $rv = $self->$ctrl->$action( $req, $match );
            return $rv->finalize;
        }
        else {
            Pue::X::NotFound->throw( { ident => 'not found' } );
        }
    };

    my $builder = Plack::Builder->new;
    $builder->add_middleware('Plack::Middleware::PrettyException');
    return $builder->wrap($app);
}

__PACKAGE__->meta->make_immutable;
