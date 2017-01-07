---displays total quantity of every drug present in every warehouse of a factory
use SmartManufacturing
go
create procedure AvailabilityStatus  @factoryID int
as
begin
select distinct drugName, 'ENOUGH STOCK' as 'Availability Status' from drug where drugName in (select drugName from drug join warehouse on  drug.warehouseID = warehouse.warehouseID join
factory on factory.factoryID = warehouse.factoryID and factory.factoryID = @factoryID group by drug.drugName
 having sum(drug.quantity) > 500
)

select distinct drugName, 'LOW STOCK' as 'Availability Status' from drug where drugName in (select drugName from drug join warehouse on  drug.warehouseID = warehouse.warehouseID join
factory on factory.factoryID = warehouse.factoryID and factory.factoryID = @factoryID group by drug.drugName
 having sum(drug.quantity) <= 500
)
end
exec AvailabilityStatus  @factoryID = '1'
