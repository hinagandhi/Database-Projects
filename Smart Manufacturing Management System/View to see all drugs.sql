use SmartManufacturing
go
Create view DrugsInWarehouse as
select factory.factoryID, warehouse.warehouseID,
drug.batchNumber, drug.drugName from Factory join
warehouse on Factory.factoryID = warehouse.factoryID join
drug on Drug.warehouseID = warehouse.warehouseID
and factory.factoryID = '1' 
go
select * from DrugsInWarehouse
drop view DrugsInWarehouse 