$in = gc .\03-input.txt

#$in = @("#1 @ 1,3: 4x4","#2 @ 3,1: 4x4","#3 @ 5,5: 2x2")


#Part 1


$hash = @{}

Write-Host "expanding"
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
			if(!$hash[$cx]){
				$hash.add($cx,@{})
			}
			($sy..($sy+$ly-1)) | % {
				$cy = $_
				if(!$hash[$cx][$cy]){
					$hash[$cx].add($cy,[pscustomobject]@{ids=(new-object system.collections.arraylist);hits=0})
				}
				
				$hash[$cx][$cy].hits++
				$hash[$cx][$cy].ids.add($id)>$null
			}
		}
	}
}


$expand = $hash.values.values

Write-Host "Counting Overlap"
($expand.hits | ? {$_ -gt 1}).count

Write-Host "MultiClaims"
$multiClaims = $expand | ? {$_.ids.count -ne 1}
Write-Host "Id Expansion"
$idsMultiClaims = $multiClaims | select -expandproperty ids
Write-Host "Unique IDs"
$multiClaimsReduce = $idsMultiClaims | group | select -expandproperty name
Write-Host "CrossReference"
$nonMultiClaims = 1..$in.count |? {$_ -notin $multiClaimsReduce}
Write-Host "Singleton"
$nonMultiClaims

