package Main;
use Battle;
use strict;
use Data::Dumper;

my $USER_ID = 1;
my $battle = main($user_id);
my $result = $battle->get_battle_result();

#ユーザIDをBattleに渡して結果を受け取る
#敵はBattle.pmの中で抽選されるのでユーザIDのみ渡せばよい
sub main {
	my ($user_id) = @_;
	return Battle->build($user_id);
}

print Dumper($result);
print Dumper($battle->get_user_and_enemy_param_sum());


=pod

main関数は
・バトルのビルド
・バトルの実行
・結果の表示

をひと通りやる関数としてつくるイメージ
名前をexec_battleに変えよう

このあと
enemy_info
user_info
の関数も使う

このモジュールに書く関数は
ゲームの1機能(1ページ)と1対1で紐づくイメージ

バトル実行ボタンを押した時に
exec_battle
が呼ばれてflaとか流して結果画面を表示
とか

敵情報ページのリンクを踏んだら敵の情報が表示されるページに遷移するとか

sub exec_battle {
	# バトルをビルド

	# バトルを実行

	# バトルの結果を表示(今回はDumpでOK)

}

sub enemy_info {
	# バトルをビルド

	# 敵情報を取得

	# 取得した情報をdump

}

本来は他から呼ばれるが、今回はこのモジュールの中で各関数を実行する
exec_battle();
とか
enemy_info();
と書いて実行するとバトルが実行されたり、敵情報が表示されたりする。


=cut

1;