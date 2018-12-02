$inList = gc .\1-input.txt
#$inList = @(-6,3,8,5,-6)

# part 1
$inList -join "" | iex

# part 2
$v = 0
$res = @{}
$loop = 0
$found = $false
while(!$found){
	$loop++
	write-host "Loop $loop"
	for($i = 0;$i -lt $inList.length;$i++){
		$v+=$inList[$i]
		if($res[$v]){
			write-host $v
			$found = $true
			break
		}else{
			$res.add($v,"$loop : $i")
		}
	}
}