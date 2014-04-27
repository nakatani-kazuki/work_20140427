package User;
use strict;

use Class::Accessor::Lite (
    new => 1,
    ro  => [
        qw/
          user_id
          user_name
          offense
          defense
          /
    ],
);

my @user_ids = (1,2,3);
my @user_names = ('user_1','user_2','user_3');
my @user_offense_params = (200,190,30);
my @user_defense_params = (20,120,230);


sub user_ids {
	return \@user_ids;
}

sub build {
	my ($class, $user_id) = @_;
	die "no user_id! \n" unless ($user_id > 0);
	my $user_info = $class->_get_user_info($user_id);
	return $class->new($user_info);
}

sub _get_user_info {
	my ($class, $user_id) = @_;
	my $user_name = @user_names[$user_id - 1];
	my $offense   = @user_offense_params[$user_id - 1];
	my $defense   = @user_defense_params[$user_id - 1];
	die "no user_information! \n" 
		if (!$user_name || !$offense || !$defense);
	return +{
		user_id    => $user_id,
		user_name  => @user_names[$user_id - 1],
		offense    => @user_offense_params[$user_id - 1],
		defense    => @user_defense_params[$user_id - 1],
	};
}

sub get_param_sum {
	my ($self) = @_;
	return $self->offense + $self->defense;
}


1;