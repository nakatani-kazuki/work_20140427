#!/usr/local/bin/perl
use strict;

# 1.hello worldを標準出力に出力するサブルーチンを作成し、作成した	サブルーチンを用いてhello worldを出力して下さい。
=pod
print_hello();

sub print_hello {
	print "hello world! \n";
}


# 2.渡した文字列を出力するサブルーチンを作成し、実行時に渡した値を出力してください
#my ($aaa ,$bbb) = @_;
#subの中で何かの変数を受け取るときは、↑のように[@_]と定型文で書く。

my $word = "元気？";

print_word($word);

sub print_word {
	my ($printword) = @_;
	#（）でくくると、配列の「中身」を受け取る。（）がないと配列の「個数」だけ表示される？
	print "$printword \n";
}


my $word1 = "おなかすいてる？";
my $word2 = "死にそう！"; 

print_word($word1,$word2);

sub print_word {
	my ($printword1, $printword2) = @_;
	print "$printword1 \n" . "$printword2 \n";
}
=cut



#4.以下のユーザ情報を用いていろいろやる

my $user_info = +{
	1 => +{
		name => 'aaa',
		defense => 100,
		offense => 30,
		speed   => 1,
	},
	2 => +{
		name => 'bbb',
		defense => 123,
		offense => 10,
		speed   => 10,
	},
	3 => +{
		name => 'ccc',
		defense => 20,
		offense => 130,
		speed   => 21,
	},
};

# for my $user( keys %$user_info){
# 	for my $user_status( keys $user_info->{$user}){
# 		print "$user_status : " . "$user_info->{$user}{$user_status}\n" ;
# 	}
# }


#・defenseの大きい順を出力
# my @array;

# for my $user( keys %$user_info){
# 	my $defense = $user_info->{$user}->{defense};
# 	push (@array , $defense);
# 	# print "$defense \n";
# }

# my @sorted = sort {$b <=> $a} @array;

# use Data::Dumper;
# print Dumper(\@sorted);



#・defense + offenseの大きい順
# my @array;

# for my $user( keys %$user_info){
# 	my $defense = $user_info->{$user}->{defense};
# 	my $offense = $user_info->{$user}->{offense};
# 	my $sum = $defense + $offense;
# 	#defenseとoffenseを足していっこの数字にする
# 	#print "$sum \n";
# 	push (@array , $sum);
# }

# my @sorted = sort {$b <=> $a} @array;

# use Data::Dumper;
# print Dumper(\@sorted);


#・speedの早い順
# my @array;

# for my $user( keys %$user_info){
# 	my $speed = $user_info->{$user}->{speed};
# 	# print "$ speed \n";
# 	push (@array , $speed);
# }

# my @sorted = sort {$b <=> $a} @array;

# use Data::Dumper;
# print Dumper(\@sorted);


#・defense + offenseでバトルを行い、その際の勝敗情報
my $my_id = 1;
my $enemy_id = 2;
# バトルさせるユーザを決める。とりあえず配列名をユーザIDってことで。
#------------------------------
# ↑コメントは基本的に該当行の上に書く
#------------------------------


my $my_sum = &sum($my_id);
my $enemy_sum = &sum($enemy_id);
#自分と敵それぞれのdefenseとoffenseを合計してくる。
#やることはサブルーチンで処理、戻り値を変数に代入してそのまま使う
#------------------------------
# 実行時の&は多少好みもあるけどなくても関数は実行されるからmobageだと書かない場合が多い
#------------------------------


if ($my_sum > $enemy_sum) {
	print "Win! \n";
}
else{
	print "Lose... \n";
}
# 敵のsumと比較して、自分が大きければwin、小さければloseを表示
#------------------------------
# ↑ここは三項演算子を使うとスッキリ書けるからやってみて
# あとこの条件だと引き分けも負けになるからその辺はコメント書いてあげたほうがわかりやすい
# 「引き分けの場合は負けにする」とか
#------------------------------


#------------------------------
# ↓もうちょっと具体的な関数名にした方が使うときに何が起きるか想像しやすくなる
#------------------------------
sub sum {
	my ($user_id) = @_;
	#敵でも味方でもとりあえずuser_idをうけとる
	my $defense = $user_info->{$user_id}->{defense};
	my $offense = $user_info->{$user_id}->{offense};
	my $sum = $defense + $offense;
	return $sum;
}

#print "$my_sum \n" . "$enemy_sum \n";



#-------------------------------
# 俺だったらこんな感じかも
#-------------------------------
my $user_info = +{
	1 => +{
		name => 'aaa',
		defense => 100,
		offense => 30,
		speed   => 1,
	},
	2 => +{
		name => 'bbb',
		defense => 123,
		offense => 10,
		speed   => 10,
	},
	3 => +{
		name => 'ccc',
		defense => 20,
		offense => 130,
		speed   => 21,
	},
};

my $user_id  = 1;
my $enemy_id = 2;

exec_battle($user_id, $enemy_id);

# バトル実行
# ここは各機能から必要な物を選んで結合して使用する関数
sub exec_battle {
	my ($user_id, $enemy_id) = @_;
	my $user_param = get_defence_offense_sum_by_id($user_id);
	my $enemy_param = get_defence_offense_sum_by_id($enemy_id);

	my $is_win = get_battle_result($user_param, $enemy_param);
	print_result($is_win);
}

# 結果を出力する関数
sub print_result {
	my ($is_win) = @_;
	my $result = ($is_win) ? 'WIN!' : 'LOSE...';
	print $result . "\n";
}

# 引き分けはユーザの勝利とする
sub get_battle_result {
	my ($user_param, $enemy_param) = @_;
	return ($user_param >= $enemy_param) ? 1 : 0;
}

# 関数名は何を渡すと何が返ってくるのかが具体的にわかるほうがいい
# sumみたいに抽象的過ぎるとあとで似たような巻数を追加したくなった時に「関数名どうしよう…」てなる
# あとsumだけだと何と何の合計値を返してくる関数なのかをソースを見ないとわからん
# ↓これも一旦こんな形で書いてみたけど結構汎用性低いから、本来はもっと分割して実装したりする
# 詳細は口頭で説明するから聞いてみて
sub get_defence_offense_sum_by_id {
	my ($user_id) = @_;
	return get_param_by_keys($user_id, \('defense', 'offense'));
}

sub get_speed_offense_sum_by_id {
	my ($user_id) = @_;
	return get_param_by_keys($user_id, \('speed', 'offense'));
}

sub get_param_by_keys {
	my ($user_id, $keys) = @_;
	my $param = 0;
	map { $param += $user_info->{$user_id}->{$_} } @$keys;
	return $param;
}
