select w.first_name_w,w.last_name_w,ws.worksite,w.salary
from Worker as w
join Worksite as ws on ws.id_worksite=w.id_worksite
GO


create view WorkingBehaviorist
as
select w.first_name_w,w.last_name_w,ws.worksite,w.salary
from Worker as w
join Worksite as ws on ws.id_worksite=w.id_worksite
where ws.worksite='behaviorist'
go

insert into Worker (first_name_w,last_name_w,worker_mail,id_worksite,salary)
values ('Gabriela','Kaszota',null,3,4000)
GO

select * from WorkingBehaviorist