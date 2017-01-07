use ElectronicChipTattooSchema
go
create procedure BrainWaves1
as
DEclare @chipid_brain int
DECLARE @patientid int
DECLARE db_cursor2 CURSOR FOR 
SELECT chipID
FROM Chip
WHERE ChipTypeId = (select ChipTypeID from ChipType where ChipType = 'BrainWaves')
OPEN db_cursor2   
FETCH NEXT FROM db_cursor2 INTO @chipid_brain
print @patientid
WHILE @@FETCH_STATUS = 0   
BEGIN  
  set @patientid = (select chip.PatientID from Chip where chip.ChipID = @chipid_brain)
  INSERT INTO [dbo].BrainWaves  VALUES(@patientid,@chipid_brain,FLOOR(RAND()*(14 - 8 ) + 8),(RAND()*(30 -14 ) + 14),FLOOR(RAND()*(100 - 32) + 32),FLOOR(RAND()*(8-4) + 4),FLOOR(RAND()*(4-0) + 0),Convert(Varchar,GETDATE(),20))
  FETCH NEXT FROM db_cursor2 INTO @chipid_brain
 
END  
CLOSE db_cursor2   
DEALLOCATE db_cursor2
drop procedure BrainWaves1