package Date::Holiday::PT;

use 5.008;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);

our %EXPORT_TAGS = ( 'all' => [ qw(
	is_pt_holiday is_pt_public_holiday is_pt_local_holiday
	is_pt_some_holiday is_pt_holiday_in is_pt_local_holiday_in
) ] );

our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );

our @EXPORT = qw(
	is_pt_holiday is_pt_public_holiday is_pt_local_holiday
	is_pt_some_holiday is_pt_holiday_in is_pt_local_holiday_in
);

our $VERSION = '0.01';

=head1 NAME

Date::Holiday::PT - Determine Portuguese public holidays

=head1 VERY IMPORTANT

This is still only an experimental version. It currently works fine
*only* with the holidays for 2004!! Don't use it for anything important
yet.

=head1 SYNOPSIS

  use Date::Holiday::PT;

  ($year, $month, $day) = (localtime)[ 5, 4, 3 ];
  $year  += 1900;
  $month += 1;
  print "today is a holiday" if is_pt_holiday($year, $month, $day);

  $today = is_pt_holiday($year, $month, $day);
  # $today now holds either undef or the name of the holiday

  $today = is_pt_public_holiday($year, $month, $day);
  # same as above

  $today = is_pt_local_holiday(2004,11,11);
  # $today now holds ['Pombal', 'Torres Vedras']
  # this function returns either a reference to an array of all
  # the cities it is holiday in that day or undef, if none

  $isit = is_pt_some_holiday($year, $month, $day);
  # $isit is true value if that day is a public holiday or a local
  # holiday somewhere, and a false value otherwise

  print "today is holiday in Aveiro" if
      is_pt_holiday_in('Aveiro',$year,$month,$day);
  # be it a local holiday in Aveiro or a public (national) holiday

  print "today is holiday in Aveiro" if
      is_pt_local_holiday_in('Aveiro',$year,$month,$day);
  # only if it's a local holiday in Aveiro

=cut

my ( %holidays, %localholidays );

BEGIN {
  %holidays = (
     1 => {
        1 => 'Ano Novo'
     },
     2 => {
       24 => 'Entrudo'
     },
     4 => {
        9 => 'Sexta-Feira Santa',  # this should be a mobile holiday
       11 => 'Páscoa',
       25 => 'Dia da Liberdade',
     },
     5 => {
        1 => 'Dia do Trabalhador'
     },
     6 => {
       10 => 'Dia de Portugal',
       10 => 'Corpo de Deus',
     },
     8 => {
       15 => 'Assunção da Virgem',
     },
    10 => {
        5 => 'Implantação da República',
     },
    11 => {
        1 => 'Festa de Todos-os-Santos',
     },
    12 => {
        1 => 'Restauração da Independência',
        8 => 'Imaculada Conceição',
       25 => 'Natal',
     },
  );

  %localholidays = (
     1 => {
       14 => [ 'Elvas' ],
     },
     2 => {
     },
     3 => {
        1 => [ 'Tomar' ],
       19 => [ 'Santarém' ],
     },
     4 => {
       27 => [ 'Castelo Branco' ],
     },
     5 => {
       12 => [ 'Aveiro' ],
       15 => [ 'Caldas da Rainha' ],
       17 => [ 'Ponta Delgada' ],
       20 => [ 'Beja', 'Estremoz', 'Loulé', 'Marinha Grande',
               'Vila Franca de Xira' ],
       22 => [ 'Leiria' ],
       23 => [ 'Portalegre' ],
       24 => [ 'Águeda' ],
     },
     6 => {
        7 => [ 'Oeiras' ],
       13 => [ 'Lisboa', 'Vila Nova de Famalicão', 'Vila Real' ],
       16 => [ 'Abrantes' ],
       20 => [ 'Fátima' ],
       24 => [ 'Almada', 'Angra do Heroísmo', 'Braga', 'Figueira da Foz',
               'Guimarães', 'Porto', 'Vila Nova de Gaia' ],
       28 => [ 'Barreiro' ],
       29 => [ 'Bombarral', 'Évora', 'Montijo', 'Póvoa do Varzim', 'Sintra' ],
     },
     7 => {
        4 => [ 'Coimbra' ],
        8 => [ 'Amarante', 'Chaves' ],
       12 => [ 'Maia' ],
       19 => [ 'Paredes' ],
       26 => [ 'Loures' ],
     },
     8 => {
        2 => [ 'Peniche' ],
       20 => [ 'Viana do Castelo' ],
       21 => [ 'Funchal' ],
       22 => [ 'Bragança' ],
     },
     9 => {
        7 => [ 'Faro' ],
        8 => [ 'Odemira' ],
       11 => [ 'Amadora' ],
       15 => [ 'Setúbal' ],
       18 => [ 'Mangualde' ],
       20 => [ 'Ponte de Lima' ],
       21 => [ 'Viseu' ],
       27 => [ 'Guarda' ],
       29 => [ 'Cabeceiras de Basto' ],
     },
    10 => {
        7 => [ 'Oliveira do Hospital' ],
       11 => [ 'São João da Madeira' ],
       15 => [ 'Mogadouro' ],
       20 => [ 'Covilhã' ],
       22 => [ 'Grândola' ],
     },
    11 => {
       11 => [ 'Pombal', 'Torres Vedras' ],
     },
    12 => {
       11 => [ 'Portimão' ],
     },
  );
}

