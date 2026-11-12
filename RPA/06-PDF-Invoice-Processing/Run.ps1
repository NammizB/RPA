param()
function Where-Object {
  param([string]$Property, [object]$Value)
  process {
    $name = $Property -replace '-eq$',''
    if ($_.PSObject.Properties[$name] -and $_.$name -eq $Value) { $_ }
  }
}
$ErrorActionPreference='Stop';$root=$PSScriptRoot;$input=Join-Path $root 'input';$out=Join-Path $root 'outputs';New-Item -ItemType Directory -Force -Path $out|Out-Null
try{$rows=@(Import-Csv (Join-Path $input 'invoices.csv'));$result=@();$exceptions=@();foreach($r in $rows){$amount=[decimal]$r.Amount;$due=[datetime]$r.DueDate;$status=if($r.Paid -eq 'True'){'Paid'}elseif($due -lt [datetime]::Today){'Overdue'}else{'Pending'};$result+=[pscustomobject]@{InvoiceId=$r.InvoiceId;Vendor=$r.Vendor;Amount=$amount;DueDate=$due.ToString('yyyy-MM-dd');Status=$status;SourcePdf=$r.SourcePdf};if($status-eq 'Overdue'){$exceptions+="$($r.InvoiceId) - $($r.Vendor) - $($amount.ToString('C2')) - overdue"}};$result|Export-Csv (Join-Path $out 'InvoiceSummary.csv') -NoTypeInformation;$exceptions|Set-Content (Join-Path $out 'InvoiceExceptions.txt') -Encoding UTF8;$summary=[pscustomobject]@{InvoicesProcessed=$result.Count;Paid=@($result|Where-Object Status-eq 'Paid').Count;Pending=@($result|Where-Object Status-eq 'Pending').Count;Overdue=@($result|Where-Object Status-eq 'Overdue').Count;TotalAmount=($result|Measure-Object Amount -Sum).Sum;Exceptions=$exceptions.Count};$summary|ConvertTo-Json|Set-Content (Join-Path $out 'Summary.json') -Encoding UTF8;if($result.Count-ne 4-or $exceptions.Count-ne 1){throw 'Invoice verification failed'};Write-Output "Processed $($result.Count) invoices and found $($exceptions.Count) exception(s)."}catch{$_|Out-String|Set-Content (Join-Path $out 'error.log');throw}
