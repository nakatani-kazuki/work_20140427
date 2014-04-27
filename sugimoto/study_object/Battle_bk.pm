package Battle;
use strict;
use User;
use Data::Dumper;

# my $object = User->build(4);
main();

sub main {
	#とりあえずユーザIDは1で固定（あとから選んだりする）
	my $user_id = 1;
	# 自分のユーザ情報を作る（オフェンスとディフェンスも足しとく）
	my $user = get_user($user_id);
	# get_enemy_user_idで敵を抽選する（とりあえずは2で決め打ちでつくる）
	# ↑で取得した敵ユーザIDをもとに、敵のユーザ情報を作る（オフェンスとディフェンスも足しとく）	
	my $enemy = get_enemy(get_enemy_user_id());
	# sumを比べてバトルさせる。差分を出す。
	my $result = get_battle_result($user, $enemy);
	# 自分のユーザ名、敵のユーザ名、勝者のユーザ名、差分をプリントする
	print_result($result);
}

#自分のユーザ情報をとってきて返す
sub get_user {
	my ($user_id) = @_;
	return get_user_object($user_id);
}

#敵のユーザ情報をとってきて返す
sub get_enemy {
	my ($enemy_id) = @_;
	return get_user_object($enemy_id);
}

#ユーザIDをUserに渡して、ユーザ名、オフェンス、ディフェンスを取ってくる
sub get_user_object {
	my ($user_id) = @_;
	return User->build($user_id);
	#オフェンスとディフェンスでsumを作って追加する
	# $user_object->get_param_sum;
}

sub get_enemy_user_id {
	#いずれはここをランダムにする
	#とりあえず2を返す
	my $enemy_id = 2;
	return $enemy_id;
}

#バトル結果をハッシュにまとめて返す
sub get_battle_result {
	my ($user, $enemy) = @_;
	#自分と敵のuser_name,winner,diffをハッシュにして返す
	return +{
		title  => $user->user_name . " vs " . $enemy->user_name,
		winner => get_battle_winner($user, $enemy),
		diff   => get_battle_diff($user, $enemy)
	};
}

sub get_battle_winner {
	my ($user, $enemy) = @_;
	#sumの情報を取り出してきて,sumが大きかった方のユーザ名をwinnerとする
	return ($user->get_param_sum > $enemy->get_param_sum) ? $user->user_name : $enemy->user_name;
}

sub get_battle_diff {
	my ($user, $enemy) = @_;
	return abs($user->get_param_sum - $enemy->get_param_sum);
	#2者のsumの差分をdiffとする
}

sub print_result {
	my ($result) = @_;
	print Dumper($result);
	#resultを受け取って、下記の形に並べてプリントする
	#"自分ユーザ名"　vs "敵ユーザ名"
	#Winner：”敵ユーザ名”
	#diff：sumの差分
}

1;