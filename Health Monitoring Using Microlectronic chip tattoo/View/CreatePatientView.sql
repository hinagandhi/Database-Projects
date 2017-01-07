use ElectronicChipTattooSchema
DECLARE @Patientname varchar(45), @PatientLName varchar(45), @view varchar(5000), @cview varchar(4096);
DECLARE Patient_View_VS CURSOR FOR
SELECT  FirstName, LastName from Patient 
OPEN Patient_View_VS
FETCH NEXT FROM Patient_View_VS INTO @Patientname, @PatientLName
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @view = 'patient_VS' + @Patientname + @PatientLName
    print @Patientname
    PRINT 'Working on view for' + @Patientname + @PatientLName
    BEGIN
        SET @cview = ('CREATE VIEW '+@view+' AS '+
            'select P.[PatientID] 
                   ,P.[FirstName] as PatientFirstName
                   ,vs.[HeartRate]
                   ,vs.[Temperature]
                   ,vs.[PulseRate]
                   ,vs.[RespirationRate]
                   ,vs.[TimeStamps]
                   from dbo.Patient as p inner join 
                   dbo.VitalSign as vs on p.PatientID = vs.PatientID where P.[FirstName]  = ('''+@Patientname+''') 
				   and P.[LastName]  = ('''+@PatientLName+''')');
        exec (@cview);
    END
    FETCH NEXT FROM Patient_View_VS INTO @Patientname, @PatientLName
END  
CLOSE Patient_View_VS  
deallocate  Patient_View_VS