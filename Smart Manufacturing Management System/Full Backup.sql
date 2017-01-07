use SmartManufacturing
go
create procedure fullBackup
as
begin
BACKUP DATABASE SmartManufacturing
TO DISK = 'D:\ProjectBackup.bak'
end
drop procedure fullBackup
exec fullBackup