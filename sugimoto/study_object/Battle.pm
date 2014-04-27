package Battle;
use strict;
use User;
use Data::Dumper;

# my $object = User->build(4);

use Class::Accessor::Lite (
    new => 1,
    ro  => [
        qw/
        	user
        	enemy
          /
    ],
    rw  => [
    	qw/
    		result
     	 /
    ],
);

#外からの呼び出しを受けて、バトルをビルドする
sub build {
	my ($class, $user_id) = @_;
	#ユーザIDが渡ってきてなかったら死ぬ
	die "no user_id! \n" unless ($user_id > 0);
	#ユーザIDからユーザ情報を作成する（User.pmを使う）
	my $battle = _main($class, $user_id);

#-------------------------------------------------
# ここをmainに切り出した意図は？
# buildは「必要な情報を集めてきてオブジェクト化する」って機能じゃから
# そうとうややこしくならん限りはこの中にかいて大丈夫
#-------------------------------------------------

	return $class->new($battle);
}

sub _main {
	my ($class, $user_id) = @_;
	my $user = _get_user($user_id);
	# get_enemy_idで敵を抽選する（とりあえずは2で決め打ちでつくる）
	# ↑で取得した敵ユーザIDをもとに、敵のユーザ情報を作る（オフェンスとディフェンスも足しとく）	
	my $enemy = _get_enemy(_get_enemy_id());
	# sumを比べてバトルさせる。差分を出す。
	return +{
		user   => $user,
		enemy  => $enemy,
		result => undef
	};
}

#自分のユーザ情報をとってきて返す
sub _get_user {
	my ($user_id) = @_;
	return _get_user_object($user_id);
}

#敵のユーザ情報をとってきて返す
sub _get_enemy {
	my ($enemy_id) = @_;
	return _get_user_object($enemy_id);
}

#ユーザIDをUserに渡して、ユーザ名、オフェンス、ディフェンスを取ってくる
sub _get_user_object {
	my ($user_id) = @_;
	return User->build($user_id);
}

sub _get_enemy_id {
	#いずれはここをランダムにする
	#とりあえず2を返す
	my $enemy_id = 2;
	return $enemy_id;
}

#----------ここまでがclassメソッド（ビルドのときに必要なもの）--------------

#バトル結果をハッシュにまとめて返す
sub get_battle_result {
	my ($self) = @_;
	#自分と敵のuser_name,winner,diffをハッシュにして返す
	my $result = +{
		user_name  => $self->user->user_name,
		enemy_name => $self->enemy->user_name,
		title      => $self->user->user_name . " vs " . $self->enemy->user_name,
		winner     => $self->_get_battle_winner,
		diff       => $self->_get_battle_diff
	};
	#結果を自身に保存
	$self->result($result);
	#呼び出してきたところに返す
	return $result;
}

sub _get_battle_winner {
	my ($self) = @_;
	#sumの情報を取り出してきて,sumが大きかった方のユーザ名をwinnerとする
	return ($self->user->get_param_sum > $self->enemy->get_param_sum) ? $self->user->user_name : $self->enemy->user_name;
}

sub _get_battle_diff {
	my ($self) = @_;
	return abs($self->user->get_param_sum - $self->enemy->get_param_sum);
	#2者のsumの差分をdiffとする
}

sub get_user_and_enemy_param_sum{
	my ($self) = @_;
	return +{
		#ユーザ名と、そのユーザのoffence+defenseの合計をハッシュにして返す
		user => $self->user->user_name . " : " . $self->user->get_param_sum,
		enemy => $self->enemy->user_name . " : " . $self->enemy->get_param_sum
	}
}







1;