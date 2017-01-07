USE SmartManufacturing
GO
CREATE LOGIN Administrator WITH PASSWORD = 'admin';
GO
CREATE USER Administrator FOR LOGIN Administrator
GO
GRANT SELECT, INSERT, UPDATE, DELETE ON DataFromSensor TO Administrator 
REVOKE INSERT,UPDATE on DepartmentAcquiresDataFromSensor FROM Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON Department TO Administrator 

GRANT SELECT, INSERT, UPDATE, DELETE ON DepartmentAcquiresDataFromSensor TO Administrator 
REVOKE INSERT,UPDATE,DELETE ON DepartmentAcquiresDataFromSensor FROM Administrator 

GRANT SELECT, INSERT, UPDATE, DELETE ON Drug TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON Factory TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON machineProducesDrugs TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON Machinery TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON Sensor TO Administrator

GRANT SELECT, INSERT, UPDATE, DELETE ON warehouse TO Administrator

