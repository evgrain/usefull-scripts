#���� � ����� ������� � ������� ��������� ���� SQL �������
$path = "X:\MSSQL11.MSSQLSERVER\MSSQL\Backup\EHM"

#���� � ����� � ������� ����� ����������� ������
$dest = "\\nfs\EHMBackups"

#�������� ������� ����������� ����� � �������� SQL, � ���� ������ ������� �� ��������� ������ � ������ �� SQL ��������

$isFile = Test-Path $path
if($isFile -eq "True") {
    robocopy $path $dest *.bak /MOV
    $datetimeold = Get-Date
    #�������� 20 ����
    $datetimeold = $datetimeold.AddDays(-20)
    #������� �������� ������ ������
    ls -r $dest | Where-Object{$datetimeold -gt $_.LastWriteTime} | rm -Force
}
else {
    Write-Host "Disk is unavaible"
}