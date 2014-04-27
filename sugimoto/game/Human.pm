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
		attack   => "人間だって頑張る！",
		last     => "人間だって勝てるんです！",
		special  => "お国のためにー！！"
	},
	+{
		attack   => "人間なめんなよ",
		last     => "見たかコノヤロー！",
		special  => "ｵﾗｱｱｱｱｱｱｱｱｱｱｱｱｱ"
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

# minとmaxの間の数をランダムに選んで返す
sub _get_rand_num {
	my ($min , $max) = @_;
	return int (rand(($max+1) - $min)) + $min;
}

sub _get_serif {
	my $chara_id = _get_rand_num(0 , $#$SERIF_CONF);
	return @$SERIF_CONF[$chara_id];
}

#外からステータスを渡されると、オブジェクトの中からステータスの値を探しだしてプリントする
#selfの書き方が腹に落ちないがこんな書き方でいいのだろうか
sub print_status {
	my ($self, $print_status) = @_;
	print "============================= \n";
	map { print "$_ : " . "$self->{$_} \n" } @$print_status;
	print "============================= \n";
}

#外からステータスを渡されると、オブジェクトの中からステータスの値を探しだして返す
sub get_status {
	my ($self, $status) = @_;
	return $self->{$status};
}





