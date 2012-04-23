#!/usr/bin/perl

use strict;
use warnings;

# compose date/time string for subject
sub get_date()
{
	my ($sec,$min,$hour,$mday,$mon,$year,undef,undef,undef) = localtime;
	my $date = sprintf "%04d%02d%02d-%02d%02d", $year+1900, $mon + 1, $mday, $hour, $min;
	#print "$date\n";
	return $date;
}


sub get_filename()
{
	my @farr = glob("tmtrack*.xls");
	my $ofn;
	my $nfn;
	foreach my $ofn (@farr) {
		#print $ofn,"\n";
		open my $fh, $ofn or die;
		while ( <$fh> ) {
			# to match avalon, sphinx, titan
			# [Avalon]All Active Bug List&nbsp;</td>
			if (m/\[(\w+)\]All Active Bug List/) {
				$nfn = $1;
				last;
			}
			# to match duke
			# 04.[PEGATRON] Duke-HC All Bugs List &nbsp;</td>
			if ( m/\[PEGATRON] ([\w+-]+) All Bugs List/ ) {
				$nfn = $1;
				last;
			}
			# to match chagall
			#(Chagall-ICS)BugReport-All Bugs List &nbsp;</td>
			if ( m/\(([\w+-]+)\)BugReport-All Bugs List/ ) {
				$nfn = $1;
				last;
			}
		}
		close $fh;
		my $nd = get_date();
		my $cmd = sprintf("ren \"%s\" \"%s-%s.xls\"", $ofn, $nd, $nfn);
		print $cmd,"\n";
		system $cmd;
	}

}


sub main()
{
	get_filename();
}

main;
