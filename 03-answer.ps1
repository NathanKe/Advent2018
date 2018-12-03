$in = gc .\03-input.txt

#Part 1

$hash = @{}

$in | % {
	$curClaim = $_
	
	if($curClaim -match "^.(\d+)\s@\s(\d+),(\d+):\s(\d+)x(\d+)$"){
		$id = +$matches[1]
		$sx = +$matches[2]
		$sy = +$matches[3]
		$lx = +$matches[4]
		$ly = +$matches[5]
		
		
		($sx..($sx+$lx-1)) | % {
			$cx = $_
			($sy..($sy+$ly-1)) | % {
				$cy = $_
				
				$check = $hash["$cx : $cy"]
				if($check){
					$hash["$cx : $cy"]++
				}else{
					$hash.add("$cx : $cy",1)
				}
			}
		}
	}
}

($hash.getEnumerator() | ? {$_.value -ne 1}).length
