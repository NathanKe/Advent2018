$in = gc .\08-input.txt

$array = new-object system.collections.arraylist
$array.AddRange((("2 3 0 3 0 0 0 1 1 0 1 0 0 0 0 0" -split " ")| % {+$_}))

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
	}
	
	$i++
}

2..($array.count-1) |% {$metaStack.push($array[$_])}

$metaStack | measure -sum | % sum