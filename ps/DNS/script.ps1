[console]::OutputEncoding = [System.Text.Encoding]::GetEncoding("cp866")

$DNS1 = "192.168.101.1"
$DNS2 = "192.168.101.28"

$fpathlog = "C:\script\log.txt"
$islog = Test-Path $fpathlog
if ($islog -eq "True") {
    Write-host "Log exist"
}
else {
    New-Item $fpathlog -ItemType "file"
}

$fpath = "C:\script\chkfile.txt"
$isfile = Test-Path $fpath
if ($isfile -eq "True") {
    Write-host "File exist"
}
else {
    New-Item $fpath -ItemType "file"
}

$fpathcheck = "C:\script\chkfile.txt"
$isfile = Test-Path $fpathcheck
if ($isfile -eq "True") {
    Write-host "File exist"
}
else {
    New-Item $fpathcheck -ItemType "file"
}
$Check = Get-Content $fpath

if (Test-Connection $DNS1 -Count 1 -Quiet) {
    if ($Check -like "ok") {
    echo good
    }
    else {
    echo "ok" | out-file -FilePath $fpath

    Get-Date | out-file $fpathlog -Append 
    echo "resive connection" | out-file $fpathlog -Append    
    echo "===============================================" | out-file $fpathlog -Append

    dnscmd localhost /RecordDelete domail.local serv_name A $DNS2 /f
    dnscmd localhost /RecordAdd domail.local serv_name A $DNS1
    }
}
else {
    if ($Check -like "ok") {
        echo "Not ok" | out-file $fpath
        Get-Date | out-file $fpathlog -Append 
        echo "lost connection" | out-file $fpathlog -Append
        echo "===============================================" | out-file $fpathlog -Append            
    }
    dnscmd localhost /RecordDelete domail.local serv_name A $DNS1 /f
    dnscmd localhost /RecordAdd domail.local serv_name A $DNS2    
}