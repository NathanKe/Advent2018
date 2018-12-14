$recipeSet = new-object system.collections.arraylist
$addedIndex = $recipeSet.add(3)
$addedIndex = $recipeSet.add(7)


$elf1Index = 0
$elf2Index = 1

$skillCheck = $args[0]


while($addedIndex -lt ($skillCheck+10)){
	$elf1Cur = $recipeSet[$elf1Index]
	$elf2Cur = $recipeSet[$elf2Index]
	($elf1Cur+$elf2Cur) -split "" | ? {$_} | % {$addedIndex = $recipeSet.add(+$_)}
	$elf1Index = ($elf1Index + 1 + $elf1Cur) % $recipeSet.count
	$elf2Index = ($elf2Index + 1 + $elf2Cur) % $recipeSet.count
}

$next10 = ($skillCheck)..($skillCheck+9) | %{
	$recipeSet[$_]
}

Write-Host "Part 1"
$next10 -join ""

$search = $args[1]

Write-host "Part 2"

$q = new-object 'system.collections.generic.queue [int]'
$recipeSet[-6..-1] | % {$q.Enqueue($_)}

if(($recipeSet -join "") -Match "^(\d+?)$search\d*?$"){
	$matches[1].length
}else{
	while($q -join "" -ne "$search"){
		$elf1Cur = $recipeSet[$elf1Index]
		$elf2Cur = $recipeSet[$elf2Index]
		($elf1Cur+$elf2Cur) -split "" | ? {$_} | % {
			$recipeSet.add(+$_) > $null
			$q.enqueue(+$_)
			$q.dequeue() > $null
		}
		$elf1Index = ($elf1Index + 1 + $elf1Cur) % $recipeSet.count
		$elf2Index = ($elf2Index + 1 + $elf2Cur) % $recipeSet.count
		if($recipeSet.count % 10000 -eq 0){
			write-host $recipeSet.count
		}
	}
}
