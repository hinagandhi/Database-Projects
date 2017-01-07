USE ElectronicChipTattooSchema
GO
/****** Object:  Trigger [dbo].[TestPeakValueTrigger1]    Script Date: 03-12-2015 21:43:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
alter TRIGGER [dbo].[PeakVitalTrigger]
ON ElectronicChipTattooSchema.[dbo].[VitalSign]
after INSERT
AS BEGIN
DECLARE @patientID int

DECLARE Insert_peakVital CURSOR FOR
select PatientID from inserted
OPEN Insert_peakVital  
FETCH NEXT FROM Insert_peakVital INTO @patientID

WHILE @@FETCH_STATUS = 0   
begin

insert into ElectronicChipTattooSchema.dbo.VitalSignPeakValueMedicalHistory (PatientID,ChipID,HeartRate,Temperature,PulseRate,RespirationRate,SugarLevel,TimeStamps) 
select V.PatientID,V.ChipID, V.HeartRate,V.Temperature,V.PulseRate,V.RespirationRate,V.SugarLevel,V.TimeStamps from VitalSign as V join Patient as P on V.PatientID=P.PatientID
where not exists(select  VS.PatientID,VS.ChipID, VS.HeartRate,VS.Temperature,VS.PulseRate,VS.RespirationRate,VS.SugarLevel,VS.TimeStamps from VitalSignPeakValueMedicalHistory as VS)
and  V.PatientID= @patientID and 
((P.age < 3 and P.age > 1) and 
(HeartRate <= 70  and HeartRate>= 110 ) 
or (temperature <= 97 and Temperature>= 99)
or (RespirationRate <= 20  or RespirationRate>= 30) 
or(BloodPressure <=75 or BloodPressure>=100)
or (SugarLevel <= 100 or SugarLevel>= 200) 
or 
((P.age <= 6 and P.age >= 3) and 
(HeartRate <=  65  or HeartRate>= 110 ) 
or (temperature <= 97 and Temperature>= 99)
or (RespirationRate <= 20  or RespirationRate>= 25 ) 
or(BloodPressure <=80 or BloodPressure>=110)
or (SugarLevel <=100 or SugarLevel>= 180)) 
or
((P.age <= 12 and P.age >= 6) and 
(HeartRate <= 60   or HeartRate>= 95) 
or (temperature <= 97 and Temperature>= 99)
or (RespirationRate <= 20 or RespirationRate>= 30 ) 
or(BloodPressure <=85 or BloodPressure>=120)
or (SugarLevel <=80 or SugarLevel>=180 )) 
or
((P.age >= 13) and 
(HeartRate <= 55   or HeartRate>= 85 ) 
or (temperature <= 97 and Temperature>= 99)
or (RespirationRate <= 12 or RespirationRate>= 18 ) 
or(BloodPressure <=80 or BloodPressure >=120)
or (SugarLevel <= 70 or SugarLevel >= 140 )) ) 

print 'insertion successful';

FETCH NEXT FROM Insert_peakVital INTO @patientID
print  @patientID;
END   
CLOSE Insert_peakVital
DEALLOCATE Insert_peakVital;
end
