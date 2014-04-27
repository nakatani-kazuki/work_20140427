#!/usr/local/bin/perl
use strict;

my @user_ids = (1,2,3,4);
my @user_names = ('user_1','user_2','user_3','user_4');
my @user_offense_params = (200,190,30,50);
my @user_defense_params = (20,120,230,90);

# ↑のデータを元にoffenceとdefenseで1vs1バトルを全ての組み合わせて行い、
# そのバトル結果を以下の形式で出力してください。
# diffはパラメを比較した際にどれだけの差分があったかを勝者側から見た値

# user_1 vs user_2
# winner : user_1
# diff : 30


# 重複削除
# 複数か単数かが名前でわかるように
# 1回しか使わない場合は変数に受けない

my $all_results = +{};

main ();

sub main {
	for my $user_id (@user_ids) {
		my $user_info = get_user_info($user_id);
		my $enemy_list = get_enemy_list($user_id);

		my $results = exec_battles($user_info, $enemy_list);
		map { $all_results->{$_->{index}} = $_ } @$results;
	}
	print_results();
}

sub print_results {
	for my $result_index (sort keys %$all_results) {
		print_result($all_results->{$result_index});
	}
}

sub get_enemy_list {
	my ($user_id) = @_;
	my $enemy_ids = get_enemy_ids($user_id);
	my @enemy_list = map { get_user_info($_) } @$enemy_ids;
	return \@enemy_list;
}

sub get_enemy_ids {
	my ($user_id) = @_;
	my @enemy_ids = grep { $user_id != $_ } @user_ids;
	return \@enemy_ids;
}

sub get_user_info {
	my ($user_id) = @_;
	my $index = $user_id - 1;
	return +{
		user_id       => @user_ids[$index],
		user_name     => @user_names[$index],
		offense_param => @user_offense_params[$index],
		defense_param => @user_defense_params[$index],
	};
}

sub exec_battles {
	my ($user_info, $enemy_list) = @_;

	my @battle_results;
	for my $enemy (@$enemy_list) {
		push (@battle_results, exec_battle($user_info, $enemy));
	}
	return \@battle_results;
}

sub exec_battle {
	my ($user, $enemy) = @_;
	return +{
		# 引き分けはユーザの勝ち
		winner => get_winner($user, $enemy),
		diff   => get_diff($user, $enemy),
		title  => "$enemy->{user_name} vs $user->{user_name}",
		index  => get_index($user->{user_id}, $enemy->{user_id}),
	};
}

sub get_winner {
	my ($user, $enemy) = @_;
	my $user_param  = get_comparison_param($user);
	my $enemy_param = get_comparison_param($enemy);
	return ($user_param >= $enemy_param) ? $user->{user_name} : $enemy->{user_name};
}

sub get_diff {
	my ($user, $enemy) = @_;
	my $user_param  = get_comparison_param($user);
	my $enemy_param = get_comparison_param($enemy);
	return ($user_param >= $enemy_param) ? ($user_param - $enemy_param) : ($enemy_param - $user_param),
}

sub get_comparison_param {
	my ($user_info) = @_;
	return $user_info->{sum} = $user_info->{offense_param} + $user_info->{defense_param};
}

sub get_index {
	my ($user_id, $enemy_id) = @_;
	my $index = '';
	map { $index .= $_ } sort ($user_id, $enemy_id);
	return $index;
}

sub print_result {
	my ($result) = @_;
	print $result->{title} . "\n";
	print "winner : " . $result->{winner} . "\n";
	print "diff   : " . $result->{diff} . "\n\n";
}