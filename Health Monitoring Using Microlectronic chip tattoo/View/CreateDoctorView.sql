use ElectronicChipTattooSchema;
GO
DECLARE @DoctorFName varchar(45), @DoctorLName varchar(45),
 @view varchar(5000),
 @cview varchar(4096);

DECLARE Doctor_View_VS CURSOR FOR
SELECT  FirstName, LastName from Employee where EmployeeTypeID=1

OPEN Doctor_View_VS
FETCH NEXT FROM Doctor_View_VS INTO @DoctorFName,@DoctorLName
WHILE @@FETCH_STATUS = 0
BEGIN

	SET @view = 'Doctor_' + @DoctorFName + @DoctorLName
	print @view
	PRINT 'Working on view for ' + @DoctorFName + @DoctorLName 
	BEGIN
		SET @cview = ('CREATE VIEW ' +@view+' AS '+
						'select p.[PatientId], 
						p.[FirstName] FROM
						dbo.Patient as p inner join
						dbo.Chip as ct on p.PatientId = ct.PatientID
						inner join dbo.Employee_Monitors_Chip as cet on ct.ChipID = cet.ChipID
						where EmployeeID IN (Select EmployeeID from dbo.Employee where FirstName =  ('''+@DoctorFName+''') and LastName =  ('''+@DoctorLName+'''))');
		exec (@cview);
	END
	FETCH NEXT FROM Doctor_View_VS INTO @DoctorFName, @DoctorLName 
	END   
	CLOSE Doctor_View_VS  
	deallocate  Doctor_View_VS