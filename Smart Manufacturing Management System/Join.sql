--- inner join
---displaying data of all sensors with their respective machineries aNd output of every sensor
use SmartManufacturing
go
select sensor.sensorID, sensor.machineryID, machinery.mahineryType, datafromsensor.heatLevel,
datafromsensor.liquidlevel, datafromsensor.mixingspeedrate, datafromsensor.chemicalcomposition,
datafromsensor.energyconsumption, datafromsensor.timestamps, datafromsensor.failure from sensor
inner join machinery on sensor.machineryID = machinery.machineryID inner join datafromsensor on
sensor.sensorID = datafromsensor.sensorID

---left join
---displaying every factory of a pharmaceutical industry and their respecive warehouses
use SmartManufacturing
go
select factory.factoryID ,factory.factorystreet,factory.factorycity,factory.factorystate,factory.factoryzipcode,
warehouse.warehouseID from factory left join warehouse on factory.factoryID 
= warehouse.factoryID
 
--right join
--displaying every machinery of factories and what batch numbers each machinery of factory has produced
use SmartManufacturing
go
select machinery.machineryID,Machinery.factoryID, Machinery.mahineryType, machineProducesDrugs.batchNumber  from  machineProducesDrugs
right join Machinery on machinery.machineryID = machineProducesDrugs.machineryID 

--full join
--displaying all machineries with all batch numbers and displaying all
-- warehouses where drugs are kept 
use SmartManufacturing
go
select Machinery.machineryID, Machinery.factoryID, machineProducesDrugs.batchNumber, Drug.drugName,
drug.manufacturedDate, Drug.warehouseID from Machinery full join machineProducesDrugs on machinery.machineryID = machineProducesDrugs.machineryID
 full join drug on drug.batchNumber =
machineProducesDrugs.batchNumber full join warehouse on drug.warehouseID = warehouse.warehouseID

--cross join
--displaying all factories with their respective machineries
use SmartManufacturing
go
select factory.factoryID, factory.factoryCity, Machinery.machineryID, Machinery.mahineryType
from Factory cross join Machinery where factory.factoryID = machinery.factoryID order by Factory.factoryID

--displaying drugs with their respective machineries
use SmartManufacturing
go
select drug.batchNumber, drug.drugName, machineProducesDrugs.machineryID, machinery.mahineryType from
drug cross join machineProducesDrugs cross join Machinery where drug.batchNumber = machineProducesDrugs.batchNumber
and Machinery.machineryID =machineProducesDrugs.machineryID
