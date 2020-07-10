create database DogoHomeDiana

USE DogoHomeDiana

create table Worksite(
	id_worksite int primary key identity,
	worksite nvarchar(100) not null
	)
GO

create table Worker(
	id_worker int primary key identity,
	first_name_w nvarchar(50) not null,
	last_name_w nvarchar(100) not null,
	worker_mail nvarchar(100),
	id_worksite int references Worksite(id_worksite) not null,
	salary money
)
GO

insert into Worksite (worksite) values ('director'),('vet'),('behaviorist'),('volunteer')
GO

select * from Worksite
GO

--set identity_insert Worker on
--go

insert into Worker (first_name_w,last_name_w,worker_mail,id_worksite,salary)
values
('Pawel','Piwczak',null,1,5000)

insert into Worker (first_name_w,last_name_w,worker_mail,id_worksite,salary)
values
('Zuzanna','Kamicz',null,3,4000),('Ewelina','Jaczko',null,2,3500)

insert into Worker (first_name_w,last_name_w,worker_mail,id_worksite,salary)
values ('Aleksander','Kaszota',null,3,4000)
GO

