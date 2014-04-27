オブジェクトは例えば「オーブンレンジ」みたいなもの

オーブンレンジは以下の機能で出来ている
・オーブン
	予熱あり、予熱なし
	◯度で焼く
	◯分焼く
・レンジ
	何ワットか
	何分レンジにかけるか

でもレンジは中に何かを入れるまでは料理はできない
例えばパンを焼くにはパンを入れる必要がある

# オーブンレンジにパンを入れる
my $oven_with_bread = Oven->build(+{material => $bread});

# 3分焼くとトーストができる
my $minute = 3;
my $toast = $oven_with_bread->toast($minute);

この時レンジの機能は
$oven_with_bread
にはあるが、使われていない

# オーブンレンジに牛乳を入れる
my $oven_with_milk = Oven->build(+{material => $milk});

# 3分レンジにかけるとホットミルクができる
my $minute = 3;
my $hot_milk = $oven_with_bread->microwave($minute);

とか
