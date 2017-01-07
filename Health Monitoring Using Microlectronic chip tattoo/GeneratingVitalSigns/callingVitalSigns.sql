use ElectronicChipTattooSchema
go
create procedure callingvitalsigns1
as
declare @startTime varchar(45)
set @startTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 00:24:00')
print @startTime;
 
declare @endTime varchar(45)
set @endTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 00:26:00')
print @endTime;
while 1=1
begin
WHILE (CURRENT_TIMESTAMP < = @endTime and (CURRENT_TIMESTAMP > = @startTime))
BEGIN
print @startTime
    WAITFOR DELAY '00:00:05'
    EXEC VITALSIGNS2 
select * from VitalSign
END
end
exec callingvitalsigns1