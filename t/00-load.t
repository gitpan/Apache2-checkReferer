#!perl -T

use Test::More tests => 1;

BEGIN {
	use_ok( 'Apache2::checkReferer' );
}

diag( "Testing Apache2::checkReferer $Apache2::checkReferer::VERSION, Perl $], $^X" );
