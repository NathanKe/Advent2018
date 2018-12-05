$in = gc .\05-input.txt

$bigRegex = (0..25 | % {
	$l = [char](97+$_)
	$u = [char](65+$_)
	
	"$l$u"
	"$u$l"
}) -join "|"

function polymerReduce0 {
	$polymer = $args[0]
	
	$repl = $polymer
	
	$done = $false
	while(!$done){
		$repl = $repl -creplace $bigRegex, ""
		
		if($repl.length -ne $polymer.length){
			$polymer = $repl
		}else{
			$done = $true
			$polymer
		}
	}
}

function polymerReduce1 {
	$polymer = $args[0]
	
	$repl = $polymer
	
	$done = $false
	while(!$done){
		0..25 | % {
			$l = [char](97+$_)
			$u = [char](65+$_)
			$repl = $repl -creplace "$l$u", ""
			$repl = $repl -creplace "$u$l", ""
		}
		
		if($repl.length -ne $polymer.length){
			$polymer = $repl
		}else{
			$done = $true
			$polymer
		}
	}
}

function polymerReduce2 {
	$polymer = $args[0]
	
	$repl = $polymer
	
	$done = $false
	while(!$done){
		0..25 | % {
			$l = [char](97+$_)
			$u = [char](65+$_)
			$repl = $repl.Replace("$l$u", "").Replace("$u$l", "")
		}
		
		if($repl.length -ne $polymer.length){
			$polymer = $repl
		}else{
			$done = $true
			$polymer
		}
	}
}

function polymerReduce3 {
	$polymer = $args[0]
	
	$repl = $polymer
	
	$done = $false
	while(!$done){
		$repl = $repl.Replace('Aa','').Replace('aA','').Replace('Bb','').Replace('bB','').Replace('Cc','').Replace('cC','').Replace('Dd','').Replace('dD','').Replace('Ee','').Replace('eE','').Replace('Ff','').Replace('fF','').Replace('Gg','').Replace('gG','').Replace('Hh','').Replace('hH','').Replace('Ii','').Replace('iI','').Replace('Jj','').Replace('jJ','').Replace('Kk','').Replace('kK','').Replace('Ll','').Replace('lL','').Replace('Mm','').Replace('mM','').Replace('Nn','').Replace('nN','').Replace('Oo','').Replace('oO','').Replace('Pp','').Replace('pP','').Replace('Qq','').Replace('qQ','').Replace('Rr','').Replace('rR','').Replace('Ss','').Replace('sS','').Replace('Tt','').Replace('tT','').Replace('Uu','').Replace('uU','').Replace('Vv','').Replace('vV','').Replace('Ww','').Replace('wW','').Replace('Xx','').Replace('xX','').Replace('Yy','').Replace('yY','').Replace('Zz','').Replace('zZ','')

		if($repl.length -ne $polymer.length){
			$polymer = $repl
		}else{
			$done = $true
			$polymer
		}
	}
}


$timer = new-object system.diagnostics.stopwatch

# 0 
write-host "Method 0: Big Regex"
$timer.Start()
write-host ((polymerReduce0 $in).length)
$removeSet = (0..25) | % {
	$n = [char](65+$_)

	(polymerReduce0 ($in -replace $n,"")).length
}
write-host ($removeSet | sort | select -first 1)
$timer.Stop()
write-host $timer.elapsed

# 1
write-host "Method 1: Loop Single Replace"
$timer.Restart()
write-host ((polymerReduce1 $in).length)
$removeSet = (0..25) | % {
	$n = [char](65+$_)

	(polymerReduce1 ($in -replace $n,"")).length
}
write-host ($removeSet | sort | select -first 1)
$timer.Stop()
write-host $timer.elapsed

# 2
write-host "Method 2: Loop Double Replace"
$timer.Restart()
write-host ((polymerReduce2 $in).length)
$removeSet = (0..25) | % {
	$n = [char](65+$_)

	(polymerReduce2 ($in -replace $n,"")).length
}
write-host ($removeSet | sort | select -first 1)
$timer.Stop()
write-host $timer.elapsed

# 3
write-host "Method 3: Big Replace"
$timer.Restart()
write-host ((polymerReduce3 $in).length)
$removeSet = (0..25) | % {
	$n = [char](65+$_)

	(polymerReduce3 ($in -replace $n,"")).length
}
write-host ($removeSet | sort | select -first 1)
$timer.Stop()
write-host $timer.elapsed
