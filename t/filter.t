use Test::More;

use lib qw(./t/lib);
use Data::RuledValidator (plugin =>[qw/Japanese/], filter => [qw/Japanese/]);
use Data::Dumper;
use strict;
use File::Copy ();

sub init{
  my $q = shift;
  %$q = (page => "a", zen => "  ＡＢＣ  ", han => "ｱｲｳｴｵ");
  bless $q, 'main';
}

my $q = {};
init($q);
sub p{my($self, $k, $v) = @_; return @_ == 3 ? $self->{$k} = $v : @_ == 2 ? $self->{$k} : keys %$self}

my $v = Data::RuledValidator->new
  (
   obj    => $q             ,
   method => 'p'            ,
   rule   => "t/filter.rule",
   filter_replace => 1      ,
  );

ok(ref $v, 'Data::RuledValidator');
is($v->rule, "t/filter.rule");

# a
init($q);
is($q->p('zen'), '  ＡＢＣ  ', "a-i");
is($q->p('han'), 'ｱｲｳｴｵ', "a-n");
is($q->p('page'), 'a');
ok($v->by_rule->valid);
ok($v->valid);
is($q->p('zen'), 'ABC', "a-i");
is($q->p('han'), 'アイウエオ', "a-n");


done_testing;
