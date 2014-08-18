#!/usr/bin/perl

while (<DATA>) {
	if ( m/(http:\/\/10.193.95.212\/cts\/)(\w+)\/(\d{4}\.\d\d\.\d\d_\d\d\.\d\d\.\d\d)/ ) {
		my ($url, $prj, $dateid) = ($1, $2, $3);
		my $ofile = sprintf("%s-%s.zip", $prj, $dateid);
		my $cmd = sprintf("curl -o %s %s%s/%s/%s.zip", $ofile, $url, $prj, $dateid, $dateid);
		print $cmd,"\n";
		system $cmd;
		$cmd = sprintf("unzip %s -d %s-%s", $ofile, $prj, $dateid);
		system $cmd;
	}
}

__DATA__
http://10.193.95.212/cts/avalon/2012.04.03_11.51.26/2012.04.03_11.51.26/2012.04.03_11.51.26
http://10.193.95.212/cts/sphinx/2012.04.03_12.18.55/2012.04.03_12.18.55/2012.04.03_12.18.55
http://10.193.95.212/cts/titan/2012.04.03_11.49.43/2012.04.03_11.49.43/2012.04.03_11.49.43
http://10.193.95.212/cts/avalon/2012.04.02_13.03.52/2012.04.02_13.03.52/2012.04.02_13.03.52
http://10.193.95.212/cts/sphinx/2012.04.02_13.43.28/2012.04.02_13.43.28/2012.04.02_13.43.28
http://10.193.95.212/cts/titan/2012.04.02_13.24.53/2012.04.02_13.24.53/2012.04.02_13.24.53
