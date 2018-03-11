This code must be running on SQL server.

MoveBackUps.xml - this is a task for scheduller

Backup.ps1 - this script move all *.bak files from specified directory to another place, and then remove ALL files (from new place) that older then 20 days from the day when it was launch.
