create procedure ShowDogs
@breed nvarchar(100),@gender char(1), @min_age int, @max_age int
as
begin

select D.dog_name as Name, D.gender as Gender, B.breed_name as Breed, D.history as History, D.boxID, X.age as BoxName,
DATEDIFF(YEAR,D.born,GETDATE()) as AgeNow
from Dogs as D
join DogBreed as DB on DB.id_dog=D.id_dog
join D_Breed as B on B.id_breed=DB.id_breed
join Boxes as X on X.id_box=D.boxID
where B.breed_name=@breed and D.gender=@gender and (DATEDIFF(YEAR,D.born,GETDATE()) between @min_age AND @max_age)
end;
GO


alter procedure ShowDogs
@breed nvarchar(100)=null,@gender char(1), @min_age int, @max_age int
as
begin

if @breed is not null
select D.dog_name as Name, D.gender as Gender, B.breed_name as Breed, D.history as History, D.boxID, X.age as BoxName,
DATEDIFF(YEAR,D.born,GETDATE()) as AgeNow
from Dogs as D
join DogBreed as DB on DB.id_dog=D.id_dog
join D_Breed as B on B.id_breed=DB.id_breed
join Boxes as X on X.id_box=D.boxID
where B.breed_name=@breed and D.gender=@gender and (DATEDIFF(YEAR,D.born,GETDATE()) between @min_age AND @max_age)

else
select D.dog_name as Name, D.gender as Gender, B.breed_name as Breed, D.history as History, D.boxID, X.age as BoxName,
DATEDIFF(YEAR,D.born,GETDATE()) as AgeNow
from Dogs as D
join DogBreed as DB on DB.id_dog=D.id_dog
join D_Breed as B on B.id_breed=DB.id_breed
join Boxes as X on X.id_box=D.boxID
where D.gender=@gender and (DATEDIFF(YEAR,D.born,GETDATE()) between @min_age AND @max_age)


end
GO

exec ShowDogs Husky, 'F', 1, 6