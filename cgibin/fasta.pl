#!/usr/bin/perl
$f_name=$ARGV[0];
if($f_name eq '')
{
    print "ERROR!\nfasta.pl input\n";
    exit;
}
open(FH,"$f_name") or print "at opening of file\n";
while($line=<FH>)
{
    chomp($line);
    $whole[$b]=~ s/[^_>a-zA-Z0-9]//g;
    $whole[$a]=$line;
    $a++;
}
close FH;
for($b=0;$b<=$#whole;$b++)
{
    if($whole[$b] =~ m/^>/)
    {
	chomp($whole[$b]);
        $whole[$b]=~s /:/_/g; 
	@entries=split(/\|/,$whole[$b]);
	print"$entries[0]\n";
	$b++;
	while($whole[$b] =~ m/^[^>]/)
	{   
	    print "$whole[$b]";
	    $b++;
	}
	$b--;
    }
    print "\n";
}


    
