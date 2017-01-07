
use ElectronicChipTattooSchema
go
create procedure fullBackup
as
begin
BACKUP DATABASE PROJECT
TO DISK = 'D:\ProjectBackup.bak'
end
drop procedure fullBackup


