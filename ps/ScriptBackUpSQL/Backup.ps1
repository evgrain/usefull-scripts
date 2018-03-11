#Путь к папке бэкапов в которую бэкапится база SQL сервера
$path = "X:\MSSQL11.MSSQLSERVER\MSSQL\Backup\EHM"

#Путь к папке в которую нужно переместить бэкапы
$dest = "\\nfs\EHMBackups"

#Проверка наличия подключения диска с бэкапами SQL, в один момент времени он подключен только к одному из SQL серверов

$isFile = Test-Path $path
if($isFile -eq "True") {
    robocopy $path $dest *.bak /MOV
    $datetimeold = Get-Date
    #отнимаем 20 дней
    $datetimeold = $datetimeold.AddDays(-20)
    #Процесс удаления старых файлов
    ls -r $dest | Where-Object{$datetimeold -gt $_.LastWriteTime} | rm -Force
}
else {
    Write-Host "Disk is unavaible"
}