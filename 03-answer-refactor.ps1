$in = gc .\03-input.txt

$grid = @{}

$in | % {
	$m = @(([regex]"\d+").matches($_).value)
	
	$id = +$m[0]
	$sx = +$m[1]
	$sy = +$m[2]
	$lx = +$m[3]
	$ly = +$m[4]
	
	for($i = $sx;$i -lt $sx+$lx;$i++){
		for($j = $sy;$j -lt $sy+$ly;$j++) {
			$grid["$i,$j"]++
		}
	}
} 
$grid.values | ? {$_ -gt 1} | measure | % count

$parse | % {
	$m = @(([regex]"\d+").matches($_).value)
	
	$id = +$m[0]
	$sx = +$m[1]
	$sy = +$m[2]
	$lx = +$m[3]
	$ly = +$m[4]
	
	$noDouble = $true
	
	for($i = $sx;$i -lt $sx+$lx;$i++){
		for($j = $sy;$j -lt $sy+$ly;$j++) {
			if($grid["$i,$j"] -gt 1){
				$noDouble = $false
			}
		}
	}
	if($noDouble){
		$id
		break
	}
}

