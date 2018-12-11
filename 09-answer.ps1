$circle = new-object 'system.collections.generic.linkedlist[int]'

$numPlayers = $args[0]
$lastNumber = $args[1]

$players = 1..$numPlayers |% {
	[pscustomobject]@{
		player=$_
		score=0
	}
}

$currentNode = $circle.addFirst(0)
$playerIndex = 0
for($nextMarble=1;$nextMarble -le $lastNumber;$nextMarble++){
	if($nextMarble % 23 -ne 0){
		# Step 1, Add, Step 1
		if($currentNode.next){
			$currentNode = $currentNode.next
		}else{
			$currentNode = $currentNode.list.first
		}
		$circle.addAfter($currentNode,$nextMarble)>$null
		
		if($currentNode.next){
			$currentNode = $currentNode.next
		}else{
			$currentNode = $currentNode.list.first
		}
	}else{
		# Add Next to score
		$players[$playerIndex].score+=$nextMarble
		
		# Go back 7
		for($i = 1;$i -le 7;$i++){
			if($currentNode.previous){
				$currentNode = $currentNode.previous
			}else{
				$currentNode = $currentNode.list.last
			}
		}
		
		# Capture New Next
		if($currentNode.next){
			$nextNode = $currentNode.next
		}else{
			$nextNode = $currentNode.list.first
		}
		
		# Add value of current, remove current
		$players[$playerIndex].score+=$currentNode.value
		$circle.remove($currentNode)
		
		#Set current to next
		$currentNode = $nextNode
	}
	
	#Increment Player
	$playerIndex = ($playerIndex + 1)%$numPlayers
}

$players | sort score -descending | select -first 1