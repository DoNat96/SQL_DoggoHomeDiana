use AdventureWorks2014
select * from INFORMATION_SCHEMA.TABLES

exec sp_help Sales

select * from Person.Person

--pivot po dacie modyfikacji ilosc zmodyfikowanych

select distinct year(ModifiedDate) as y from Person.Person order by y asc

select *
from (select BusinessEntityID,PersonType,year(ModifiedDate) as MD from Person.Person) as Src
pivot(count(BusinessEntityID) for MD in([2006],[2007],[2008],[2009],[2010])) as Pvt

--po tytulach
select *
from (select Title as T, year(ModifiedDate) as MD from Person.Person) as src
pivot (count(T) for MD in ([2006],[2007],[2008],[2009],[2010])) as Pvt

use ExerciseModule


create type year from smallint

create table Books(
	id_book int primary key identity,
	title nvarchar(200) not null,
	author_name nvarchar(150) not null,
	author_surname nvarchar(150) not null,
	book_year year not null
)
GO

create procedure AddBook
@title nvarchar(200), @aut_n nvarchar(150), @aut_s nvarchar(150),@year year
as
declare 
@am int
begin
select @am=count(*) from Books where (title=@title and author_name=@aut_n and author_surname=@aut_s and book_year=@year)
if (@am <> 1)
begin
insert into Books values(@title,@aut_n,@aut_s,@year)
end
else
print ('That book is in the database')
end
GO

exec AddBook 'Miecz przeznaczenia','Andrzej','Sapkowski',1993
GO


select book_year as [year],count(id_book) as cnt
from Books
group by ROLLUP (book_year)


--select * from Books

--ile ksiazek wdannym roku transponowane
select 'Amount of books',[1990],[1991],[1992],[1993]
from (select id_book, book_year as y from Books) as Src
PIVOT (count(id_book) for y in ([1990],[1991],[1992],[1993])) as Pvt

--ile ksiazek danego autora w danym roku 
select concat(author_name,author_surname) as Author,book_year as BookYear, count(*)
from Books
group by concat(author_name,author_surname),book_year
order by book_year,concat(author_name,author_surname)

select concat(author_name,' ',s1) as Name_Surname,[1990],[1991],[1992],[1993]
from (select author_name, author_surname as s,author_surname as s1,book_year from Books) as src
pivot(count(s) for book_year in ([1990],[1991],[1992],[1993])) as Pvt

