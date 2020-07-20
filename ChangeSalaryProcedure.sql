create type JobKind as table (kind nvarchar(40))
GO

create table Salaries(
id_change int identity primary key,
worksite nvarchar(100) not null,
before_change int,
change int not null,
cost int
)
GO

alter procedure ChangeSalary
@work nvarchar(30), @raise int
as
begin
declare
@id_work int,
@ActualSalary int,
@Cnt int,
@amountCost int
select @id_work=id_worksite from Worksite where worksite=@work
select @ActualSalary=salary from Worker where id_worksite=@id_work
select @Cnt=count(id_worker) from Worker where id_worksite=@id_work
SET @amountCost=@raise*@Cnt
insert into Salaries(worksite,before_change,change,cost) values (@work,@ActualSalary,@raise,@amountCost)
update Worker set salary=@ActualSalary+@raise where id_worksite=@id_work

if @amountCost>0
begin
print 'wydatek'
end
else if @amountCost<0
begin
print 'przychód'
end
else print 'bez zmian'

end
go

exec ChangeSalary @work='director',@raise=100

select * from Salaries
select * from Worker
select * from Worksite
GO

