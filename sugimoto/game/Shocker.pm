package Shocker;
use strict;
use Data::Dumper;

#parent = 親となるクラス
use parent qw/Human/;


#ショッカーの個性
my $SERIF_CONF = +{
	attack   => "イーー！！",
	last     => "イーーーーー！！イーーーーー！！！",
	special  => "イィィィィィィィィィ！！！"
};
my $name = "ショッカー";

sub build {
	my ($class) = @_;
	my $shocker = $class->SUPER::build;
	$shocker->henshin();
	return $shocker;
}

sub henshin{
	my ($self) = @_;
	$self->name( $name );
	$self->hp( int($self->hp() * 0.9) );
	$self->attack( int($self->attack() * 0.8) );
	$self->defense( int($self->defense() * 0.9) );
	$self->speed( int($self->speed() * 1.4) );
	$self->attack_serif( $SERIF_CONF->{attack} );
	$self->last_serif( $SERIF_CONF->{last} );
	$self->special_serif( $SERIF_CONF->{special} );
}
