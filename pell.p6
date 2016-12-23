#!/usr/bin/env perl6

sub MAIN( Int $nth! ) {
    my @pell = 1,2,* + * * 2  ... *;
    say @pell[$nth];
}
