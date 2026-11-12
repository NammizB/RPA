param()
$ErrorActionPreference = 'Stop'
$root = $PSScriptRoot
$input = Join-Path $root 'input'
New-Item -ItemType Directory -Force -Path $input | Out-Null
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem
function XmlEscape([string]$s) { [System.Security.SecurityElement]::Escape($s) }
function New-SheetXml($rows) {
  $r = 1
  $xml = '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>'
  foreach($row in $rows) {
    $xml += "<row r='$r'>"; $c = 1
    foreach($value in $row) {
      $ref = [char](64+$c) + $r
      if($value -is [int] -or $value -is [double] -or $value -is [decimal]) { $xml += "<c r='$ref'><v>$value</v></c>" }
      else { $xml += "<c r='$ref' t='inlineStr'><is><t>$(XmlEscape ([string]$value))</t></is></c>" }
      $c++
    }
    $xml += '</row>'; $r++
  }
  return $xml + '</sheetData></worksheet>'
}
function Write-ZipText($path, $entries) {
  if(Test-Path $path) { Remove-Item $path -Force }
  $fs = [System.IO.File]::Open($path,[System.IO.FileMode]::Create)
  $zip = [System.IO.Compression.ZipArchive]::new($fs,[System.IO.Compression.ZipArchiveMode]::Create)
  foreach($key in $entries.Keys) { $entry=$zip.CreateEntry($key); $sw=[System.IO.StreamWriter]::new($entry.Open(),[System.Text.UTF8Encoding]::new($false)); $sw.Write([string]$entries[$key]); $sw.Dispose() }
  $zip.Dispose(); $fs.Dispose()
}
function New-Xlsx($path, $rows) {
  $entries = [ordered]@{}
  $entries['[Content_Types].xml'] = '<?xml version="1.0" encoding="UTF-8"?><Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/><Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/></Types>'
  $entries['_rels/.rels'] = '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>'
  $entries['xl/workbook.xml'] = '<?xml version="1.0" encoding="UTF-8"?><workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="Attendance" sheetId="1" r:id="rId1"/></sheets></workbook>'
  $entries['xl/_rels/workbook.xml.rels'] = '<?xml version="1.0" encoding="UTF-8"?><Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/></Relationships>'
  $entries['xl/worksheets/sheet1.xml'] = New-SheetXml $rows
  Write-ZipText $path $entries
}
$rows = @(); $rows += ,@('StudentId','Name','TotalClasses','AttendedClasses')
foreach($csv in Get-ChildItem $input -Filter 'attendance_dataset_*.csv' | Sort-Object Name) {
  $data = Import-Csv $csv.FullName
  $r = @(); $r += ,@('StudentId','Name','TotalClasses','AttendedClasses')
  foreach($item in $data) { $r += ,@($item.StudentId,$item.Name,[int]$item.TotalClasses,[int]$item.AttendedClasses) }
  $xlsx = Join-Path $input ($csv.BaseName + '.xlsx'); New-Xlsx $xlsx $r
}
Write-Output "Initialized XLSX fixtures in $input"
