#!/usr/local/bin/perl

use strict;
use inc::Module::Install;

name        'Convert-EastAsianWidth';
all_from    'lib/Convert/EastAsianWidth.pm';
requires    'Unicode::EastAsianWidth';

auto_install;
auto_provides;

sign; WriteAll;

1;
