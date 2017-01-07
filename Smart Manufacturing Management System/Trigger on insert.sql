use SmartManufacturing
GO
/****** Object:  Trigger [dbo].[PeakVitalTrigger]    Script Date: 12/9/2015 12:07:29 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter TRIGGER [dbo].[AlertTrigger]
ON [SmartManufacturing].[dbo].[DatafromSensor]
after INSERT
AS BEGIN
declare @sensorID INT
declare @departmentID_mechanical int
declare @departmentID_electrical int
declare @departmentID_chemical int
declare @departmentI_finance int
declare @departmentName_mechanical varchar(45)
declare @departmentName_electrical varchar(45)
declare @departmentName_chemical varchar(45)
declare @departmentName_finance varchar(45)
declare @heatLevel float
declare @liquidLevel float
declare @mixingSpeedRate float
declare @chemicalComposition float
declare @energyConsumption float
declare @timestamps datetime
declare @failure int
declare trigger_alert cursor for
select sensorID from inserted
print @sensorID
set @departmentID_mechanical = (select departmentID from department where DepartmentName = 'Mechanical Department')
set @departmentID_chemical = (select departmentID from department where DepartmentName = 'Chemical Department')
set @departmentID_electrical = (select departmentID from department where DepartmentName = 'Electrical Department')
set @departmentI_finance = (select departmentID from department where DepartmentName = 'Finance Department')
set @departmentName_mechanical = (select departmentName from department where DepartmentName = 'Mechanical Department')
set @departmentName_electrical = (select departmentName from department where DepartmentName = 'Electrical Department')
set @departmentName_chemical = (select departmentName from department where DepartmentName = 'Chemical Department')
set @departmentName_finance = (select departmentName from department where DepartmentName = 'Finance Department')
open trigger_alert
FETCH NEXT FROM trigger_alert INTO @sensorID
WHILE @@FETCH_STATUS = 0  
begin
set @heatLevel = (select heatlevel from inserted)
set @liquidLevel = (select liquidlevel from inserted)
set @mixingSpeedRate = (select mixingSpeedRate from inserted)
set @chemicalComposition = (select chemicalComposition from inserted)
set @energyConsumption = (select energyConsumption from inserted)
set @timestamps = (select timestamps from inserted) 
set @failure = (select failure from inserted)
IF (@heatLevel > 900 or @liquidLevel >80)
begin
insert into SmartManufacturing.dbo.DepartmentAcquiresDataFromSensor(DepartmentID, SensorID,heatLevel,
liquidLevel,timestamps,failure,departmentName)
values ( @departmentID_mechanical, @sensorID,@heatLevel,@liquidLevel,
@timestamps,@failure,@departmentName_mechanical)
end
 if (@energyConsumption >1500)
begin
insert into SmartManufacturing.dbo.DepartmentAcquiresDataFromSensor(DepartmentID, SensorID,energyConsumption,timestamps,failure,departmentName)
values( @departmentID_electrical, @sensorID,@energyConsumption,
@timestamps, @failure,@departmentName_electrical)
end
 if (@mixingSpeedRate > 90 or @chemicalComposition > 40)
begin
insert into SmartManufacturing.dbo.DepartmentAcquiresDataFromSensor(DepartmentID, SensorID,mixingSpeedRate,chemicalComposition,timestamps,failure,departmentName)
values( @departmentID_chemical, @sensorID,@mixingSpeedRate,@chemicalComposition,
@timestamps, @failure,@departmentName_chemical)
end
if(@heatLevel > 900 or @liquidLevel >80 or @energyConsumption >1500 or @mixingSpeedRate > 90 or @chemicalComposition > 40)
begin
insert into SmartManufacturing.dbo.DepartmentAcquiresDataFromSensor(DepartmentID, SensorID,heatLevel,liquidLevel,mixingSpeedRate,chemicalComposition,
energyConsumption,timestamps,failure,departmentName)
values( @departmentI_finance, @sensorID,@heatLevel,@liquidLevel,@mixingSpeedRate,@chemicalComposition,
@energyConsumption,@timestamps,@failure,@departmentName_finance)
end
FETCH NEXT FROM trigger_alert INTO @sensorID
end
close trigger_alert
deallocate trigger_alert
end
select * from DepartmentAcquiresDataFromSensor
