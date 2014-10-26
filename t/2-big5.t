#!/usr/bin/perl
# $File: //member/autrijus/Convert-EastAsianWidth/t/2-big5.t $ $Author: autrijus $
# $Revision: #1 $ $Change: 3694 $ $DateTime: 2003/01/20 12:40:36 $

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

require Convert::EastAsianWidth;
ok($Convert::EastAsianWidth::VERSION) if $Convert::EastAsianWidth::VERSION or 1;

ok(
    Convert::EastAsianWidth::to_fullwidth('�۹�סGE = M(C**2)', 'big5'),
    '�۹�סG�ӡ@�ס@�ۡ]�ѡ������^',
);

ok(
    Convert::EastAsianWidth::to_halfwidth('�۹�סG�ӡ@�ס@�ۡ]�ѡ������^', 'big5'),
    '�۹��:E = M(C**2)',
);
