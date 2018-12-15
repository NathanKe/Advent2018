$in = gc .\08-input.txt
$samp = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

# Part 1

$array = new-object system.collections.arraylist
$array.AddRange((($samp -split " ")| % {+$_}))


function handleNode{
	$index = $args[0]
	
	$childCount = $array[$index]
	$metasCount = $array[$index+1]
	
	for($i = 0;$i -lt $childCount;$i++){
		handleNode
	}
	
	if($childCount -eq 0){
		$value = $array[($index+2)..($index+1+$metasCount)] | measure -sum | % sum
		
	}
}