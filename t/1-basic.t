#!/usr/bin/perl
# $File: //member/autrijus/Convert-EastAsianWidth/t/1-basic.t $ $Author: autrijus $
# $Revision: #2 $ $Change: 4931 $ $DateTime: 2003/03/25 16:42:43 $

use utf8;
use strict;
use Test;

BEGIN { plan tests => 3 }

use Convert::EastAsianWidth;
ok($Convert::EastAsianWidth::VERSION) if $Convert::EastAsianWidth::VERSION or 1;

ok(
    to_fullwidth('相對論：E = M(C**2)'),
    '相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）',
);

ok(
    to_halfwidth('相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）'),
    '相對論:E = M(C**2)',
);
