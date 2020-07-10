use DogoHomeDiana

create table D_Breed(
	id_breed int primary key identity,
	breed_name nvarchar(100) not null
)
GO

insert into D_Breed (breed_name)
values ('Akita'),('Alaskan malamute'),('American staffordshire terrier'),('Beagle-harrier'),('Border collie'),('Hokkaido'),('Husky'),
('Jack russel terrier'),('Collie'),('Belgian Shepherd'),('Croatian Shepherd')
GO


create table Size(
	id_size char(10) primary key,
	size char(10) not null,
	weightKG decimal null
)
GO

insert into Size values ('VS','very small',null),('S','small',null),('M','medium',null),
('B','big',null),('VB','very big',null)
GO
--drop table Size

alter table D_Breed add size char(10)
alter table D_Breed add constraint BreedSizeFK foreign key (size) references Size(id_size)

create table Boxes(
	id_box char(10) primary key,
	dog_amount int null,
)
GO

alter table Boxes add age varchar(15) not null
GO

insert into Boxes values ('A1',null,'young'),('A2',null,'middle-aged'),('B1',null,'old')
GO

create table Dogs(
	id_dog int primary key identity,
	dog_name nvarchar(50) not null,
	gender char(1) check(gender in ('F','M')),
	boxID char(10) references Boxes(id_box) not null,
	history nvarchar(300) null,
	hello date null,
	goodbye date null
)
GO

insert into Dogs (dog_name,gender,boxID,history,hello,goodbye)
 values ('Mocca','F','A1',null,GETDATE(),null)
 GO

create table DogBreed(
	id_dog int references Dogs(id_dog),
	id_breed int references D_Breed(id_breed),
	constraint PK_DogBreed primary key (id_dog,id_breed)
)
GO

select *
from D_Breed where breed_name='Collie'

insert into DogBreed values (1,9)
GO

select d.dog_name,d.gender,d.boxID,d.hello,D_B.breed_name,ISNULL(D_B.size,'no info')
from Dogs as d
join DogBreed as DB on d.id_dog=DB.id_dog
join D_Breed as D_B on D_B.id_breed=DB.id_breed
GO


