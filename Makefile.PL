# $File: //member/autrijus/Convert-EastAsianWidth/Makefile.PL $ $Author: autrijus $
# $Revision: #4 $ $Change: 8320 $ $DateTime: 2003/10/02 23:47:56 $

use inc::Module::Install;

WriteMakefile(
    AUTHOR		=> 'Autrijus Tang (autrijus@autrijus.org)',
    ABSTRACT		=> 'Convert between full- and half-width characters',
    NAME		=> 'Convert::EastAsianWidth',
    VERSION_FROM	=> 'lib/Convert/EastAsianWidth.pm',
    PREREQ_PM		=> {
	'Unicode::EastAsianWidth' => '0',
    }
);

include('ExtUtils::AutoInstall');
&AutoInstall->write;
&Meta->write;
 
1;
