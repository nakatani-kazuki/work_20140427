package YellowRanger;
use strict;
use Data::Dumper;

#parent = 親となるクラス
use parent qw/Human/;


#イエローの個性
my $SERIF_CONF = +{
	attack   => "なめんじゃないわよ！",
	last     => "100年早いのよ、バァーカ！！！",
	special  => "イエローチャーージ！ファイナルウェィィィッィィブ！"
};
my $name = "ゴーカイイエロー";

sub build {
	my ($class) = @_;
	my $yellow_ranger = $class->SUPER::build;
	$yellow_ranger->henshin();
	return $yellow_ranger;
}

sub henshin{
	my ($self) = @_;
	$self->name( $name );
	$self->hp( int($self->hp() * 0.9) );
	$self->attack( int($self->attack() * 1.2) );
	$self->defense( int($self->defense() * 1.2) );
	$self->speed( int($self->speed() * 1.5) );
	$self->attack_serif( $SERIF_CONF->{attack} );
	$self->last_serif( $SERIF_CONF->{last} );
	$self->special_serif( $SERIF_CONF->{special} );
}
