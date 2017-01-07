use ElectronicChipTattooSchema
DECLARE @Patientname varchar(45), @PatientLName varchar(45), @view varchar(5000), @cview varchar(4096);
DECLARE Patient_View_BS CURSOR FOR
SELECT  FirstName, LastName from Patient 
OPEN Patient_View_BS
FETCH NEXT FROM Patient_View_BS INTO @Patientname, @PatientLName
WHILE @@FETCH_STATUS = 0
BEGIN
    SET @view = 'patient_BS' + @Patientname + @PatientLName
    print @Patientname
    PRINT 'Working on view for' + @Patientname + @PatientLName
    BEGIN
        SET @cview = ('CREATE VIEW '+@view+' AS '+
            'select P.[PatientID] 
                   ,P.[FirstName] as PatientFirstName
                   ,bs.[Alpha]
                   ,bs.[Beta]
                   ,bs.[Gama]
                   ,bs.[Theta]
				   ,bs.[Delta]
                   ,bs.[TimeStamps]
                   from dbo.Patient as p inner join 
                   dbo.BrainWaves as bs on p.PatientID = vs.PatientID where P.[FirstName]  = ('''+@Patientname+''') 
				   and P.[LastName]  = ('''+@PatientLName+''')');
        exec (@cview);
    END
    FETCH NEXT FROM Patient_View_BS INTO @Patientname, @PatientLName
END  
CLOSE Patient_View_BS  
deallocate  Patient_View_BS