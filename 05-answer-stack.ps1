$in = gc .\05-input.txt

function reduce {
	$polymer = $args[0]
	
	$stack = new-object system.collections.stack
	
	for($i = 0;$i -lt $polymer.length;$i++){
		$cur = $polymer[$i]
		if($stack.count -eq 0){
			$stack.push($cur)
		}
		else{
			$peek = $stack.peek()
			
			if(!($peek -bxor $cur -bxor 32)){
				$stack.pop()>$null
			}else{
				$stack.push($cur)
			}
		}
	}
	
	$stack.count
}

write-host (reduce $in)
$removeSet = (0..25) | % {
	$n = [char](65+$_)
	reduce ($in -replace $n,"")
}
write-host ($removeSet | sort | select -first 1)