package Battle;
use strict;
use Data::Dumper;

# 使うキャラクターを読み込む
use Human;
use RedRanger;

#ランダムでクラスを取得する方法

#配列の中に登場しうるクラス名を書いておく
my @chara = qw/
	Human
	RedRanger
	/;

#★この書き方もっとスマートなのあるだろうか
my @PRINT_STATUS = ("name", "hp", "attack", "defense", "speed");

#クラスを、↑の配列の中からランダムで抽選する
my $class1 = @chara[ int(rand( $#chara + 1))];
my $class2 = @chara[ int(rand( $#chara + 1))];

#抽選されたクラスのビルド機能を使う
my $player1 = $class1->build();
my $player2 = $class2->build();

# --------------ここまでが下準備＆設定-------------------

#バトル実行
_main();

_exec_battle();

sub _main {
	#表示したいステータスを渡してプリント
	_print_battle_start( \@PRINT_STATUS );
	#実際にバトルを行う
#	my $winner = _exec_battle();
#	_print_battle_end($winner);
}


# ステータスを表示させる(ユーザの持ってるprint機能を呼び出す）
 sub _print_battle_start {
#$statusを配列で受け取ってplayerオブジェクトのprint機能を呼び出す
	my ($print_status) = @_;
	$player1->print_status($print_status);
	$player2->print_status($print_status);	
}

sub _exec_battle{
	#プレイヤーに「カレントHP」という一時的なHPを作る。ここをバトルで上書きしていく。
	$player1->{current_hp} = $player1->get_status("hp");
	$player2->{current_hp} = $player2->get_status("hp");	

	#スピードの早い方を最初のアタッカーにする
	my $attacker =  _get_first_atacker($player1, $player2);
 	my $defender = ($attacker == $player1) ? $player2 : $player1;
# 　　AorBのカレントHPが0以上の間、ループさせる。2回め以降はループの中で、「前と違うほう」を攻撃者にする
	while ( $attacker->{current_hp} > 0 && $defender->{current_hp} > 0){
		#スピードの遅い方は最初はディフェンダー

 		#一発ずつ攻撃。攻撃の結果が出力される。
 		_attack($attacker, $defender);
 		$attacker = ($attacker == $player1) ? $player2 : $player1;
 		$defender = ($attacker == $player1) ? $player2 : $player1;
 	 }
}

sub _attack{
	my ($attacker, $defender) = @_;
	if ($attacker->{attack} >= $defender->{defense}){
		$defender->{current_hp} -= ($attacker->{attack} - $defender->{defense});
		my $attack_result = +{
			attacker_name => $attacker->{name},
			defender_name => $defender->{name},
			attack_serif => $attacker->{attack_serif},
			damage => $attacker->{attack} - $defender->{defense},
			current_hp => $defender->{current_hp}
		};
		print Dumper($attack_result);
#		_print_attack_result($attack_result);
	} else {
		print "ミス！ダメージを与えられない！！\n";
#		_attack_failure($attacker, $defender);
	}
}

=pod
2 
　　攻撃を行う　⇒　攻撃で受けたダメージをカレントHPから削る
　　1撃のたびにバトル結果をプリント

  どちらかが0を切ったら終了し、勝者のIDを返す

勝者のIDを受けて勝利セリフをプリントする

攻撃
　　自分のattack - 相手のdefenseの差分をダメージとしてhpから削り、返す
　　　－相手のdefenceが自分のattackを上回ってない場合のみ実行
=cut

#スピードの早い方のプレイヤーを先攻とする
sub _get_first_atacker{
	my ($player1, $player2) = @_;
	my $player1_speed = $player1->get_status("speed");
	my $player2_speed = $player2->get_status("speed");
	return ($player1_speed >= $player2_speed) ? $player1 : $player2 ;
}
