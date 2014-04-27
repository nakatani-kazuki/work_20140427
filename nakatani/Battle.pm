package Battle;
use strict;
use User;

main();

sub main {
    my $aaa = User->build();

use Data::Dumper;
print('#######################################################');
print Dumper($aaa);
print('#######################################################');

}

1;