=head1 SUMMARY OF AVAILABLE FUNCTIONS

=over 4

=item * I<is_pt_holiday>

	is_pt_holiday($year, $month, $day);

=cut

sub is_pt_holiday {
  my $year  = shift || return undef;
  my $month = shift || return undef;
  my $day   = shift || return undef;

  return ${$holidays{$month}}{$day};
}

=item * I<is_pt_public_holiday>

	is_pt_public_holiday($year, $month, $day);

=cut

sub is_pt_public_holiday {
  is_pt_holiday(@_);
}

=item * I<is_pt_local_holiday>

	is_pt_local_holiday($year,$month,$day);

=cut

sub is_pt_local_holiday {
  my $year  = shift || return undef;
  my $month = shift || return undef;
  my $day   = shift || return undef;

  return ${$localholidays{$month}}{$day};
}

=item * I<is_pt_some_holiday>

	is_pt_some_holiday($year, $month, $day);

=cut

sub is_pt_some_holiday {
  is_pt_local_holiday(@_) or is_pt_public_holiday(@_);
}

=item * I<is_pt_holiday_in>

	is_pt_holiday_in($district,$year,$month,$day);

=cut

sub is_pt_local_holiday_in {
  my $city  = shift || return undef;
  my $year  = shift || return undef;
  my $month = shift || return undef;
  my $day   = shift || return undef;

  for (@{${$localholidays{$month}}{$day}}) {
    return 1 if $_ eq $city;
  }

  return 0;
}

=item * I<is_pt_local_holiday_in>

	is_pt_local_holiday_in($district,$year,$month,$day);

=back

=cut

sub is_pt_holiday_in {
  my $city  = shift || return undef;
  is_pt_holiday(@_) or is_pt_local_holiday_in($city,@_);
}

1;
__END__

=head1 DESCRIPTION

Determines Portuguese public and local holidays.

=head1 PORTUGUESE HOLIDAYS

There are 14 Portuguese public holidays (beware that functions returning
these names return accentuated versions of them):

  January   01 - Ano Novo
  February  24 - Entrudo
  April     09 - Sexta-Feira Santa
  April     11 - Pascoa
  April     25 - Dia da Liberdade
  May       01 - Dia do Trabalhador
  June      10 - Dia de Portugal
  June      10 - Corpo de Deus
  August    15 - Assuncao da Virgem
  October   05 - Implantacao da Republica
  November  01 - Festa de Todos-os-Santos
  December  01 - Restauracao da Independencia
  December  08 - Imaculada Conceicao
  December  25 - Natal

And there are 61 Portuguese local holidays (beware that functions returning
these names return accentuated versions of them):

  January   14 - Elvas
  March      1 - Tomar
            19 - Santarem
  April     27 - Castelo Branco
  May       12 - Aveiro
            15 - Caldas da Rainha
            17 - Ponta Delgada
            20 - Beja, Estremoz, Loule, Marinha Grande,
                 Vila Franca de Xira
            22 - Leiria
            23 - Portalegre
            24 - Agueda
  June       7 - Oeiras
            13 - Lisboa, Vila Nova de Famalicao, Vila Real
            16 - Abrantes
            20 - Fatima
            24 - Almada, Angra do Heroismo, Braga, Figueira da Foz,
                 Guimaraes, Porto, Vila Nova de Gaia
            28 - Barreiro
            29 - Bombarral, Evora, Montijo, Povoa do Varzim, Sintra
  July       4 - Coimbra
             8 - Amarante, Chaves
            12 - Maia
            19 - Paredes
            26 - Loures
  August     2 - Peniche
            20 - Viana do Castelo
            21 - Funchal
            22 - Braganca
  September  7 - Faro
             8 - Odemira
            11 - Amadora
            15 - Setubal
            18 - Mangualde
            20 - Ponte de Lima
            21 - Viseu
            27 - Guarda
            29 - Cabeceiras de Basto
  October    7 - Oliveira do Hospital
            11 - Sao Joao da Madeira
            15 - Mogadouro
            20 - Covilha
            22 - Grandola
  Novembro  11 - Pombal, Torres Vedras
  Dezembro  11 - Portimao

=head1 BUGS

Mobile holidays are still not being correctly calculated.

=head1 MESSAGE FROM THE AUTHOR

If you're using this module, please drop me a line to my e-mail. Tell me what
you're doing with it. Also, feel free to suggest new bugs^H^H^H^H^H features
O:-)

=head1 AUTHOR

Jose Alves de Castro, E<lt>cog [at] cpan [dot] org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
