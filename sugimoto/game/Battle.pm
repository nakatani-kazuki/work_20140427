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

#バトル開始時に表示したいステータスを指定する。
#この書き方もっとスマートなのあるだろうか…
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

sub _main {
	#表示したいステータスを渡せば、バトル開始時に二人の名前とステータスが表示される
	_print_battle_start( \@PRINT_STATUS );
	#実際にバトルを行い、勝者を取得する
	my $winner = _exec_battle();
	#勝者の名前とセリフを表示してバトル終了
	_print_battle_end($winner);
}


# ステータスを表示させる(ユーザの持ってるprint機能を呼び出す）
 sub _print_battle_start {
#$statusを配列で受け取ってplayerオブジェクトのprint機能を呼び出す
	my ($print_status) = @_;
	$player1->print_status($print_status);
	$player2->print_status($print_status);	
}

sub _exec_battle{
	#プレイヤーのHPの値をコピって「カレントHP」を作りオブジェクトに持たせる。ここをバトルで上書きしていく。
	$player1->{current_hp} = $player1->get_status("hp");
	$player2->{current_hp} = $player2->get_status("hp");	

	#スピードの早い方を最初のアタッカーにする
	my $attacker =  _get_first_atacker($player1, $player2);
	#アタッカーじゃない方をディフェンダーにする
 	my $defender = ($attacker == $player1) ? $player2 : $player1;

	#AorBのカレントHPが0以上の間、ループさせる。2回め以降はループの中で、「前と違うほう」を攻撃者にする
	while ( $attacker->{current_hp} > 0 && $defender->{current_hp} > 0){
 		#アタッカー→ディフェンダーに一発攻撃
 		_attack($attacker, $defender);
 		#アタッカーとディフェンダーを入れ替える		
 		$attacker = ($attacker == $player1) ? $player2 : $player1;
 		$defender = ($attacker == $player1) ? $player2 : $player1;
 	 }
	#この時点でのディフェンダーが最後のアタッカー＝勝者なので、この人物を勝者として返す
 	 return $defender;
}

#アタッカー->ディフェンダーに一発攻撃して、攻撃結果をハッシュにして返す
sub _attack{
	my ($attacker, $defender) = @_;
	if ($attacker->{attack} >= $defender->{defense}){
		#アタッカーのattackがディフェンダーのdefenseを上回っている場合は、attack-defenseのぶんだけカレントHPを削る
		$defender->{current_hp} -= ($attacker->{attack} - $defender->{defense});
		#攻撃結果を返す
		my $attack_result = +{
			attacker_name => $attacker->{name},
			defender_name => $defender->{name},
			attack_serif => $attacker->{attack_serif},
			damage => $attacker->{attack} - $defender->{defense},
			current_hp => $defender->{current_hp}
		};
		# 攻撃結果を表示
		_print_attack_result($attack_result);

	} else {
		#アタッカーのattackがディフェンダーのdefenseを下回っている場合は、1だけカレントHPを削る
		$defender->{current_hp} -= 1;
		my $attack_result = +{
			attacker_name => $attacker->{name},
			defender_name => $defender->{name},
			attack_serif => $attacker->{attack_serif},
			damage => 1,
			current_hp => $defender->{current_hp}
		};
		# 攻撃結果を表示
		_print_attack_result($attack_result);
	}
}


#プレイヤー1と2のうち、スピードの早い方のプレイヤーを先攻とする
sub _get_first_atacker{
	my ($player1, $player2) = @_;
	my $player1_speed = $player1->get_status("speed");
	my $player2_speed = $player2->get_status("speed");
	#1と2が同じの場合は、1を先行とする
	return ($player1_speed >= $player2_speed) ? $player1 : $player2 ;
}

#attack_resultを受け取っていい感じに体裁を整える
sub _print_attack_result {
	my ($attack_result) = @_;
	print 
	"------------------------- \n" .
	"$attack_result->{attacker_name}" . " から " . "$attack_result->{defender_name}" . " への攻撃! \n" .
	"「 $attack_result->{attack_serif} 」 \n" .
	"$attack_result->{defender_name} " . "に" . "$attack_result->{damage}" . "のダメージ！ \n" .
	"残りHP" . "$attack_result->{current_hp} \n" .
	"------------------------- \n" ;
}

#バトル終了時に、勝者の名前とセリフをプリントする
sub _print_battle_end{
	my ($winner) = @_;
	print
	"****" . "$winner->{name}" . "の勝利！**** \n" .
	"$winner->{last_serif} \n" ;
}