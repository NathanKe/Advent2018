$serial = $args[0]

function powerLevel{
	$cx = $args[0]
	$cy = $args[1]
	
	[math]::Truncate(((($cx+10)*$cy+$serial)*($cx+10))/100%10)
}

$grid = new-object 'int[,]' 301,301
for($i = 1;$i -le 300;$i++){
	for($j=1;$j -le 300;$j++){
		$grid[$i,$j] = [math]::Truncate(((($i+10)*($j)+$serial)*($i+10))/100%10)
	}
}

$max = 0
$maxX = 0
$maxY = 0
$maxQ = 0

for($q = 3;$q -le 3;$q++){
	for($x = 1;$x -le (300-$q+1);$x++){
		for($y = 1;$y -le (300-$q+1);$y++){
			$sub = 0
			for($i = 0;$i -le ($q-1);$i++){
				for($j = 0;$j -le ($q-1);$j++){
					$sub+= $grid[($x+$i),($y+$j)]
				}
			}
			if($sub -gt $max){
				$max = $sub
				$maxX = $x
				$maxY = $y
				$maxQ = $q
			}
		}
	}
	Write-Host "$q $maxX $maxY $max"
}

$maxX
$maxY
$maxQ