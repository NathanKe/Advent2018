$in = gc .\08-input.txt
$samp = "2 3 0 3 10 11 12 1 1 0 1 99 2 1 1 2"

# Part 1

$array = new-object system.collections.arraylist
$array.AddRange((($samp -split " ")| % {+$_}))

$metaStack = new-object system.collections.stack

$curType = "Node"
$i = 0
while($array[0] -ne 0){
	
	if($array[$i] -eq 0){
		$array[$i-2]--
		$metaCount = $array[$i+1]
		for($j = 1;$j -le $metaCount;$j++){
			$curMetaIndex = $i+2
			$curMeta = $array[$curMetaIndex]
			
			$metaStack.push($curMeta)
			$array.removeAt($curMetaIndex)
		}
		$array.removeAt($i+1)
		$array.removeAt($i)
		$i = 0
		
		$joinArr = $array -join "-"
	}else{
		$i++
	}
}

2..($array.count-1) |% {$metaStack.push($array[$_])}

$metaStack | measure -sum | % sum


# Part 2

$array = new-object system.collections.arraylist
$array.AddRange((($samp -split " ")| % {+$_}))
$i = 0
while($i -lt $array.count){
	if($array[$i] -eq 0){
		$metaCount = $array[$i+1]
		for($j = 1;$j -le $metaCount;$j++){
			$curMetaIndex = $i+2
			$curMeta = $array[$curMetaIndex]
			
			$array[$i]+=$array[$curMetaIndex]
			$array.removeAt($curMetaIndex)
		}
		$array.removeAt($i+1)
	}
	
	$i++
}