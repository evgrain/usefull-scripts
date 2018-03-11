#Путь к папке бэкапов в которую бэкапится база из SQL серрвера
$path = "C:\Backup"

#Путь к папке в которую нужно переместить бэкапы
$dest = "\\dnsORip\pathTOfolder\Backup" 

#Проверка наличия подключения диска с бэкапами SQL, в один момент времени он подключен только к одному из SQL серверов
   
$isfile = Test-Path $path
if($isfile -eq "True") {
    robocopy $path $dest *.xml /MOV
    $datetimeold = get-date
    #отнимаем 20 дней. 
    $datetimeold = $datetimeold.AddDays(-20)
    #Процесс удаления файлов, которые старше 20 дней
    ls -r $dest | Where-Object {$datetimeold -gt $_.LastWriteTime } | rm -Force
}
else {
    Write-host "Sorry Mario, but our disk is on another castle"
}