
---selecting  drugs that are having quantiy greater than 1000
use SmartManufacturing
go
select drugName, sum(quantity) as TotalQuantity from drug group by drugName having sum(quantity) > = 1000 
 order by drugname desc ;

---selecting sensors that detected than 10 failures in one day 
use SmartManufacturing
Go
select  Datafromsensor.sensorID ,sensor.machineryID , machinery.mahineryType, count(*) as TotalFailuresInOneDay
  from DataFromSensor join sensor on sensor.sensorID = datafromsensor.sensorID join machinery
  on machinery.machineryID = sensor.machineryID and timestamps >=
(DATEADD(day,-1, GETDATE())) and datafromsensor.failure = 1 group by dataFromSensor.sensorID,sensor.machineryID,machinery.mahineryType
 having count(*) >=10 order by datafromsensor.sensorID
 asc
 select * from DataFromSensor
