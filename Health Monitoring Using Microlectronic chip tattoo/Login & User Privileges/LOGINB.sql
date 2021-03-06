  USE ElectronicChipTattooSchema
  GO
  CREATE LOGIN B WITH PASSWORD = '1001';
  GO


  CREATE USER B FOR LOGIN B
  GO



  GRANT SELECT, INSERT, UPDATE, DELETE ON BrainWaves TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON BrainWaves FROM B


  GRANT SELECT, INSERT, UPDATE, DELETE ON VitalSignPeakValueMedicalHistory TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON VitalSignPeakValueMedicalHistory FROM B


  GRANT SELECT, INSERT, UPDATE, DELETE ON Chip TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON Chip FROM B



  GRANT SELECT, INSERT, UPDATE, DELETE ON ChipType TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON ChipType FROM B


  
  GRANT SELECT, INSERT, UPDATE, DELETE ON Department TO B

  REVOKE SELECT, INSERT, UPDATE, DELETE ON Department FROM B


  GRANT SELECT, INSERT, UPDATE, DELETE ON Department_Has_Employees TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON Department_Has_Employees FROM B



  GRANT SELECT, INSERT, UPDATE, DELETE ON Employee TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON Employee FROM B



  GRANT SELECT, INSERT, UPDATE, DELETE ON Employee_Monitors_Chip TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON Employee_Monitors_Chip FROM B



  GRANT SELECT, INSERT, UPDATE, DELETE ON Hospital TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON Hospital FROM B


  GRANT SELECT, INSERT, UPDATE, DELETE ON  Patient TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON  Patient FROM B


    
  GRANT SELECT, INSERT, UPDATE, DELETE ON  PatientType TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON  PatientType FROM B



  GRANT SELECT, INSERT, UPDATE, DELETE ON  VitalSign TO B

  REVOKE SELECT,INSERT, UPDATE, DELETE ON  VitalSign FROM B



























 
  
