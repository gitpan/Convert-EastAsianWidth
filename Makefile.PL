# $File: //member/autrijus/Convert-EastAsianWidth/Makefile.PL $ $Author: autrijus $
# $Revision: #2 $ $Change: 4931 $ $DateTime: 2003/03/25 16:42:43 $

use inc::Module::Install;

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Convert between full- and half-width characters',
    NAME		=> 'Convert::EastAsianWidth',
    VERSION_FROM	=> 'EastAsianWidth.pm',
    PREREQ_PM		=> {
	'Unicode::EastAsianWidth' => '0',
    }
);

&AutoInstall->write;
&Meta->write;
 
1;
