# $File: //member/autrijus/Convert-EastAsianWidth/Makefile.PL $ $Author: autrijus $
# $Revision: #1 $ $Change: 3694 $ $DateTime: 2003/01/20 12:40:36 $

use ExtUtils::MakeMaker;

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Convert between full- and half-width characters',
    NAME		=> 'Convert::EastAsianWidth',
    VERSION_FROM	=> 'EastAsianWidth.pm',
    PREREQ_PM		=> {
	'Unicode::EastAsianWidth' => '0',
    }
);
 
1;
