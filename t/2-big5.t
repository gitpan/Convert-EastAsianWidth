#!/usr/bin/perl
# $File: //member/autrijus/Convert-EastAsianWidth/t/2-big5.t $ $Author: autrijus $
# $Revision: #2 $ $Change: 4931 $ $DateTime: 2003/03/25 16:42:43 $

use strict;
use Test;

BEGIN {
    eval { require Encode::compat } if $] < 5.007;
    eval { require Encode } or do {
	plan tests => 0;
	exit;
    };
    plan tests => 3;
}

use Convert::EastAsianWidth;
ok($Convert::EastAsianWidth::VERSION) if $Convert::EastAsianWidth::VERSION or 1;

ok(
    to_fullwidth('相對論：E = M(C**2)', 'big5'),
    '相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）',
);

ok(
    to_halfwidth('相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）', 'big5'),
    '相對論:E = M(C**2)',
);
