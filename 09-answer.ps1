$circle = new-object 'system.collections.generic.linkedlist[int]'

$numPlayers = $args[0]
$lastNumber = $args[1]

$players = 1..$numPlayers |% {
	[pscustomobject]@{
		player=$_
		score=0
	}
}

function circNext{
	$cur = $args[0]
	if($cur.next){
		$cur.next
	}else{
		$cur.list.first
	}
}
function circPrev{
	$cur = $args[0]
	if($cur.prev){
		$cur.prev
	}else{
		$cur.list.last
	}
}

$currentNode = $circle.addFirst(0)
$playerIndex = 0
for($nextMarble=1;$nextMarble -le 22;$nextMarble++){
	if($nextMarble % 23 -ne 0){
		# Step 2 and Add
		
		$currentNode = circNext $currentNode
		$currentNode = circNext $currentNode
		$circle.addAfter($currentNode,$nextMarble)>$null
	}else{
		$players[$playerIndex].score+=$nextMarble
		
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		$currentNode = circPrev $currentNode
		
		$players[$playerIndex].score+=$currentNode.value
		$circle.remove($currentNode)
	}
	
	#Increment Player
	$playerIndex = ($playerIndex + 1)%$numPlayers
	
	#Write Diagnostic
	$str =  $circle -join "-"
	write-host $str
}


#for($next = 4;$next -le $lastNumber;$next++){
#	if($next % 23 -eq 0){
#		#Handle Points
#		$currIndex = $currIndex-7
#		if($currIndex -lt 0){
#			$currIndex = $circle.count + $currIndex
#		}
#		$players[$playerIndex].score += $next
#		$players[$playerIndex].score += $circle[$currIndex]
#		$circle.RemoveAt($currIndex)
#	}else{
#		#Place Correctly
#		
#		$indexToPlace = ($currIndex+2)%($circle.count)
#		#Place At End or Middle
#		if($indexToPlace -eq 0){
#			$circle.Insert($circle.count,$next)
#			$currIndex = $circle.IndexOf($next)
#		}else{
#			$circle.Insert($indexToPlace,$next)
#			$currIndex = $circle.IndexOf($next)
#		}
#	}
#	
#	$playerIndex = ($playerIndex + 1)%$numPlayers
#}
#
#$players | sort score -descending | select -first 1