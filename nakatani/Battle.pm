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

# diff for branch test

}

1;