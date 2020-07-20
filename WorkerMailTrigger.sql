--tworzenie maila po dodaniu pracownika Trigger
alter trigger WorkerMail on Worker AFTER INSERT
AS
BEGIN
declare
@addedID int

create table #tempData(id int identity,name nvarchar(50),surname nvarchar(100))
insert into #tempData(name,surname) select first_name_w, last_name_w from inserted
--select @addedID=SCOPE_IDENTITY()
select @addedID=max(id_worker) from Worker
update Worker set worker_mail= CONCAT(LOWER(name),LOWER(surname),'@shelter.pl') from #tempData where id_worker=@addedID
END
GO



update Worker set worker_mail=null

create trigger showP on Worker AFTER insert
as
begin
select * from inserted
end
GO

insert into Worker (first_name_w,last_name_w,id_worksite,salary) values ('Tomasz','Ochociniak',2,4500)


insert into Worker(first_name_w,last_name_w,id_worksite,salary) values ('Marlena','Agreszczak',3,4500)

select * from Worker