#!/usr/bin/perl
open(FH,"$ARGV[0]") or die "$!";
while($line=<FH>)
{
    chomp($line);
    @temp=split('\|',$line);
    print "$line\n";
    $next=<FH>;
    chomp($next);
    print "$next\n";
    @temp1=split(',',$temp[$#temp]);

    $char='C';
    $seq_length=$protein_length=length($next);


    $result=rindex($next, $char, $seq_length);

    while($result != -1)
    {
	$actual_pos=$result+1;
	$temp_seq=$next;
	$residue=substr($temp_seq,$result,1);
	$actual_result=$result+1;

	$pos_array[$count]=$actual_result;
	$res_array[$count]=$residue;

	$count++;
	$seq_length=$result -1;


	$result=rindex($next, $char, $seq_length);

    }

    for($z=1;$z<=$protein_length;$z++)
    {
	$flag=0;
	for($y=0;$y<=$#temp1;$y++)
	{
	    if($z == $temp1[$y])
	    {
		print "1";
		$flag=1;
	    }
	}
	if($flag==0)
	{
	    print "0";
	}
    }
    print "\n";

    @pos_array=();
    @res_array=();
    $count=0;
}
close FH;
