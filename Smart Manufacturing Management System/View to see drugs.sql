use SmartManufacturing
go
create view  SimpleSelectView as
select * from drug where quantity > 800

go

select * from SimpleSelectView

