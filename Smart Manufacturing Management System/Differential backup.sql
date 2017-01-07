use SmartManufacturing
go
create procedure takingDifferentialBackUp
as
declare @startTime varchar(45)
set @startTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 21:47:00')
declare @endTime varchar(45)
set @endTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 21:55:00')
while 1=1
begin
WHILE (CURRENT_TIMESTAMP < = @endTime and (CURRENT_TIMESTAMP > = @startTime))
BEGIN
BACKUP DATABASE SmartManufacturing
TO DISK='D:\ProjectBackup1.bak'
WITH DIFFERENTIAL
END
end
exec takingDifferentialBackUp
drop procedure takingDifferentialBackUp