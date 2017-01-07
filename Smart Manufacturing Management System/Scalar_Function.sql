--Scalar Function (user defined function)
---getting total quantity of particular drug in a warehouse
use SmartManufacturing
go
create function drugQuantity (@drugName varchar(45), @warehouseID int)
returns int
as
begin
declare @quantity int
select @quantity = sum(drug.quantity) 
from drug where drug.drugName = @drugName
and drug.warehouseID = @warehouseID group by drug.drugName;
IF (@quantity IS NULL) 
SET @quantity = 0;
RETURN @quantity;
end;




