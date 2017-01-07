use SmartManufacturing
go
use SmartManufacturing
GO
CREATE TABLE Factory(
factoryID int identity(1,1) not null,
factoryStreet varchar(45) not null ,
factoryCity varchar(45) not null,
factoryState varchar(45)not null,
factoryzipcode varchar(45) not null ,
factoryCountry varchar(45) not null,
primary key (factoryID)
);

CREATE TABLE Machinery(
machineryID int identity(100,1) not null,
mahineryType varchar(45) not null,
machineWeight int not null,
factoryID int not null,
primary key (machineryID),
CONSTRAINT fk_factoryID
FOREIGN KEY (factoryID)
references Factory (factoryID) 
);

CREATE TABLE Sensor(
sensorID int identity(1000,1) not null,
machineryID int not null,
primary key (sensorID),
CONSTRAINT fk_machine
FOREIGN KEY (machineryID)
references Machinery (machineryID) 
);

CREATE TABLE DataFromSensor(
sensorID int not null,
heatLevel float ,
liquidLevel float,
mixingSpeedRate float,
chemicalComposition float,
energyConsumption float,
failure varchar(45),
timestamps datetime,
primary key (sensorID,timestamps),
constraint fk_data
foreign key (sensorID)
references Sensor(SensorID)
)
CREATE TABLE warehouse
(
warehouseID int identity(10000,1),
warehouseStreet varchar(45) not null ,
warehouseCity varchar(45) not null,
warehouseState varchar(45)not null,
warehousezipcode varchar(45) not null ,
warehouseCountry varchar(45) not null,
factoryID int not null,
constraint fk_factory
foreign key (factoryID)
references factory (factoryID),
primary key (warehouseID)
);

CREATE TABLE Drug(
batchNumber int identity(10000,1) not null,
drugName varchar(45) not null,
manufacturedDate datetime not null,
quantity int not null,
warehouseID int not null,
primary key (batchNumber),
constraint fk_warehouseID
foreign key (warehouseID)
references warehouse(warehouseID)
);

CREATE TABLE machineProducesDrugs
(
machineryID int not null,
batchNumber int not null,
primary key(machineryID, batchNumber),
constraint fk_machineryID
foreign key (machineryID)
references machinery(machineryID),
constraint fk_drugID
foreign key (batchNumber)
references drug(batchNumber)
);

CREATE TABLE Department
(
DepartmentID int identity(100000,1) not null,
DepartmentName varchar(45),
factoryID int not null,
primary key(departmentID),
constraint fk_department
foreign key (factoryID)
references factory(factoryID)
);

CREATE TABLE DepartmentAcquiresDataFromSensor
(
DepartmentID int not null,
SensorID int not null,
heatLevel float,
liquidLevel float,
mixingSpeedRate float,
chemicalComposition float,
energyConsumption float,
timestamps datetime not null,
failure int,
primary key (departmentID, SensorID,timestamps),
constraint fk_departmentID
foreign key (departmentID)
references department(departmentID),
constraint fk_sensorID
foreign key (sensorID)
references sensor(sensorID)
);

CREATE UNIQUE INDEX index_sensor
on DataFromSensor (SensorID, timestamps)

--inserting into Factory Table
use SmartManufacturing
go
insert into Factory (factoryStreet,factoryCity,factoryState,factoryzipcode,factoryCountry)
values('washington street','detroit','michigan','08906','USA'),('St. Peter street','Andover','MA','07768','USA'),
('symphony street','pearl river','New York','08906','USA');

--inserting into Machinery
use SmartManufacturing
go
insert into Machinery (mahineryType,machineWeight,factoryID) 
values('Tube filing Machinery',110,2),('Preparation Machinery',90,2),('Packing Machinery',79,2);
insert into Machinery (mahineryType,machineWeight,factoryID) 
values('Tube filing Machinery',110,1),('Preparation Machinery',90,1),('Packing Machinery',79,1);

--inserting into warehouse
use SmartManufacturing
go
insert into warehouse(warehouseStreet,warehouseCity,warehouseState,warehousezipcode,warehouseCountry,factoryID)
values('washington street','detroit','michigan','08906','USA',1),('mainland street','detroit','michigan','08996','USA',1),
('new city street','detroit','michigan','9870','USA',1);

--inserting into drug table
use SmartManufacturing
go
insert into Drug(drugName,manufacturedDate,quantity,warehouseID)
values('accupril',CURRENT_TIMESTAMP,1000,10000),('benefix',CURRENT_TIMESTAMP,7000,10000),('caverject',CURRENT_TIMESTAMP,700,10001);

--inserting into machineProducesDrugs
use SmartManufacturing
go
insert into machineProducesDrugs (machineryID, batchNumber) values (103,10000),(104,10000),(105,10001),(103,10001),
(104, 10001),(105,10000);

--inserting into department
use SmartManufacturing
go
insert into department (DepartmentName,factoryID) values ('Mechanical Department',1),('Medical Department',1),
('Electrical Department',1),('Finance Department',1),('IT department',1);

--inserting into sensor
use SmartManufacturing
go
insert into Sensor (machineryID) values (103),(104),(105);




