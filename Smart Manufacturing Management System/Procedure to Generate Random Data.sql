use SmartManufacturing
go
create procedure generatingDataFromSensor
as
declare @sensorID int
DECLARE db_cursor cursor for
select sensorID from sensor 
open db_cursor
FETCH NEXT FROM db_cursor INTO @sensorID
WHILE @@FETCH_STATUS = 0   
BEGIN 
insert into datafromsensor values(@sensorID,FLOOR(RAND()*(1000 - 0) + 0),FLOOR(RAND()*(100 - 0) + 0),
FLOOR(RAND()*(100 - 0) + 0),FLOOR(RAND()*(50 - 0) + 0),FLOOR(RAND()*(2000 - 100) + 100),CURRENT_TIMESTAMP,FLOOR(RAND()*(2 - 0) + 0))
FETCH NEXT FROM db_cursor INTO @sensorID
END 
CLOSE db_cursor
deallocate db_cursor
while 1=1
BEGIN
    WAITFOR DELAY '00:01:00'
    EXEC generatingDataFromSensor
select * from datafromsensor
END
drop procedure generatingDataFromSensor

