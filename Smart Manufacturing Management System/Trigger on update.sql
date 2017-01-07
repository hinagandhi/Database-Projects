USE SmartManufacturing
GO
/****** Object:  Trigger [dbo].[TestPeakValueTrigger1]    Script Date: 03-12-2015 21:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter TRIGGER [dbo].[UpdateTrigger]
ON SmartManufacturing.[dbo].[Department]
after UPDATE
AS
begin
SET NOCOUNT ON;
declare @departmentID int
declare @departmentName varchar(45)
select @departmentID = inserted.departmentID from inserted
if update(departmentName)
begin
set @departmentName = (select Department.DepartmentName from department where DepartmentID = @departmentID)
update DepartmentAcquiresDataFromSensor set departmentName = @departmentName where DepartmentID = @departmentID  
end
end
