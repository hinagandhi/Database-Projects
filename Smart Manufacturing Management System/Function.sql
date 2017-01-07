--Comparison Function/Control of Flow Function
-- comparing weight of every machinery type and if machinery type has weight greater than 100 then it is
--categorized as heavy machinery else light machinery
use SmartManufacturing
go
declare @machineType varchar(45)
declare @quantity int
declare db_cursor_categorizingMachines cursor for
select distinct MahineryType from Machinery
open db_cursor_categorizingMachines
FETCH NEXT FROM db_cursor_categorizingMachines INTO @machineType
WHILE @@FETCH_STATUS = 0 
begin
set @quantity = (select distinct machinery.machineWeight from machinery where machinery.mahineryType = @machineType)
if(@quantity > = 100)
begin
select distinct machinery.mahineryType, machinery.machineWeight, 'Heavy machinery' as 'Machine Category'  from machinery where
machinery.mahineryType = @machineType
end
else
select distinct machinery.mahineryType, machinery.machineWeight, 'Light machinery' as 'Machine Category' from machinery where
 machinery.mahineryType = @machineType
FETCH NEXT FROM db_cursor_categorizingMachines INTO @machineType
END
close db_cursor_categorizingMachines
deallocate db_cursor_categorizingMachines