# Removes an already existing mapped drive

function Remove-MappedDrive
{
	[CmdletBinding()]
	param
	(
		[parameter(Position=0)]
		[string]$DriveLetter
	)

	if ($DriveLetter -notcontains ":")
	{
		$DriveLetter = $DriveLetter + ":"
	}

	if ((Get-Location).Path -like "$DriveLetter\")
	{
		Set-Location C:\
	}

	net use $DriveLetter /Delete
}
