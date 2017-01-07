use SmartManufacturing
go
declare @success bit = 1
 
begin transaction
begin try
save transaction savepoint1
DELETE FROM DataFromSensor 
WHERE DATEDIFF(day,getdate(),TimeStamps) < -7  
 
end try
begin catch
print 'failed';
    rollback transaction
     
    set @success = 0
end catch
 
if(@success = 1)
begin
    commit transaction
end 



