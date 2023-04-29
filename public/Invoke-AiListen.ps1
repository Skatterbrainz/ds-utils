function Invoke-AiListen {
	<#
	.SYNOPSIS
	.DESCRIPTION
	.PARAMETER Language
		Default is 'en-US'
	.PARAMETER SafeWord
		Word to listen for to trigger the listening to stop. The default word is 'stop'
	.EXAMPLE
		Invoke-AiListen
		Waits for you to finish speaking a statement or question until you say 'stop'.
		Then it submits your statement to OpenAI using the Get-AiSpeakIt function.
	.LINK
		https://github.com/Skatterbrainz/ds-utils/blob/master/docs/Invoke-AiListen.md
	#>
	[CmdletBinding()]
	param (
		[parameter()][string]$Language = 'en-US',
		[parameter()][string]$SafeWord = 'stop'
	)
	try {
		Add-Type -AssemblyName System.Speech
		$culture = New-Object System.Globalization.CultureInfo($Language)
		$recognizer = New-Object System.Speech.Recognition.SpeechRecognitionEngine($culture)
		$recognizer.RequestRecognizerUpdate()
		$recognizer.LoadGrammar((New-Object System.Speech.Recognition.DictationGrammar))
		$recognizer.SetInputToDefaultAudioDevice()
		$transcription = ''
		while ($transcription -notmatch $SafeWord) {
			Write-Host "Listening to your boring request..."
			$result = $recognizer.Recognize()
			if ($result -ne $null) {
				Write-Host "Holy cow! Do you ever shut up?"
				$transcription += $result.Text
			}
		}
		Write-Host "Hold on. Asking OpenAI to answer your dumb request..."
		if (![string]::IsNullOrWhiteSpace($transcription)) {
			TellMe $transcription
		}
		$recognizer.Dispose()
	} catch {
		Write-Error $_.Exception.Message
	}
}
