use DogoHomeDiana
--young 0-3, middle-aged 4-7, old 7+

select * from D_Breed

insert into Dogs
values ('Amica','F','A1',isnull('Found on the street','no information'),DATEADD(MONTH,-12,GETDATE()),null,'20170316',DATEDIFF(YEAR,'20170316',GETDATE())),
('Amigo','M','B1',isnull('Taken away from the owner','no information'),DATEADD(Day,-381,GETDATE()),null,'20110507',DATEDIFF(YEAR,'20110507',GETDATE()))

insert into DogBreed values (6,9),(7,10)

update Dogs set boxID='A1' where dog_name='Taco'

select d.id_dog,d.dog_name,d.gender,d.history,d.age,d.boxID,b.id_breed,b.breed_name
from Dogs as d
join DogBreed as DB on DB.id_dog=d.id_dog
join D_Breed as b on b.id_breed=DB.id_breed


execute ShowDogs @breed='Collie',@gender='F',@min_age=1,@max_age=8;