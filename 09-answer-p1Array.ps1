$circle = new-object system.collections.arraylist

$numPlayers = $args[0]
$last = $args[1]

$circle.InsertRange(0,@(0,2,1,3))

$playerIndex = 3 #starts at 3 to accommodate the pre-built start of the array

$players = 1..$numPlayers |% {
	[pscustomobject]@{
		player=$_
		score=0
	}
}

$currIndex = 3
for($next = 4;$next -le $last;$next++){
	if($next % 23 -eq 0){
		#Handle Points
		$currIndex = $currIndex-7
		if($currIndex -lt 0){
			$currIndex = $circle.count + $currIndex
		}
		$players[$playerIndex].score += $next
		$players[$playerIndex].score += $circle[$currIndex]
		$circle.RemoveAt($currIndex)
	}else{
		#Place Correctly
		
		$indexToPlace = ($currIndex+2)%($circle.count)
		#Place At End or Middle
		if($indexToPlace -eq 0){
			$circle.Insert($circle.count,$next)
			$currIndex = $circle.IndexOf($next)
		}else{
			$circle.Insert($indexToPlace,$next)
			$currIndex = $circle.IndexOf($next)
		}
	}
	
	#$x = $playerIndex+1
	#$y = ($circle -join "-")
	#Write-Host "[$x]:$y"
	
	$playerIndex = ($playerIndex + 1)%$numPlayers
}

$players | sort score -descending | select -first 1