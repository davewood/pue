use utf8;
package Pue::Schema::Result::Usr;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Pue::Schema::Result::Usr

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<usr>

=cut

__PACKAGE__->table("usr");

=head1 ACCESSORS

=head2 usr_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'test'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "usr_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "test", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</usr_id>

=back

=cut

__PACKAGE__->set_primary_key("usr_id");


# Created by DBIx::Class::Schema::Loader v0.07047 @ 2018-09-12 13:14:58
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qAi9EUahU4/BwkZjJSNERA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
