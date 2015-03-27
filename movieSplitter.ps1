Function TimeConvert ($x){
	$textReformat = $x -replace ",","."
	$y = ([TimeSpan]::Parse($textReformat)).TotalSeconds
	$x = $y
	$x
}

$prefix = Read-host 'Video file prefix'
$video = Read-host 'Path to video'
$videoQuality = Read-host 'Video quality? (higher # = lower quality)'
$csvLoc = Read-host 'Path to timelist (.csv)'
$timeList = Import-Csv $csvLoc -Delimiter ","
$count = 1000

Foreach ($time in $timeList) {     
	$start = $time.start
	$stop = $time.stop
	 
	$start = TimeConvert($start)	# do conversions from hh:mm:ss to seconds
	$stop = TimeConvert($stop)
	
	$stop = $stop - $start	# handbrake CLI --stop-at requires this value
	 
	$title = "$prefix-$count.mp4"

	$command = '"C:\Program Files\Handbrake\HandBrakeCLI.exe" -i $video -o $title -e x264 -q $videoQuality -B 0 --start-at duration:$start --stop-at duration:$stop'
	 
	iex "& $command"
	 
	$count = $count + 1
}