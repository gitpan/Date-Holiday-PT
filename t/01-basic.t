# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl 1.t'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';

#use Test::More tests => 1;
use Test::More 'no_plan';
BEGIN { use_ok('Date::Holiday::PT') };

#########################

# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.

is(is_pt_holiday( 2000,  1,  1), 'Ano Novo');
is(is_pt_holiday( 2000,  2, 24), 'Entrudo');
is(is_pt_holiday( 2000,  4,  9), 'Sexta-Feira Santa');
is(is_pt_holiday( 2000,  4, 11), 'Páscoa');
is(is_pt_holiday( 2000,  4, 25), 'Dia da Liberdade');
is(is_pt_holiday( 2000,  5,  1), 'Dia do Trabalhador');
is(is_pt_holiday( 2004,  5, 12), undef);
#is(is_pt_holiday( 2000,  6, 10), 'Dia de Portugal');
is(is_pt_holiday( 2000,  6, 10), 'Corpo de Deus');
is(is_pt_holiday( 2000,  8, 15), 'Assunção da Virgem');
is(is_pt_holiday( 2000, 10,  5), 'Implantação da República');
is(is_pt_holiday( 2000, 11,  1), 'Festa de Todos-os-Santos');
is(is_pt_holiday( 2000, 12,  1), 'Restauração da Independência');
is(is_pt_holiday( 2000, 12,  8), 'Imaculada Conceição');
is(is_pt_holiday( 2000, 12, 25), 'Natal');

is(is_pt_public_holiday(2001, 2,24), 'Entrudo');
is(is_pt_public_holiday(2001, 2,23), undef);

my $feriado_local_de_pombal_e_torres_vedras = is_pt_local_holiday(2002,11,11);
is($$feriado_local_de_pombal_e_torres_vedras[0],'Pombal');
is($$feriado_local_de_pombal_e_torres_vedras[1],'Torres Vedras');
is(@$feriado_local_de_pombal_e_torres_vedras,2);
is(is_pt_local_holiday(2002,12,12),undef);
is(is_pt_local_holiday(4002,14,33),undef);

ok(is_pt_some_holiday(2004,1,1));

is(is_pt_local_holiday_in('Aveiro',2004,5,12),1);
is(is_pt_local_holiday_in('Aveiro',2004,5,11),0);
is(is_pt_local_holiday_in('Farripana',2004,1,1),0);

ok(is_pt_holiday_in('Caneco',2005,1,1));
ok(not(is_pt_holiday_in('Caneco',2005,8,20)));
ok(is_pt_holiday_in('Viana do Castelo',2005,8,20));
