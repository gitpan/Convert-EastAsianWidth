# $File: //depot/cpan/Module-Install/lib/Module/Install/MakeMaker.pm $ $Author: autrijus $
# $Revision: #7 $ $Change: 1375 $ $DateTime: 2003/03/18 12:29:32 $ vim: expandtab shiftwidth=4

package Module::Install::MakeMaker;
use Module::Install::Base; @ISA = qw(Module::Install::Base);

$VERSION = '0.01';

use ExtUtils::MakeMaker ();

my $makefile;
sub WriteMakefile {
    my ($self, %args) = @_;
    $makefile = $self->load('Makefile');

    foreach my $key (qw(name version version_from abstract author)) {
        my $value = delete($args{uc($key)}) or next;
        $self->$key($value);
    }

    if (my $prereq = delete($args{PREREQ_PM})) {
        $self->requires($_ => $prereq->{$_}) for keys %$prereq;
    }

    # put the remaining args to makemaker_args
    $self->makemaker_args(%args);
}

END {
    $makefile->write if $makefile;
}

1;
