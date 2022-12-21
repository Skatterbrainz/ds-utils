function Invoke-DsGrep {
	param (
		[parameter(Mandatory)][string]$Pattern,
		[parameter()][string]$InputString = "",
		[parameter()][string]$Path
	)
	if (![string]::IsNullOrWhiteSpace($Path)) {
		Get-ChildItem -Path $Path | Select-String $Pattern
	} elseif (![string]::IsNullOrWhiteSpace($InputString)) {
		$InputString | Select-String $Pattern
	}
}
