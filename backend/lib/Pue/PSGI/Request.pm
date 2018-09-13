package Pue::PSGI::Request;
use 5.022;

use Moose;

extends 'Web::Request';
with qw(Web::Request::Role::JSON Web::Request::Role::Response);

__PACKAGE__->meta->make_immutable;
