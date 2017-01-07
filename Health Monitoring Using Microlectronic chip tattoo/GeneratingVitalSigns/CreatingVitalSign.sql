use ElectronicChipTattooSchema
go
create procedure [dbo].vitalsigns2
as
DEclare @chipid int
declare @patientID int
DECLARE db_cursor1 CURSOR FOR 
SELECT chipID
FROM Chip
WHERE ChipTypeID = (SELECT ChipTypeID FROM ChipType WHERE ChipType = 'VitalSigns')
OPEN db_cursor1   
FETCH NEXT FROM db_cursor1 INTO @chipid
WHILE @@FETCH_STATUS = 0   
BEGIN  
  set @patientid = (select chip.PatientID from Chip where chip.ChipID = @chipid)
  INSERT INTO VitalSign  VALUES(@patientID,@chipid,FLOOR(RAND()*(160 - 50 ) + 50),(RAND()*(98.6 -1 ) + 1),FLOOR(RAND()*(50 - 12) + 12),FLOOR(RAND()*(50-12) + 12),FLOOR(RAND()*(120 - 80 ) + 80),FLOOR(RAND()*(126-70) + 70), Convert(Varchar,GETDATE(),20));  
  FETCH NEXT FROM db_cursor1 INTO @chipid
 
END  
CLOSE db_cursor1   
DEALLOCATE db_cursor1

exec vitalsigns2
   