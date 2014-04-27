package Kaijin;
use strict;
use Data::Dumper;

#parent = 親となるクラス
use parent qw/Human/;


#怪人の個性
my $SERIF_CONF = +{
	attack   => "これでも喰らうがいい！",
	last     => "フハハハハハ！無様なものだ！！！",
	special  => "おのれゴーカイジャーー！！"
};
my $name = "ザンギャック";

sub build {
	my ($class) = @_;
	my $kaijin = $class->SUPER::build;
	$kaijin->henshin();
	return $kaijin;
}

sub henshin{
	my ($self) = @_;
	$self->name( $name );
	$self->hp( int($self->hp() * 1.4) );
	$self->attack( int($self->attack() * 1.4) );
	$self->defense( int($self->defense() * 1.2) );
	$self->speed( int($self->speed() * 0.8) );
	$self->attack_serif( $SERIF_CONF->{attack} );
	$self->last_serif( $SERIF_CONF->{last} );
	$self->special_serif( $SERIF_CONF->{special} );
}
