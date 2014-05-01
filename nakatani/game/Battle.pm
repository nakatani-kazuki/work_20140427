package Battle;
use strict;
use Data::Dumper;
use ServiceBattle;


#バトル実行
main();

sub main {
    my $service_battle = ServiceBattle->build;
    $service_battle->exec_battle;
}

1;