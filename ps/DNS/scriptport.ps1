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

$fpath = "C:\script\port.txt"
$isport = Test-Path $fpath
if ($isport -eq "True") {
    Write-host "Port check file exist"
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
$Check = Get-Content $fpathcheck

$test = Test-NetConnection -ComputerName $DNS1 -port 3242 | select TcpTestSucceeded |Format-Table TcpTestSucceeded -AutoSize | out-file -FilePath $fpath
$test = Select-String -path $fpath -Pattern "True"

if ( $test -like "*True*" ) {
    if ($Check -like "ok") {
        echo good
    }
    else {
    echo "ok" | out-file -FilePath $fpathcheck
    Get-Date | out-file $fpathlog -Append 
    echo "resive connection" | out-file $fpathlog -Append    
    echo "===============================================" | out-file $fpathlog -Append
    dnscmd localhost /RecordDelete domain.local serv_name A $DNS2 /f
    dnscmd localhost /RecordAdd domain.local serv_name A $DNS1
    }
}
else {
    if ($Check -like "ok") {
        echo "Not ok" | out-file $fpathcheck
        Get-Date | out-file $fpathlog -Append 
        echo "lost connection" | out-file $fpathlog -Append
        echo "===============================================" | out-file $fpathlog -Append            
    }
    echo "Not ok" | out-file $fpathcheck
    dnscmd localhost /RecordDelete domain.local serv_name A $DNS1 /f
    dnscmd localhost /RecordAdd domain.local serv_name A $DNS2    
}