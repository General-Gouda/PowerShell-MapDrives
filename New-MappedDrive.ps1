# Maps a new drive in Windows using net use since New-PSDrive does not always persist as it should.

function New-MappedDrive
{
	[CmdletBinding()]
	param
	(
		[parameter(Position=0)][string]$DriveLetter,
		[parameter(Position=1)][string]$Destination,
		[switch]$Persistent
	)

	if ($DriveLetter -notcontains ":")
	{
		$DriveLetter = $DriveLetter + ":"
	}

	$Destination = $Destination.TrimEnd("\")

	if ($Persistent)
	{
		& net use $DriveLetter $Destination /Persistent:Yes
	}
	else
	{
		& net use $DriveLetter $Destination
	}

	while ((Test-Path "$DriveLetter\") -eq $false) {
		Start-Sleep -Seconds 1
	}
	
	Set-Location "$DriveLetter\"
}
