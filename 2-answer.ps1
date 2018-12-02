$in = gc .\2-input.txt

#Part 1

    $twos = $in | ? {
    	$_ -split "" | ?{$_} | group | group count | ? {2 -in $_.name}
    }
    $threes = $in | ? {
    	$_ -split "" | ?{$_} | group | group count | ? {3 -in $_.name}
    }
    
    $twos.length * $threes.length


#Part 2


0..25 | % {
	$curDropIndex = $_
	$droppedList = $in | % {
		$curWord = new-object system.collections.arraylist(,($_ -split "" | ?{$_}))
		$curWord.removeAt($curDropIndex)
		$curWord -join ""
	}
	$dupe = $droppedList | group | ?{$_.count -ne 1} | select -expandproperty name
	if($dupe){
		write-host $dupe
		break
	}
}