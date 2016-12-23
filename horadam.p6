#!/usr/bin/env perl6



sub MAIN( Int $nth, Int $p = 0, Int $q = 1, Rat $r = .25, Rat $s = .75 ) {
    my @horadam = $p, $q, {$^n1 × $r + $^n2 × $s} … ∞;
    say @horadam[^$nth];
}
