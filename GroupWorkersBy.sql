use DogoHomeDiana
GO

select * from INFORMATION_SCHEMA.TABLES
GO

select * from Worker

select ws.worksite as [Worksite name], Count(w.id_worker) as [Amount of workers]
from Worker as w
join Worksite as ws on w.id_worksite=ws.id_worksite
group by ws.worksite
GO

create view v_AmountWorkersGroup 
as
select ws.worksite as [Worksite name], Count(w.id_worker) as [Amount of workers]
from Worker as w
join Worksite as ws on w.id_worksite=ws.id_worksite
group by ws.worksite
GO

select * from v_AmountWorkersGroup

