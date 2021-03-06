USE [ElectronicChipTattooSchema]
GO
/****** Object:  Trigger [dbo].[PeakVitalTrigger1]    Script Date: 12/8/2015 9:45:31 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER TRIGGER [dbo].[PeakVitalTrigger1]
ON [ElectronicChipTattooSchema].[dbo].[BrainWaves]
after INSERT
AS BEGIN
declare @patientID int
DECLARE Insert_peakBrain CURSOR FOR
select PatientID from inserted
OPEN Insert_peakBrain 
FETCH NEXT FROM Insert_peakBrain INTO @patientID
WHILE @@FETCH_STATUS = 0   
BEGIN  
insert into BrainWavesPeakValueMedicalHistory (PatientID, ChipID, Alpha,Beta,Gama,Theta,Delta,TimeStamps)
select b.PatientID,b.ChipID, b.Alpha,b.Beta,b.Gama,b.Theta,b.Delta,b.TimeStamps 
from BrainWaves as b join Patient as P on P.PatientID= b.PAtientID where
not exists(select  bs.PatientID,bs.ChipID, bs.Alpha,bs.Beta,bs.Gama,bs.Theta,bs.Delta,bs.TimeStamps from BrainWavesPeakValueMedicalHistory as bs)
and  b.PatientID= @patientID and ( (b.Alpha <= 11 and b.Alpha>= 10) 
or(b.Beta >= 16 and b.Beta <=20) 
or (b.Theta >4 and b.theta <7) 
or (b.Delta >= 2 and b.delta <3) 
or (b.Gama >=31) )

FETCH NEXT FROM Insert_peakBrain INTO @patientID
print  @patientID;
END  
CLOSE Insert_peakBrain
DEALLOCATE Insert_peakBrain;
end