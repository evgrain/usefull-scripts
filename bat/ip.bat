@echo off
chcp 1251
netsh interface ip show config
set /p na=Interface: 
set /p n=192.168.11.
set d1=8.8.8.8
set d2=8.8.4.4
netsh interface ip set address name="%na%" static 192.168.11.%n% 255.255.255.0 192.168.11.1 1
netsh interface ip set dnsservers "%na%" static "%d1%"
netsh interface ip add dnsservers "%na%" "%d2%"
pause