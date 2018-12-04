$in = gc .\04-input.txt | sort

$gHash = @{}
$mHash = @{}

for($i = 0;$i -lt $in.count;$i++){
	$m = @(([regex]"\d+").matches($in[$i]).value)
	
	
	if($m[5]){
		$curGuard = +$m[5]
	}elseif($in[$i] -like "*falls asleep*"){
		$sleepStart = +$m[4]
	}else{
		$sleepEnd = +$m[4]-1
		
		$sleepStart..$sleepEnd | % {
			$gHash[$curGuard]+=@($_)
			$mHash["$curGuard * $_"]++
		}
	}
	
}

$sleepyGuard = ($gHash.getEnumerator() | sort {$_.value.count} -descending)[0].name
$sleepyMinute = ($gHash[$sleepyGuard] | group | sort count -descending)[0].name

$sleepyGuard*$sleepyMinute

($mHash.getEnumerator() | sort value -descending)[0].name | iex
