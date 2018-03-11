This code must be running on DNS server.
The point is to check that some server is working and if it's not, then change A record on DNS for some name

DNS.xml - this is a task for scheduller

script.ps1 - check if the 1st server ("DNS1") do not response by ICMP, then change A record and if it start response again, then bring back the original A record

scriptport.ps1 - doing the same that script.ps1 but checking response by some tcp port
