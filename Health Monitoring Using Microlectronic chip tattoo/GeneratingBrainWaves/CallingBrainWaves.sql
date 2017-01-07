use ElectronicChipTattooSchema
go
create procedure callingBrainWaves1
as
declare @startTime varchar(45)
set @startTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 20:43:00')
print @startTime;
 
declare @endTime varchar(45)
set @endTime  = ((SELECT convert(varchar(10),GETDATE(),20)) + ' 20:45:00')
print @endTime;
while 1=1
begin
WHILE (CURRENT_TIMESTAMP < = @endTime and (CURRENT_TIMESTAMP > = @startTime))
BEGIN
    WAITFOR DELAY '00:00:05'
   exec BrainWaves1
select * from BrainWaves
END
end
--drop procedure callingBrainWaves1
exec callingBrainWaves1