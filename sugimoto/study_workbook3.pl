#!/usr/local/bin/perl
use strict;
use Data::Dumper;

my @user_ids = (1,2,3);
my @user_names = ('user_1','user_2','user_3');
my @user_offense_params = (200,190,30);
my @user_defense_params = (20,120,230);



# ↑のデータを元にoffenceとdefenseで1vs1バトルを全ての組み合わせて行い、
# そのバトル結果を以下の形式で出力してください。
# diffはパラメを比較した際にどれだけの差分があったかを勝者側から見た値

# user_1 vs user_2
# winner : user_1
# diff : 30


#ユーザ一人一人を引っ張ってきてバトルをさせる
for my $user_id(@user_ids){
	exec_battle($user_id);
}

#勝敗の結果を表示する

sub exec_battle {
	my($user_id) = @_;
	#敵のリストを取得する
	my $battle_enemy_ids = battle_user_listing($user_id);
	#敵達とバトルさせて、勝敗結果とユーザIDを取得する
	my $battle_result = get_battle_result($user_id, $battle_enemy_ids);
	print Dumper(@$battle_result);
# 	勝敗の結果を渡す
}

#####途中…#####
# sub print_battle_result{
# 	my ($user_id, $battle_result) = @_;
# 	for my $battle_result_each_enemy(\@battle_result){
# 		print "@user_names[$user_id] " . "vs" . "%$battle_result_each_enemy-> {battle_enemy_id}:" 
# 	}
# }

sub battle_user_listing {
	my ($my_user_id) = @_;
	my @battle_enemy_ids;
	foreach my $battle_enemy_id(@user_ids){
		unless ($battle_enemy_id == $my_user_id) {
			push (@battle_enemy_ids , $battle_enemy_id);
		}
	}
	return \@battle_enemy_ids;
}

sub get_battle_result {
	my ($user_id, $battle_enemy_ids) = @_;
	my $my_user_offense_defence_sum = get_defence_offense_sum_by_id($user_id);
	my @results;
	for my $battle_enemy_id (@$battle_enemy_ids){
		my $battle_enemy_offense_defence_sum = get_defence_offense_sum_by_id($battle_enemy_id);
		# 勝敗判定
		my $is_win = ($my_user_offense_defence_sum >= $battle_enemy_offense_defence_sum) ? 1 : 0;
		# 結果のハッシュを配列に詰める
		push (@results, +{ is_win => $is_win, battle_enemy_id => $battle_enemy_id });

	}
	return \@results;
}

#　ユーザIDからその人のoffenseとdefenseを引っ張ってきて合計し、返す
sub get_defence_offense_sum_by_id {
	my ($user_id) = @_;	
	my $user_offense_defence_sum = $user_offense_params[ $user_id ] + $user_defense_params[ $user_id ];
	return $user_offense_defence_sum;
}


