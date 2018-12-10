$timer = New-Object System.Diagnostics.Stopwatch
$timer.start()

$in = gc .\07-input.txt

Write-Host "Part 1"
$timer.restart()

$stepsTaken = new-object system.collections.arraylist

$steps = $in | % {
	if($_ -cmatch "\s([A-Z])\s.*\s([A-Z])\s.*"){
		[pscustomobject]@{
			pre = $matches[1]
			post = $matches[2]
		}
	}
}

while($steps.count -gt 1){
	$take = @($steps.pre | ? {$_ -notin $steps.post} | sort)[0]
	
	$stepsTaken.add($take)>$null
	
	$steps = $steps | ? {$_.pre -ne $take}
}

$stepsTaken.add($steps[0].pre)>$null
$stepsTaken.add($steps[0].post)>$null

$stepsTaken -join ""

$timer.stop()
Write-Host $timer.Elapsed

Write-Host "Part 2"
$timer.restart()

$baseCooldown = 60
$numWorkers = 5

$workers = 1..$numWorkers | % {
	[pscustomobject]@{
		id=$_
		cooldown=-1
		task= ""
	}
}

$steps = $in | % {
	if($_ -cmatch "\s([A-Z])\s.*\s([A-Z])\s.*"){
		[pscustomobject]@{
			pre = $matches[1]
			post = $matches[2]
		}
	}
}

$stepsTaken = new-object system.collections.arraylist
$activeTasks = new-object system.collections.arraylist
$timeTaken = 0

while($steps.count -ge 1){
	# Find Available Tasks and Workers
	$availTasks = @($steps.pre | ? {$_ -notin $steps.post -and $_ -notin $activeTasks} | select -unique | sort)
	$availWorkers = @($workers | ? {!$_.task})
	
	$availTaskStr = $availTasks -join ""
	$availWorkStr = $availWorkers.id -join ""
	$availTaskCount = $availTasks.count
	$availWorkCount = $availWorkers.count
	
	Write-Host "$availWorkCount workers avail:  $availWorkStr , $availTaskCount tasks avail: $availTaskStr"
	
	# Assign Tasks To Workers, add task to active set, set cooldown
	$assignMax = [math]::min($availTasks.count,$availWorkers.count)
	for($i=0;$i -lt $assignMax;$i++){
		$id = $availWorkers[$i].id
		$task = $availTasks[$i]
		
		Write-Host "Assigning $task to $id"
		
		$activeTasks.add($task)>$null
		
		$workers | ? {$_.id -eq $id} | % {
			$_.task = $task
			$_.cooldown = $baseCooldown + [int][char]$task - 64
		}
		
	}
	
	
	# Step time, decrement cooldowns
	$timeTaken++
	$workers | %{$_.cooldown--}
	
	# Complete task, remove from active list, push to complete list, remove from worker
	$workers | ? {$_.cooldown -eq 0} | % {
		$ctsk = $_.task
		$cid = $_.id
		Write-Host "Task $ctsk completed by $cid"
		$activeTasks.remove($_.task)
		$steps = $steps | ? {$_.pre -ne $ctsk}
		$stepsTaken.add($_.task)>$null
		$_.task = ""
		
	}
	
	
}

$timeTaken+=([int][char]$steps[0].pre-64+$baseCooldown)
$timeTaken+=([int][char]$steps[0].post-64+$baseCooldown)

$timeTaken

$timer.stop()
Write-Host $timer.Elapsed