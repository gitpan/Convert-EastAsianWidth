package Convert::EastAsianWidth;
$Convert::EastAsianWidth::VERSION = '0.10';

use 5.008;
use strict;
use Exporter;
our @ISA = 'Exporter';
our @EXPORT = qw(to_fullwidth to_halfwidth);

{
    # work around perlbug (or misfeature?)
    package main;
    BEGIN { $Unicode::EastAsianWidth::EastAsian = 1 }
    use Unicode::EastAsianWidth;
}
use Unicode::EastAsianWidth; # must do that again for 5.8.1

sub to_fullwidth {
    my $text;
    my $enc  = $_[1];

    if ($enc) {
	require Encode;
	$text = Encode::decode($enc => $_[0]);
    }
    else {
	$text = $_[0];
    }

    require charnames;
    my ($full, $name);
    $text =~ s{(\p{InHalfwidth})}{
	my $char = $1;
	($name = charnames::viacode(ord($char))) && (
	    $full = charnames::vianame( "FULLWIDTH $name" ) ||
		    charnames::vianame( "IDEOGRAPHIC $name" )
	) ? chr($full) : $char;
    }eg;

    return ( $enc ? Encode::encode($enc => $text) : $text );
}

sub to_halfwidth {
    my $text;
    my $enc = $_[1];

    if ($enc) {
	require Encode;
	$text = Encode::decode($enc => $_[0]);
    }
    else {
	$text = $_[0];
    }

    require charnames;
    my ($name);
    $text =~ s{(\p{InHalfwidthAndFullwidthForms}|\p{InCJKSymbolsAndPunctuation})}{
	my $char = $1;
	$name = charnames::viacode(ord($char));
	(substr($name, 0, 10) eq 'FULLWIDTH ')
	    ? chr(charnames::vianame(substr($name, 10)))
	: (substr($name, 0, 12) eq 'IDEOGRAPHIC ')
	    ? chr(charnames::vianame(substr($name, 12)))
	: $char;
    }eg;

    return ( $enc ? Encode::encode($enc => $text) : $text );
}
1;

__END__

=head1 NAME

Convert::EastAsianWidth - Convert between full- and half-width characters

=head1 VERSION

This document describes version 0.10 of Convert:EastAsianWidth,
released October 16, 2007.

=head1 SYNOPSIS

    # Exports to_fullwidth() and to_halfwidth() by default
    use Convert::EastAsianWidth;

    my $u = to_fullwidth('ABC');	    # Full-width variant of 'ABC'
    my $b = to_fullwidth('ABC', 'big5');    # Ditto, but in big5 encoding
    my $x = to_halfwidth($u);		    # Gets back 'ABC'
    my $y = to_halfwidth($b, 'big5');	    # Same as above

=head1 DESCRIPTION

This module uses the regular expression properties provided by
B<Unicode::EastAsianWidth> to efficiently convert between full-
and half-width characters.

The first argument is the string to be converted; the second one
represents the input and encodings.  If omitted, both are assumed
by to Unicode strings.

=head1 SEE ALSO

L<Unicode::EastAsianWidth>, L<charnames>, L<Encode>

=head1 AUTHORS

Audrey Tang E<lt>cpan@audreyt.orgE<gt>

=head1 COPYRIGHT

Copyright 2003, 2007 by Audrey Tang E<lt>cpan@audreyt.orgE<gt>.

This software is released under the MIT license cited below.

=head2 The "MIT" License

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

=cut
