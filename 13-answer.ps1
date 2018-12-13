$map = (gc .\13-input.txt).Replace("^","U").Replace(">","R").Replace("v","D").Replace("<","L")


for($row = 0;$row -lt $map.count; $row++) {
	for($col = 0;$col -lt ($map[0].length);$col++){
		$current = $map[$row][$col]
		
		switch($current){
			"U"{
				$next = $map[$row-1][$col]
			}
			"D"{
				$next = $map[$row+1][$col]
			}
			"L"{
				$next = $map[$row][$col-1]
			}
			"R"{
				$next = $map[$row][$col-1]
			}
			default{
				$next = $null
			}
		}
		
		
	}
}