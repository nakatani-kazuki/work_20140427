package BlueRanger;
use strict;
use Data::Dumper;

#parent = 親となるクラス
use parent qw/Human/;


#ブルーの個性
my $SERIF_CONF = +{
	attack   => "斬らせてもらう！",
	last     => "フン…",
	special  => "ブルーチャーージ！ファイナルウェィィィッィィブ！"
};
my $name = "ゴーカイブルー";

sub build {
	my ($class) = @_;
	my $blue_ranger = $class->SUPER::build;
	$blue_ranger->henshin();
	return $blue_ranger;
}

sub henshin{
	my ($self) = @_;
	$self->name( $name );
	$self->hp( int($self->hp() * 1.2) );
	$self->attack( int($self->attack() * 1.4) );
	$self->defense( int($self->defense() * 0.8) );
	$self->speed( int($self->speed() * 1.1) );
	$self->attack_serif( $SERIF_CONF->{attack} );
	$self->last_serif( $SERIF_CONF->{last} );
	$self->special_serif( $SERIF_CONF->{special} );
}
