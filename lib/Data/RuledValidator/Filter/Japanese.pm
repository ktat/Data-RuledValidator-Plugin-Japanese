package Data::RuledValidator::Filter::Japanese;

use utf8;

use strict;
use warnings qw/all/;
use Encode;
use Data::RuledValidator::Util;
use Unicode::Japanese;

our $VERSION = 0.02;

sub h2z{
  my($self, $v) = @_;
  if(defined $$v){
    my $s = $$v;
    my $utf8 = utf8::is_utf8($$v) ? 1 : 0;
    $s = Encode::decode('utf8', $s)  if not $utf8;
    $s = Unicode::Japanese->new($s)->h2zKana->getu;
    $s = Encode::encode('utf8', $s) if not $utf8;
    $$v = $s;
  }
}

sub z2h_ascii{
  my($self, $v) = @_;
  if (defined $$v) {
    my $s = $$v;
    use utf8;
    my $utf8 = 1;
    if (not utf8::is_utf8($$v)) {
      $utf8 = 0;
      $s = Encode::decode('utf8', $$v);
    }
    $s =~ s/[\x{02D7}\x{2010}-\x{2012}\x{FE63}\x{FF0D}]/-/go;
    $s =~ tr/\x{FF01}-\x{FF5e}/\x21-\x7e/;
    $$v = Encode::encode('utf8', $s) if not $utf8 = 0;
  }
}

1;

=head1 Name

Data::RuledValidator::Filter - filters

=head2 h2z

=head2 z2h

hankaku kana -> zeknaku kana

=head2 z2h_ascii

zenkaku ascii -> hankaku ascii

=head1 Author

Ktat, E<lt>ktat@cpan.orgE<gt>

=head1 Copyright

Copyright 2006-2007 by Ktat

This program is free software; you can redistribute it
and/or modify it under the same terms as Perl itself.

See http://www.perl.com/perl/misc/Artistic.html

=cut
1;

