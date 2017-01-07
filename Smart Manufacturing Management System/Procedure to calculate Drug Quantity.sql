use SmartManufacturing
go
create procedure DrugQuantitycalculation @drugName varchar(45)
as
declare @warehouseID int
declare @quantity int
declare db_cursor_callingFunction cursor for
select distinct warehouse.warehouseID from warehouse join Drug on warehouse.warehouseID = Drug.warehouseID and 
drug.drugName = @drugName
open db_cursor_callingFunction 
fetch next from db_cursor_callingFunction into @warehouseID
WHILE @@FETCH_STATUS = 0   
begin
select distinct @drugName as drugName, @warehouseID as WarehouseID, warehouse.factoryID, 
dbo.drugQuantity(@drugName, @warehouseID) as TotalQuantity from
drug join warehouse on drug.warehouseID = warehouse.warehouseID and drug.drugName = @drugName
and drug.warehouseID = @warehouseID
fetch next from db_cursor_callingFunction into @warehouseID
END 
CLOSE db_cursor_callingFunction  
DEALLOCATE db_cursor_callingFunction

exec DrugQuantitycalculation @drugName = 'accupril'
