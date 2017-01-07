use ElectronicChipTattooSchema;
GO
DECLARE @NurseFName varchar(45),@NurseLName varchar(45),
 @view varchar(5000),
 @cview varchar(4096);

DECLARE Nurse_View_VS CURSOR FOR
SELECT  FirstName, LastName from Employee where EmployeeTypeID=2

OPEN Nurse_View_VS
FETCH NEXT FROM Nurse_View_VS INTO @NurseFName, @NurseLName 
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @view = 'Nurse_' + @NurseFName + @NurseLName
	print @view
	PRINT 'Working on view for ' + @NurseFName + @NurseLName
	BEGIN
		SET @cview = ('CREATE VIEW ' +@view+' AS '+
					'select p.[PatientId], 
					p.[FirstName] FROM
					dbo.Patient as p inner join
					dbo.Chip as ct on p.PatientId = ct.PatientID
					inner join dbo.Employee_Monitors_Chip as cet on ct.ChipID = cet.ChipID
					where EmployeeID IN (Select EmployeeID from dbo.Employee where FirstName =  ('''+@NurseFName+''') and LastName= ('''+@NurseLName+'''))');
		exec (@cview);
	END
	FETCH NEXT FROM Nurse_View_VS INTO @NurseFName , @NurseLName
	END   
	CLOSE Nurse_View_VS  
	deallocate  Nurse_View_VS