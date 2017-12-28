#!/usr/bin/perl
$a=0;
open(FH, "$ARGV[0]")or die;
while ($line=<FH>)
{
    chomp($line);
    if ($line=~m/^>/)
    {
	$nextline=<FH>;
	chomp ($nextline);
	#print "$nextline\n";
	$app = "$line"."\n"."$nextline"; 

	$pssm[$a]=$app;

	$line=~ s/^>//;

	$pssm_out="$line".'_pssm';
	$blast_out="$line".'.out';
	#/usr/local/bin/blast-2.2.18/bin/blastpgp#
	open(TMP,">temp") or die "$!";
	print TMP "$pssm[$a]\n";
	close TMP;
	system "cat temp";
	$a++;
	#system "$path_blastpgp -d $path_database -i temp -j 3 -h 0.001 -m 8 -Q $pssm_out -o $blast_out";
	system "/usr/local/bin/blast-2.2.18/bin/blastpgp  -d /webservers/cgi-bin/znbinder/nr90/nr90 -i $dir/temp -j 3 -h 0.001 -m 8 -Q $pssm_out -o $blast_out";
	system "mv $pssm_out PSSM/.";
    }
}
