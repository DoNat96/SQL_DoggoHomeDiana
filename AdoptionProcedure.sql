use DogoHomeDiana
GO

create type phone from varchar(12) 

alter table Adoption add phone phone
alter table Adoption add adoption_date date not null
alter table Adoption add owner_mail varchar(100) not null
alter table Adoption add dog_name nvarchar(50) not null
GO

--adoption procedure: by dog name, boxID, breed
--give 3 information, find out if there is that dog, if not give 'there is not that dog'
--if ok:
-- transaction, no possibility to change names or to delete or insert dog -> isolation level: serializable
-- delete from Dogs, insert dog_id, owner_name, owner_surname, owner_phone, mail into table Adoption

alter procedure Adopt
@dog_name varchar(50), @boxID char(10), @breed nvarchar(100), @owner_name nvarchar(80), @owner_surname nvarchar(100), @city nvarchar(100),
@owner_phone phone
as
begin

begin transaction
set transaction isolation level serializable

declare
@dogID int, @o_mail nvarchar(150), @cityID int, @adoption_date date, @city_exist int, @possible date

set @adoption_date=GETDATE()

select @cityID=id_city
from City where city_name=@city

set @o_mail=CONCAT(LOWER(@owner_name),LOWER(@owner_surname),'@shelterDiana.adoption.pl')

select @dogID=D.id_dog 
from Dogs as D 
join DogBreed as DB on DB.id_dog=D.id_dog
join D_Breed as B on B.id_breed=DB.id_breed
where D.dog_name=@dog_name and B.breed_name=@breed and D.boxID=@boxID

select @possible=goodbye from Dogs where id_dog=@dogID

if @dogID is not null and @possible is null 
begin
insert into Adoption(id_pies,box,owner_name,owner_surname,City,phone,adoption_date,owner_mail,dog_name)
values(@dogID,@boxID,@owner_name,@owner_surname,@cityID,@owner_phone,@adoption_date,@o_mail,@dog_name)
 
--delete from DogBreed where id_dog=@dogID
--delete from Dogs where id_dog=@dogID

	select @city_exist=count(city_name)
	from City where city_name=@city
	if @city_exist > 0 print('This city is in the table')
	else
	begin
		insert into City(city_name) values(@city)
		print('New city added to table City')
	end

update Dogs set goodbye=@adoption_date where id_dog=@dogID

end

else
begin
print('There is no dog which you are looking for')
end

commit
end 

GO

-- anomalia przy usuwaniu z Dogs, konflikt z kluczem obcym w tabeli adoption, poprawiono na inne dzia³anie

select * from Dogs as d left outer join DogBreed as DB on d.id_dog=DB.id_dog join D_Breed as B on B.id_breed=DB.id_breed

select * from D_Breed
select * from DogBreed
select * from Boxes
select * from City

select * from Adoption

insert into City values ('Cracow'),('Bielsko-Bia³a'),('Poznañ'),('Toruñ')
insert into DogBreed(id_dog,id_breed) values (3,7)

truncate table Adoption

execute Adopt @dog_name='Fizzy',@boxID='A1',@breed='Husky',@owner_name='Mateusz', @owner_surname='Matuszewski',@city='Poznañ',@owner_phone='589698235'
