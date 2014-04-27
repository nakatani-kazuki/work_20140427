package RedRanger;
use strict;
use Data::Dumper;

#parent = 親となるクラス
use parent qw/Human/;


#アカレンジャーの個性
my $SERIF_CONF = +{
	special  => "レッドチャーージ！ファイナルウェィィィッィィブ！"
};
my $name = "ゴーカイレッド";


# # ベースの人間を作る
# my $red_ranger = RedRanger->build_human();

# #変身！！
# $red_ranger->henshin();

sub build {
	my ($class) = @_;
	my $red_ranger = $class->SUPER::build;
	$red_ranger->henshin();
	return $red_ranger;
}

sub henshin{
	my ($self) = @_;
	$self->name( $name );
	$self->hp( int($self->hp() * 1.5) );
	$self->attack( int($self->attack() * 1.3) );
	$self->defense( int($self->defense() * 0.9) );
	$self->speed( int($self->speed() * 0.6) );
	$self->special_serif( $SERIF_CONF->{special} );
}

#オブジェクトの持ってる値を置き換えたいとき
# $red_ranger->attack( $red_ranger->attack() * 1.2 );
# 

#　親のHumanクラスにこの機能もってるのでこっちにはいらない！
# sub print_status {
# 	my ($self, $print_status) = @_;
# 	print "============================= \n";
# 	map { print "$_ : " . "$self->{$_} \n" } @$print_status;
# 	print "============================= \n";
# }
