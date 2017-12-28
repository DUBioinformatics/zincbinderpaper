#!/usr/bin/perl
use Getopt::Std;
getopts('i:w:');

if(($opt_i eq '')||($opt_w eq ''))
{
    &help();
}
#-------------------------------------------

$f_name=$opt_i;
$window_size=$opt_w;

$half=($window_size-1)/2;
for($z=0;$z<$half;$z++)
{
    $terminal="$terminal".'X';
}

open(FILE,"$f_name") or die "$!";
while($line=<FILE>)
{
    chomp($line);
    if($line=~ m/^>/)
    {
	$first_line=<FILE>;chomp($first_line);
	$second_line=<FILE>;chomp($second_line);
	$seq_len=length($first_line);$anno_len=length($second_line);
	$body="$terminal"."$first_line"."$terminal";
	$binding="$terminal"."$second_line"."$terminal";
	@sequence=split//,$body;
	@annotation=split//,$binding;
	
	for($a=$half;$a<=($#sequence-$half);$a++)
	{
	    if(($sequence[$a] eq 'C')||($sequence[$a] eq 'H')||($sequence[$a] eq 'D')||($sequence[$a] eq 'E'))
	    {
		if($annotation[$a] == 0)
		{
		    print "$line:-1:";
		}
		elsif($annotation[$a] == 1)
		{
		    print "$line:+1:";
		}
		
		for($b=($a-$half);$b<=($a+$half);$b++)
		{
		    print "$sequence[$b]";
		}
		print "\n";
	    }
	    
	}
    }
}

sub help()
{
    print "USAGE: patgen.pl -i <file> -w <window size>\n";
    print "i\t name of file containing sequence at one and annotation at second line\n";
    print "w\t window size \(should be an odd number\)\n";
    print "o/p patgen.out\n";
    exit();
}
