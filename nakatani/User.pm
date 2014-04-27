package User;
use strict;

use Class::Accessor::Lite (
    new => 1,
    ro  => [
        qw/
          user
          enemy
          /
    ],
    rw => [
        qw/
          result
          /
    ],
);

sub build {
	my ($class, $user_id) = @_;

	my $members = +{
		user    => 'aaa',
		enemy   => 'bbb',
		result  => undef,
	};

	return $class->new($members);
}

1;