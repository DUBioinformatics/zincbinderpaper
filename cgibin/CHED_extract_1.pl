#!/usr/bin/perl
open(FH,"$ARGV[0]") or die "$!";
while($line=<FH>)
{
    chomp($line);
    @temp=split('\|',$line);
    $next=<FH>;
    chomp($next);
    #print"$next\n";
    @temp1=split(',',$temp[$#temp]);
    $char_1='C';
    $char_2='H';
    $char_3='E';
    $char_4='D';
    $seq_length=length($next);
    
    $result_1=rindex($next, $char_1, $seq_length);
    $result_2=rindex($next, $char_2, $seq_length);
    $result_3=rindex($next, $char_3, $seq_length);
    $result_4=rindex($next, $char_4, $seq_length);
    
    while($result_1 != -1)
    {
	$actual_pos=$result_1+1;
	$temp_seq=$next;
	$residue=substr($temp_seq,$result_1,1);
	$actual_result=$result_1+1;
	$pos_array[$count]=$actual_result;
	$res_array[$count]=$residue;
        $count++;
	$seq_length=$result_1 -1;
	$result_1=rindex($next, $char_1, $seq_length);
    }

    while($result_2 != -1)
    {
	$actual_pos=$result_2+1;
	$temp_seq=$next;
	$residue=substr($temp_seq,$result_2,1);
	$actual_result=$result_2+1;
	$pos_array[$count]=$actual_result;
	$res_array[$count]=$residue;
	$count++;
	$seq_length=$result_2 -1;
	$result_2=rindex($next, $char_2, $seq_length);
    }
while($result_3 != -1)
{
    $actual_pos=$result_3+1;
    $temp_seq=$next;
    $residue=substr($temp_seq,$result_3,1);
    $actual_result=$result_3+1;
    $pos_array[$count]=$actual_result;
    $res_array[$count]=$residue;
    $count++;
    $seq_length=$result_3 -1;
    $result_3=rindex($next, $char_3, $seq_length);
}
while($result_4 != -1)
{
    $actual_pos=$result_4+1;
    $temp_seq=$next;
    $residue=substr($temp_seq,$result_4,1);
    $actual_result=$result_4+1;
    $pos_array[$count]=$actual_result;
    $res_array[$count]=$residue;
    $count++;
    $seq_length=$result_4 -1;
    $result_4=rindex($next, $char_4, $seq_length);
}

    for($a=$#pos_array;$a>=0;$a--)
    {
	print "$pos_array[$a]\n";
	foreach $b (@temp1)
	{
	    if($b == $pos_array[$a])
	    {
		$flag=1;
	    }
	}
	if($flag==0)
	{

	}
	$flag=0;
    }

    @pos_array=();
    @res_array=();
    $count=0;
}
close FH;
