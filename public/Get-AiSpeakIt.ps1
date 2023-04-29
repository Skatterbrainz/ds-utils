function Get-AiSpeakIt {
	<#
	.SYNOPSIS
		Speak a verbal response from ChatGPT using Windows Speech API
	.DESCRIPTION
		Do I need to clarify that?
	.PARAMETER Prompt
		The question or statement you wish to send to OpenAI.
	.PARAMETER Coda
		The suffix to be appended to the response. The default is usually enough. :)
	.EXAMPLE
		Get-AiSpeakIt -Prompt "What is the fourth planet from our sun?"
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Get-AiSpeakIt.md
	#>
	[CmdletBinding()]
	param (
		[parameter(Mandatory)][string]$Prompt,
		[parameter()][string]$Coda = "Dumbass.",
		[parameter()][switch]$RepeatQuestion
	)
	try {
		if (!(Get-Module PowerShellAI -ListAvailable)) {
			throw "Module not installed: PowerShellAI"
		}
		Add-Type -AssemblyName System.Speech
		$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
		if ($RepeatQuestion) {
			$speak.Speak("You asked: $Prompt")
		} else {
			Write-Host "Asking ChatGPT: $Prompt"
		}
		$response = ai $Prompt
		if ($response) {
			$response += "... $Coda"
		} else {
			$response = $Coda
		}
		Write-Host "Generating response..."
		$speak.Speak($response)
		$speak.Dispose()
	} catch {
		Write-Error $_.Exception.Message
	}
}
