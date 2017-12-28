#!/usr/bin/perl
$seq_file=$ARGV[1];
open(FH,"$ARGV[0]") or die "$!";
while($line=<FH>)
{
    chomp($line);
    @temp=split(':',$line);
    $pat_length=length($temp[2]);
    $half_length=($pat_length-1)/2;
    $pssm_file="$temp[0]".'_pssm';
    $pssm_file=~ s/^>//;
    #open(PSSM_TEMP,'>pssm_temp') or die "$!";
    open(PSSM_TEMP,">$ARGV[2]") or die "$!"; 
    $seq=`grep -A1 "$temp[0]" $ARGV[1]|grep -v '>'`;
    chomp($seq);
    $seq_length=length($seq);
    for($e=1;$e<=$half_length;$e++)
    {
	$seq='X'."$seq".'X';
    }
    $count=0;
    $end=$seq_length+$half+3;
    open(PSSM,"$ARGV[3]/$pssm_file") or die "$!";   
    while($line=<PSSM>)
    {
	$count++;
	if(($count == 3)||($count == $end))
	{
	    print PSSM_TEMP "$line";
	    for($z=0;$z<$half_length;$z++)
	    {
		print PSSM_TEMP "    0 X   0   0   0   0   0   0   0   0   0   0   0   0 0   0   0   0   0   0   0   0 0   0   0   0   0   0   0   0   0   0   0   0 0   0   0   0   0   0   0   0 0 0\n";
	    }
	}
	else
	{
	    print PSSM_TEMP "$line";
	}
	
    }
    close PSSM;
    close PSSM_TEMP;
    $pat_length=length($temp[2]);
    $pat_start_pos=(index($seq,$temp[2]))+4;
    $pat_end_pos=$pat_start_pos+($pat_length-1);
    $pssm=`sed -n "$pat_start_pos , $pat_end_pos p" $ARGV[2]`;
    @temp_pssm=split('\n',$pssm);
    print "$temp[1] ";
    $c=1;
    foreach $a (@temp_pssm)
    {
	@temp_pssm_line=split('\s+',$a);
	for($b=3;$b<=22;$b++,$c++)
	{
	    print "$c:$temp_pssm_line[$b] ";
	}
	
    }
    print "\n";
}
close FH;
