---trigger on delete
use SmartManufacturing
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter TRIGGER [dbo].[DeleteTrigger]
ON [SmartManufacturing].[dbo].[Machinery]
for DELETE 
AS 
delete from Sensor where Sensor.machineryID in (select deleted.machineryID from deleted)
go

--removing foreign key first 
alter table [SmartManufacturing].[dbo].[Sensor] drop constraint fk_machine
delete from Machinery where machineryID = 107
---adding foreign key constraint
alter table sensor add constraint fk_machine
foreign key (machineryID)
references machinery(machineryID)
