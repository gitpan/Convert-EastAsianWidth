#!/usr/bin/perl
# $File: //member/autrijus/Convert-EastAsianWidth/t/1-basic.t $ $Author: autrijus $
# $Revision: #1 $ $Change: 3694 $ $DateTime: 2003/01/20 12:40:36 $

use utf8;
use strict;
use Test;

BEGIN { plan tests => 3 }

require Convert::EastAsianWidth;
ok($Convert::EastAsianWidth::VERSION) if $Convert::EastAsianWidth::VERSION or 1;

ok(
    Convert::EastAsianWidth::to_fullwidth('相對論：E = M(C**2)'),
    '相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）',
);

ok(
    Convert::EastAsianWidth::to_halfwidth('相對論：Ｅ　＝　Ｍ（Ｃ＊＊２）'),
    '相對論:E = M(C**2)',
);
