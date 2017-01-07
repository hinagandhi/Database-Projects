use SmartManufacturing
declare
 @departmentName varchar(45),
  @departmentID int
 ,@view varchar(5000)
 ,@view1 varchar(4096);
declare Department_View cursor for
select DepartmentID, DepartmentName from Department where DepartmentID in (select DepartmentID from
DepartmentAcquiresDataFromSensor )
open Department_View 
fetch next from Department_View into @departmentID, @departmentName
WHILE @@FETCH_STATUS = 0
BEGIN
SET @view =  'DepartmentName'+ @departmentName
print @view
begin
SET @view1 = ('CREATE VIEW ' +@view+' AS '+
                     (   'select d.[departmentID],  
                         d.[SensorID], d.[heatLevel], d.[liquidLevel],
						d.[mixingSpeedRate], d.[chemicalComposition], d.[energyConsumption],
						d.[timestamps], d.[failure,departmentName] FROM
                        dbo.departmentAcquiresDataFromSensor as d
                        where d.[departmentID] IN (Select e.[departmentID] from dbo.department as e where e.[DepartmentName] =  ('''+@departmentName +'''))'));
 exec (@view1);
 END
    FETCH NEXT FROM Department_View  INTO @departmentID, @departmentName
    END  
    CLOSE Department_View 
    deallocate  Department_View 