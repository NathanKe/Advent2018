$in = gc .\10-input.txt

function parseLine{
	$line = $args[0]
	
	$reg = [regex]"(-?\d+)"
	
	$matches = $reg.Matches($line)
	
	[pscustomobject]@{
		xPos = +($matches[0].value)
		yPos = +($matches[1].value)
		xVel = +($matches[2].value)
		yVel = +($matches[3].value)
	}
}

$points = $in | %{parseLine $_}

function stepPoints{
	$stepLength = +($args[0])
	$stepDir = +($args[1])
	
	$points | % {
		$_.xPos += $stepDir*$stepLength*$_.xVel
		$_.yPos += $stepDir*$stepLength*$_.yVel
	}
}

function lowPoint{
	($points | sort yPos)[0].yPos
}
function highPoint{
	($points | sort yPos)[-1].yPos
}
function leftPoint{
	($points | sort xPos)[0].xPos
}
function rightPoint{
	($points | sort xPos)[-1].xPos
}

$ticks = 0

function bulkStep{
	$stepSize = $args[0]
	$limit = $args[1]
	
	do{
		$range = (highPoint)-(lowPoint)
		Write-Host $range
		stepPoints $stepSize 1
		$global:ticks+=$stepSize
	}while($range -gt $limit)
	stepPoints $stepSize -1
	$global:ticks-=$stepSize
}

bulkStep 1000 10000
bulkStep 100 1000
bulkStep 10 100
bulkStep 1 9


$retString = ""
((lowPoint)..(highPoint))|%{
	$cY = $_
	((leftPoint)..(rightPoint))|%{
		$cX = $_
		$cP = $points | ? {$_.xPos -eq $cX -and $_.yPos -eq $cY}
		if($cP){
			$retString+="#"
		}else{
			$retString+="."
		}
	}
	$retString+="`n"
}
#Part 1
$retString
#Part 2
$ticks
