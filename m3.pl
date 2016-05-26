#!/usr/bin/perl

#------------------------------------------------------------------------
#    Copyright (C) 2011 Luca Amore <luca.amore at gmail.com>
#
#    plfract is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    Maze is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Maze.  If not, see <http://www.gnu.org/licenses/>.
#------------------------------------------------------------------------

use strict;
use warnings;

my $ITERATIONS = 1000;
my ($SIZEX, $SIZEY) = (160, 40);

#my @INTENSITIES = split //, q( .*o&8#@);
#my @INTENSITIES  = split //, q( .:-=+*#%@);
#my @INTENSITIES   = split //, q( .,:!,*oe&#%@);
#my @INTENSITIES = split //, q( .,:;+=oaeO$@A#M);
my @INTENSITIES  = split //, q/ '`^",:;Il!i><~+_-?][}{1)(|\/tfjrxnuvczXYUJCLQ0OZmwqpdbkhao*#MW&8%B@$/;

my $INTENSITIES_STEP = $ITERATIONS / $#INTENSITIES; # pos / intensity;

my ($RE_MIN, $RE_MAX) = (-2.5, 1.0);
my ($IM_MIN, $IM_MAX) = (-1.0, 1.0);

my $re_factor = ($RE_MAX - $RE_MIN) / $SIZEX;
my $im_factor = ($IM_MAX - $IM_MIN) / $SIZEY;

my $C_im = $IM_MIN;

YY: for (my $yy=0; $yy < $SIZEY; $yy++){

    my $C_re = $RE_MIN;

    XX: for (my $xx=0; $xx < $SIZEX; $xx++){

        my ($Z_re, $Z_im, $i) = (0,0);

        # Z0=0, Zn+1 = Zn^2 + C
        ESCAPE_ITERATIONS: for ($i = 1; $i<$ITERATIONS; $i++){

            my ($Z_re2, $Z_im2) = ($Z_re * $Z_re, $Z_im * $Z_im);

            last ESCAPE_ITERATIONS unless ($Z_re2 + $Z_im2 < 4);

            # (a+bi)^2 = a^2 + 2abi - b^2
            $Z_im = 2 * $Z_re * $Z_im + $C_im;
            $Z_re = $Z_re2 - $Z_im2 + $C_re;

        } # end: ESCAPE_ITERATIONS

        # draw pixel
		print dot($i);

        $C_re += $re_factor;

    } # end: XX

	nl();

    $C_im += $im_factor;

} # end: YY

sub dot{
	my ($i) = @_;
	$i = $ITERATIONS if $i > $ITERATIONS;
	return $INTENSITIES[ int($i / $INTENSITIES_STEP + 0.5) ];
}

sub nl{
	print "\n";
}
