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

our $VERSION = '0.02';

=head1 NAME

Date::Holiday::PT - Determine Portuguese public holidays

=head1 IMPORTANT NOTE

This module has moved to Date::Holidays::PT and will be deleted shortly.

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
       11 => 'P�scoa',
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
       15 => 'Assun��o da Virgem',
     },
    10 => {
        5 => 'Implanta��o da Rep�blica',
     },
    11 => {
        1 => 'Festa de Todos-os-Santos',
     },
    12 => {
        1 => 'Restaura��o da Independ�ncia',
        8 => 'Imaculada Concei��o',
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
       19 => [ 'Santar�m' ],
     },
     4 => {
       27 => [ 'Castelo Branco' ],
     },
     5 => {
       12 => [ 'Aveiro' ],
       15 => [ 'Caldas da Rainha' ],
       17 => [ 'Ponta Delgada' ],
       20 => [ 'Beja', 'Estremoz', 'Loul�', 'Marinha Grande',
               'Vila Franca de Xira' ],
       22 => [ 'Leiria' ],
       23 => [ 'Portalegre' ],
       24 => [ '�gueda' ],
     },
     6 => {
        7 => [ 'Oeiras' ],
       13 => [ 'Lisboa', 'Vila Nova de Famalic�o', 'Vila Real' ],
       16 => [ 'Abrantes' ],
       20 => [ 'F�tima' ],
       24 => [ 'Almada', 'Angra do Hero�smo', 'Braga', 'Figueira da Foz',
               'Guimar�es', 'Porto', 'Vila Nova de Gaia' ],
       28 => [ 'Barreiro' ],
       29 => [ 'Bombarral', '�vora', 'Montijo', 'P�voa do Varzim', 'Sintra' ],
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
       22 => [ 'Bragan�a' ],
     },
     9 => {
        7 => [ 'Faro' ],
        8 => [ 'Odemira' ],
       11 => [ 'Amadora' ],
       15 => [ 'Set�bal' ],
       18 => [ 'Mangualde' ],
       20 => [ 'Ponte de Lima' ],
       21 => [ 'Viseu' ],
       27 => [ 'Guarda' ],
       29 => [ 'Cabeceiras de Basto' ],
     },
    10 => {
        7 => [ 'Oliveira do Hospital' ],
       11 => [ 'S�o Jo�o da Madeira' ],
       15 => [ 'Mogadouro' ],
       20 => [ 'Covilh�' ],
       22 => [ 'Gr�ndola' ],
     },
    11 => {
       11 => [ 'Pombal', 'Torres Vedras' ],
     },
    12 => {
       11 => [ 'Portim�o' ],
     },
  );
}

sub is_pt_holiday {
  my $year  = shift || return undef;
  my $month = shift || return undef;
  my $day   = shift || return undef;

  return ${$holidays{$month}}{$day};
}

sub is_pt_public_holiday {
  is_pt_holiday(@_);
}

sub is_pt_local_holiday {
  my $year  = shift || return undef;
  my $month = shift || return undef;
  my $day   = shift || return undef;

  return ${$localholidays{$month}}{$day};
}

sub is_pt_some_holiday {
  is_pt_local_holiday(@_) or is_pt_public_holiday(@_);
}

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

sub is_pt_holiday_in {
  my $city  = shift || return undef;
  is_pt_holiday(@_) or is_pt_local_holiday_in($city,@_);
}

1;
__END__

=head1 AUTHOR

Jose Alves de Castro, E<lt>cog [at] cpan [dot] org<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 by Jose Alves de Castro

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself. 

=cut
