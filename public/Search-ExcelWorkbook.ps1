function Search-ExcelWorkbook {
	[CmdletBinding()]
	param (
		[parameter()][ValidateScript({
			if (-Not ($_ | Test-Path) ) {
				throw "File or folder does not exist"
			}
			if (-Not ($_ | Test-Path -PathType Leaf) ) {
				throw "The Path argument must be a file. Folder paths are not allowed."
			}
			if ($_ -notmatch "(\.xlsx|\.xls)") {
				throw "The file specified in the path argument must be either of type .xlsx or .xls"
			}
			return $true
		})]
		[System.IO.FileInfo][Alias("FilePath")]$Path,
		[parameter()][string][Alias("Sheet")]$Worksheet = "",
		[parameter()][string][Alias("OldString","Find")]$TextPattern = "",
		[parameter()][string][Alias("ReplaceWith","NewText")]$NewString = ""
	)
	if (![string]::IsNullOrWhiteSpace($NewString)) { $DoReplace = $True }
	try {
		if (!(Get-Module ImportExcel -ListAvailable)) { throw "Required module not installed: ImportExcel" }
		if (!(Test-Path $Path)) { throw "file not found: $Path"	}
		[array]$worksheets = (Get-ExcelFileSummary -Path $Path).WorksheetName

		if (![string]::IsNullOrWhiteSpace($Worksheet)) {
			$xldata = Import-Excel -Path $Path -WorksheetName $Worksheet -ErrorAction Stop
			if ($xldata) {
				$columns = $xldata[0].psobject.Properties.Name
				$rownum = 1
				foreach ($row in $xldata) {
					$cellnum = 1
					foreach ($cell in $columns) {
						$oldvalue = $row."$cell"
						if ($oldvalue -match $TextPattern) {
							[pscustomobject]@{Worksheet = $worksheet; Row = $($rownum); Cell = $($cellnum); Value = $oldvalue}
						}
						if ($DoReplace) {
							$newvalue = $oldvalue -replace $oldstring, $newstring
							$row."$cell" = $newvalue
						}
						$cellnum++
					}
					$rownum++
				}
			} else {
				throw "No data found for worksheet: $Worksheet"
			}
		} else {
			foreach ($worksheet in $worksheets) {
				$xldata = Import-Excel -Path $Path -WorksheetName $worksheet -ErrorAction Stop
				$columns = $xldata[0].psobject.Properties.Name
				$rownum = 1
				foreach ($row in $xldata) {
					$cellnum = 1
					foreach ($cell in $columns) {
						$oldvalue = $row."$cell"
						if ($oldvalue -match $TextPattern) {
							[pscustomobject]@{Worksheet = $worksheet; Row = $($rownum); Cell = $($cellnum); Value = $oldvalue}
						}
						if ($DoReplace) {
							$newvalue = $oldvalue -replace $oldstring, $newstring
							$row."$cell" = $newvalue
						}
						$cellnum++
					}
					$rownum++
				}
				if ($DoReplace) {
					Write-Verbose "writing modified content back to $Path"
					$xldata | Export-Excel -Path $Path -WorksheetName $worksheet -ClearSheet
				}
			}
		}
		Write-Output $filename
	}
	catch {
		Write-Error $_.Exception.Message
		Write-Warning "You probably forgot to submit a change request with a TPS cover sheet."
	}
}