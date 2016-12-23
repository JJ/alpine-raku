#!/usr/bin/env perl6

sub horadam ( Int $nth, Rat $r, Rat $s ) {
    given $nth {
	when 0 { 0 }
	when 1 { 1 }
	default { $r*horadam( $nth-1, $r, $s) + $s*horadam($nth-2,$r,$s) }
    }
}

sub MAIN( Int $n, Rat $r = 0.25, Rat $s = 0.75 ) {
    say horadam( $n, $r, $s);
}
