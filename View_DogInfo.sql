create view DogInfo(Name,Gender,Box,Hello,Breed,Size)
as
select d.dog_name,d.gender,d.boxID,d.hello,D_B.breed_name,ISNULL(D_B.size,'no info')
from Dogs as d
join DogBreed as DB on d.id_dog=DB.id_dog
join D_Breed as D_B on D_B.id_breed=DB.id_breed
GO

insert into Dogs values ('Aston','M','B1',null,GETDATE()-10,null)

insert into DogBreed values (2,6)

select * from DogInfo