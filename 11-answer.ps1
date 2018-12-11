$serial = $args[0]

$sumGrid = new-object 'int[,]' 301,301

function power{
	$serial = $args[0]
	$x = $args[1]
	$y = $args[2]
	
	
	$rack = $x+10
	$power = $rack*$y
	$power+=$serial
	$power*=$rack
	
	$power = ($power/100)%10
	$power = [math]::Truncate($power)
	$power -= 5
	$power
}

for($x = 1;$x -le 300;$x++){
	for($y=1;$y -le 300;$y++){
		$curPower = power $serial $x $y
		$sumGrid[$x,$y] = $curPower + $sumGrid[($x-1),$y] + $sumGrid[$x,($y-1)] - $sumGrid[($x-1),($y-1)]
	}
}

$max = -1e6
$maxX = -1
$maxY = -1
for($x = 1;$x -le 298;$x++){
	for($y=1;$y -le 298;$y++){
		$val = $sumGrid[$x,$y]-$sumGrid[($x+2),$y]-$sumgrid[$x,($y+2)]+$sumGrid[($x+1),($y+1)]
		if($val -gt $max){
			$max = $val
			$maxX = $x
			$maxY = $y
		}
	}
}

Write-Host "$max $maxX $maxY"