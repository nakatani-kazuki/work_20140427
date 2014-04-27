package Human;
use strict;
use Data::Dumper;

use Class::Accessor::Lite (
    new => 1,
    rw  => [
        qw/
          name
          hp
          attack
          defense
          speed
          attack_serif
          last_serif
          special_serif
          /
    ],
);


# ビルド
# 　HP、アタック…などまとめてnewする
my $SERIF_CONF = +[
	+{
		attack   => "派手に行くぜ！",
		last     => "これが海賊ってもんだろ！",
		special  => "ファイナルウェィィィッィィブ！"
	},
	+{
		attack   => "斬らせてもらう!",
		last     => "フン…",
		special  => "ファイナルウェィィィッィィブ！"
	},
	+{
		attack   => "ギンッギンだぜ！",
		last     => "正義は勝つ！！！",
		special  => "ファイナルウェィィィッィィブ！"
	}
];


sub build {
	my ($class) = @_;
	my $serif = _get_serif();
#	print Dumper($serif);
	my $user_info = +{
		name          => "normal_human",
		hp            => _get_hp(),
		attack        => _get_attack(),
		defense       => _get_defense(),
		speed         => _get_speed(),
		attack_serif  => $serif->{attack},
		last_serif    => $serif->{last},
		special_serif => $serif->{special},
	};
	return $class->new($user_info);
}

# 80 〜 100 でランダム(build時に確定)
sub _get_hp {
	# この辺の設定周りは本来はファイルの上部にまとめるか、
	# Conf.pmみたいなファイルに切り出すとかする
	my $min = 80;
	my $max = 100;
	return _get_rand_num($min, $max);
}

# 10 〜 20 でランダム(build時に確定)
sub _get_attack {
	my $min = 10;
	my $max = 20;
	return _get_rand_num($min, $max);
}

# 10 〜 30 でランダム(build時に確定)
sub _get_defense {
	my $min = 10;
	my $max = 30;
	return _get_rand_num($min, $max);
}

# 10 〜 30 でランダム(build時に確定)
sub _get_speed {
	my $min = 10;
	my $max = 30;
	return _get_rand_num($min, $max);
}

# こういう汎用的な関数はUtil.pmみたいなのに切り出しておくと
# Battle.pmとかでも使いたくなった時に使いやすい
# minとmaxの間の数をランダムに選んで返す
sub _get_rand_num {
	my ($min , $max) = @_;
	return int (rand(($max+1) - $min)) + $min;
}

# この辺の作りは汎用性高めに作ってあるからええ感じ
# 返り値が「単一 <-> 複数」は関数名から判断出来たほうがいいので
# この場合は _get_serif_set とかがよさそうかも
sub _get_serif {
	my $chara_id = _get_rand_num(0 , $#$SERIF_CONF);
	return @$SERIF_CONF[$chara_id];
}

#外からステータスを渡されると、オブジェクトの中からステータスの値を探しだしてプリントする
#selfの書き方が腹に落ちないがこんな書き方でいいのだろうか
=pod
->battle周りのロジックを書く時に何を出力するかを簡単に書き換えるようにしたいんならこの実装は全然あり。
特に違和感も感じない
ただし存在しないキーを指定された時は死にそう

for (@$print_status) {
	die 'no such member!' unless ($self->can());
	print "$_ : " . "$self->{$_} \n"
}

とかにしておくとなんで死んだのかがわかりやすいかも
=cut
sub print_status {
	my ($self, $print_status) = @_;
	print "============================= \n";
	map { print "$_ : " . "$self->{$_} \n" } @$print_status;
	print "============================= \n";
}

=pod
これはなぜ必要なのか？
$player1->get_status("speed");
じゃなくても
$player1->speed;
でけるんじゃなかろうか
=cut
#外からステータスを渡されると、オブジェクトの中からステータスの値を探しだして返す
sub get_status {
	my ($self, $status) = @_;
	return $self->{$status};
}





