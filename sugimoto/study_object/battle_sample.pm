package Battle;
use strict;
use User;
use Data::Dumper;

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

=pod
インスタンスメソッド
    my ($self) = @_;
    とかで始まる関数
    $selfに保存してある情報を利用して処理をする

クラスメソッド
    my ($class, $hoge, $fuga) = @_;
    とかで始まる関数
    渡された値を元に処理をする

=cut

sub build {
    my ($class, $user_id) = @_;

    my $user  = get_user($user_id);
    my $enemy = get_enemy(get_enemy_id());

    my $attrs = +{
        user   => $user,
        enemy  => $enemy,
        result => undef,
    };

    return $class->new($attrs);
}

sub exec_battle {
    my ($self) = @_; # 引数を必要としない、ビルドした時に「自分」に保存された情報を使う

    my $result = +{
        user_name  => $self->user->user_name,
        enemy_name => $self->enemy->user_name,
        title      => $self->user->user_name . " vs " . $self->enemy->user_name,
        winner     => get_battle_winner($self->user, $self->enemy), # クラスメソッドの実装例
        winner     => $self->get_battle_winner, # インスタンスメソッドの実装例
        diff       => $self->get_battle_diff
    };

    # 結果を保存
    $self->result($result);
}

sub dump_result {
    my ($self) = @_;
    print Dumper($self->result);
}

sub get_user {
    my ($user_id) = @_;
    return get_user_object($user_id);
}

sub get_enemy {
    my ($enemy_id) = @_;
    return get_user_object($enemy_id);
}

sub get_user_object {
    my ($user_id) = @_;
    return User->build($user_id);
}

sub get_enemy_id {
    my $enemy_id = 2;
    return $enemy_id;
}

sub get_battle_winner {
    my ($self) = @_;
    #sumの情報を取り出してきて,sumが大きかった方のユーザ名をwinnerとする
    return ($self->user->get_param_sum > $self->enemy->get_param_sum) ? $user->user_name : $enemy->user_name;
}

sub get_battle_diff {
    my ($self) = @_;
    return abs($self->user->get_param_sum - $self->enemy->get_param_sum);
    #2者のsumの差分をdiffとする
}

1;