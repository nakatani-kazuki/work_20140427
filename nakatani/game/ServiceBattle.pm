package ServiceBattle;
use strict;
use Data::Dumper;
use Human;
use RedRanger;

use Class::Accessor::Lite (
    new => 1,
    rw  => [
        qw/
          player_1
          player_2
          first_attacker
          second_attacker
          winner
          result
          /
    ],
);

my @PLAYER_CHARACTORS = qw/
    Human
    RedRanger
/;

my @PRINT_STATUS = qw/
    name
    hp
    attack
    defense
    speed
/;

#-------------------------
# class methods
#-------------------------
sub build {
    my ($class) = @_;
    return $class->new(+{
        player_1        => $class->build_player_randomly,
        player_2        => $class->build_player_randomly,
        first_attacker  => undef,
        second_attacker => undef,
        winner          => undef,
        result          => undef,
    });
}

sub build_player_randomly {
    my ($class) = @_;
    my $class = @PLAYER_CHARACTORS[ int(rand( $#PLAYER_CHARACTORS + 1))];
    return $class->build;
}

#-------------------------
# instance methods
#-------------------------

sub exec_battle {
    my ($self) = @_;

    $self->print_battle_start;

    $self->get_battle_result;
}

sub print_battle_start {
    my ($self) = @_;
    $self->player_1->print_status(\@PRINT_STATUS);
    $self->player_2->print_status(\@PRINT_STATUS);
}

sub print_battle_end{
    my ($self) = @_;
    print "\n\n**** " . $self->winner->name . "の勝利！ **** \n\n";
    print $self->winner->{last_serif} . "\n\n";
}

sub get_battle_result {
    my ($self) = @_;

    # 先攻、後攻を決定
    $self->decide_attacking_order;

    while ($self->is_both_alive) {

        # 先攻の攻撃
        my $ret1 = $self->first_attack;
        last if ($ret1 && $ret1->{battle_over});

        # 後攻の攻撃
        my $ret2 = $self->second_attack;
        last if ($ret2 && $ret2->{battle_over});
    }
}

sub decide_attacking_order {
    my ($self) = @_;

    # speedの早いほうが先攻、同値の場合はplayer_1を優先する
    my ($first_attacker, $second_attacker) =
      ($self->player_1->speed >= $self->player_2->speed) ?
        ($self->player_1, $self->player_2) : ($self->player_2 , $self->player_1);

    $self->first_attacker($first_attacker);
    $self->second_attacker($second_attacker);
}

sub is_both_alive {
    my ($self) = @_;
    return $self->first_attacker->hp > 0 && $self->second_attacker->hp > 0;
}

sub first_attack {
    my ($self) = @_;
    return $self->attack($self->first_attacker, $self->second_attacker);
}

sub second_attack {
    my ($self) = @_;
    return $self->attack($self->second_attacker, $self->first_attacker);
}

sub attack {
    my ($self, $attacker, $defender) = @_;

    my $damage = $attacker->attack - $defender->defense;

    # defenseが上回る場合は1ダメージ固定にする
    $damage = 1 if ($damage <= 0);

    # damageを与える(0未満にはならない)
    my $hp = ($defender->hp - $damage) > 0 ? ($defender->hp - $damage) : 0;
    $defender->hp($hp);

    # 結果を出力
    _print_attack_result(+{
        attacker_name => $attacker->name,
        defender_name => $defender->name,
        attack_serif  => $attacker->attack_serif,
        damage        => $damage,
        hp            => $defender->hp
      });

    # どちらかのhpが0になったら終了
    if ($defender->hp == 0) {
        $self->winner($attacker);
        $self->print_battle_end;
        return +{ battle_over => 1 };
    }
}

sub _print_attack_result {
    my ($attack_result) = @_;
    print 
    "------------------------- \n" .
    "$attack_result->{attacker_name}" . " -> " . "$attack_result->{defender_name}" . " への攻撃! \n" .
    "「 $attack_result->{attack_serif} 」 \n" .
    "$attack_result->{defender_name} " . "に" . "$attack_result->{damage}" . "のダメージ！ \n" .
    "残りHP" . "$attack_result->{hp} \n";
}

1;