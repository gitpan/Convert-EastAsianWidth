# $File: //member/autrijus/Convert-EastAsianWidth/EastAsianWidth.pm $ $Author: autrijus $
# $Revision: #1 $ $Change: 3694 $ $DateTime: 2003/01/20 12:40:36 $

package Convert::EastAsianWidth;
$Convert::EastAsianWidth::VERSION = '0.01';

use 5.006;
use strict;
use base 'Exporter';

{
    # work wround perlbug (or misfeature?)
    package main;
    BEGIN { $Unicode::EastAsianWidth::EastAsian = 1 }
    use Unicode::EastAsianWidth;
}

=head1 NAME

Convert::EastAsianWidth - Convert between full- and half-width characters

=head1 VERSION

This document describes version 0.01 of Convert:EastAsianWidth,
relased January 20, 2003.

=head1 SYNOPSIS

    # Exports to_fullwidth() and to_halfwidth() by default
    use Convert::EastAsianWidth;

    my $u = to_fullwidth('ABC');	    # Full-width variant of 'ABC'
    my $b = to_fullwidth('ABC', 'big5');    # Ditto, but in big5 encoding
    my $x = to_halfwidth($u);		    # Gets back 'ABC'
    my $y = to_halfwidth($b, 'big5');	    # Save as above

=head1 DESCRIPTION

This module uses the regular expression properties provided by
B<Unicode::EastAsianWidth> to efficiently convert between full-
and half-width characters.

The first argument is the string to be converted; the second one
represents the input and encodings (if omitted, both are assumed
by to Unicode strings.)

In Perl versions before 5.8, B<Encode::compat> is required for
the encoding conversion function to work.

=cut

sub to_fullwidth {
    my $text;
    my $enc  = $_[1];

    if ($enc) {
	require Encode::compat if $] < 5.007;
	require Encode;
	$text = Encode::decode($enc => $_[0]);
    }
    else {
	$text = $_[0];
    }

    require charnames;
    my ($full, $name);
    $text =~ s{(\p{InHalfwidth})}{
	($name = charnames::viacode(ord($1))) && (
	    $full = charnames::vianame( "FULLWIDTH $name" ) ||
		    charnames::vianame( "IDEOGRAPHIC $name" )
	) ? chr($full) : $1
    }eg;

    return ( $enc ? Encode::encode($enc => $text) : $text );
}

sub to_halfwidth {
    my $text;
    my $enc = $_[1];

    if ($enc) {
	require Encode::compat if $] < 5.007;
	require Encode;
	$text = Encode::decode($enc => $_[0]);
    }
    else {
	$text = $_[0];
    }

    require charnames;
    my ($name);
    $text =~ s{(\p{InHalfwidthAndFullwidthForms}|\p{InCJKSymbolsAndPunctuation})}{
	$name = charnames::viacode(ord($1));
	(substr($name, 0, 10) eq 'FULLWIDTH ')
	    ? chr(charnames::vianame(substr($name, 10)))
	: (substr($name, 0, 12) eq 'IDEOGRAPHIC ')
	    ? chr(charnames::vianame(substr($name, 12)))
	: $1;
    }eg;

    return ( $enc ? Encode::encode($enc => $text) : $text );
}
1;

__END__

=head1 SEE ALSO

L<Unicode::EastAsianWidth>, L<charnames>

L<Encode>, L<Encode::compat>

=head1 AUTHORS

Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>

=head1 COPYRIGHT

Copyright 2003 by Autrijus Tang E<lt>autrijus@autrijus.orgE<gt>.

This program is free software; you can redistribute it and/or modify it
under the same terms as Perl itself.

See L<http://www.perl.com/perl/misc/Artistic.html>

=cut
