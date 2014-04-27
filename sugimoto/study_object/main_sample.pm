# 例えば

# バトル実行
sub exec_battle {
    # バトルをビルドする
    my $battle = Battle->build($user_id);

    # バトルを実行
    my $result = $battle->exec_battle;

    # 結果を表示
    dump_content($result);
}

# バトル実行(例２)
sub exec_battle {
    # バトルをビルドする
    my $battle = Battle->build($user_id);

    # バトルを実行
    my $result = $battle->exec_battle;

    # 結果を表示
    $battle->dump_result
}


# 敵情報表示
sub enemy_info {
    # バトルをビルド
    my $battle = Battle->build($user_id);

    # 敵の情報を取得
    my $enemy_info = $battle->get_enemy_info;

    # dump
    dump_content($enemy_info);
}

# 自分の情報表示
sub my_info {
    # バトルをビルド
    my $battle = Battle->build($user_id);

    # 自分の情報を取得
    my $my_info = $battle->get_my_info;

    # dump
    dump_content($my_info);
}


sub dump_content {
    my ($cntent) = @_;
    print Dumper($content);
}
