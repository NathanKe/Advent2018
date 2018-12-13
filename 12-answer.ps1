    #pull input, replace characters to 0 and 1
    $in = gc .\12-input.txt | % {
    	($_ -replace "\.","0") -replace "#","1"
    }
    
    #sorting rules allows for "11111"->31-->Rule #31
    $rules = 2..($in.count-1) | % {
    	$in[$_]
    } | sort
    
    # Manual inspection shows stabilization after 150 generations
    # 1000 extra zeroes at the end is enough
    # 10 zeroes at the front to account for initial slight leftward movement
    $stable = 150
    $state = ("0"*3)+($in[0] -split " ")[2]+("0"*1000)
    
    # Loop to stabilization point, make new state, get new sum
    for($i = 1;$i -le $stable;$i++){
    	$applyRules = (2..($state.length-3) | %{
    		# 5 length substring to binary to index of rule.
			# Last character of corresponding rule is the rule result
    		$rules[[convert]::ToInt32($state.Substring($_ - 2,5),2)][-1]
    	}) -join ""
    	$state = "00"+$applyRules+"00"
    	$sum = 0
    	0..($state.length-1) | % {
    		if($state[$_] -eq "1"){
    			$sum+= $_ - 10 # shift back those leading 10 zeroes
    		}
    	}
    	
    	# Write at 20 generations
    	if($i -eq 20){
    		write-host $sum
    	}
    }
    
    #Remaining steps times stabilized diff plus current sum
    (50000000000-$stable)*$diff+$sum