------------------ I am adjusting the artist names to include a band name.
----------- If the artist name is the band name, I will find a band member's name and use that.
----------- If the artist is a solo artist, I will use their first and last name as the band name.

--drop the database if it exists
if db_id('disk_inventory') is not null
	drop database disk_inventory
go

--create the database
create database disk_inventory
go

--use the database
use disk_inventory
go

-- create the tables
create table Status
(
	status_ID	int	not null	identity	primary key,
	status	varchar(15)	not null
);
go
create table Disk
(
	disk_ID	int	not null	identity	primary key,
	disk_name	varchar(100) not null	unique,
	genre	varchar(100) not null,
	release_date	date not null,								-- changing this data type to date
	disk_type	varchar(100) not null,
	status_ID	int not null	references Status(status_ID)
);
go
create table ArtistInfo
(
	artist_ID	int	not null	identity	primary key,
	artist_FirstName	varchar(100)	not null,
	artist_LastName	varchar(100)	not null,
	artist_band	varchar(50)	not null,
	artist_type	varchar(15)	not null
);
go
create table DiskHasArtist
(
	disk_has_artist_ID	int	not null	identity	primary key,	-- created a PK for the disk has artist table
	disk_ID	int not null	references Disk(disk_ID),
	artist_ID	int	not null	references ArtistInfo(artist_ID)
);
go
create table BorrowerInfo
(
	borrower_ID	int	not null	identity	primary key,
	borrower_first_name	varchar(100)	not null,
	borrower_last_name	varchar(100)	not null,
	borrower_phone_number	varchar(14)	not null
);
go
create table DiskHasBorrower
(
	borrowed_session_ID	int	not null	identity	primary key,
	borrowed_date	date	not null,
	returned_date	date,											--marked returned_date to allow null
	borrower_ID	int	not null	references BorrowerInfo(borrower_ID),
	disk_ID	int	not null	references Disk(disk_ID)
);
go

-- insert data into the tables

-- use the database
use disk_inventory
go

-- Insert into the status table
insert into Status
	(
		status
	)
	values
		('Borrowed'), 
		('In Inventory');
go

--insert into the Disk table
insert into Disk
	(
		disk_name,
		genre,
		release_date,
		disk_type,
		status_ID
	)
	values
		('POST-','Punk Rock','2018-02-02','CD', 2),
		('Ephorize', 'Hip Hop', '2018-02-05', 'CD', 2),
		('Avatar Country', 'Groove Metal', '2018-02-22', 'CD', 2),
		('Wrong Creatures', 'Metal', '2018-02-22', 'CD', 2),
		('Vale', 'Glam Metal', '2018-02-22', 'CD', 2),
		('Blue Madonna', 'Pop', '2018-02-22', 'CD', 2),
		('What Happens Next', 'Instrumental Rock', '2018-02-22', 'CD', 2),
		('Country Music Made Me Do It', 'Country', '2018-02-22', 'CD', 2),
		('Underworld', 'Alternative Rock', '2018-02-22', 'CD', 1),
		('Pounding the Pavement', 'Heavy Metal', '2018-02-25', 'CD', 2),
		('Mania', 'Pop Rock', '2018-02-25', 'CD', 2),
		('Culture II', 'Hip Hop', '2018-02-25', 'CD', 2),
		('Future', 'Future House', '2018-02-25', 'CD', 2),
		('Day69', 'Trap', '2018-02-23', 'CD', 2),
		('Bobby Tarantino II', 'Hip Hop', '2018-03-09', 'CD', 2),
		('Seasons Change', 'Country', '2018-03-26', 'CD', 2),
		('Boarding House Reach', 'Blues Rock', '2018-03-23', 'CD', 1),
		('Lost & Found', 'Country', '2018-03-28', 'CD', 2),
		('Virtue', 'Neo-psychodelia', '2018-03-30', 'CD', 2),
		('Where''s the Drop?', 'Classical', '2018-03-30', 'CD', 2);
go

-- insert into the ArtistInfo table
insert into ArtistInfo
	(
		artist_FirstName,
		artist_LastName,
		artist_band,
		artist_type
	)
	values
		('Jeff', 'Rosenstock', 'Jeff Rosenstock', 'Solo'),
		('Elizabeth', 'Harris', 'Cupcakke', 'Solo'),
		('Johannes', 'Echerstrom', 'Avatar', 'Band'),
		('Peter', 'Hayes', 'Black Rebel Motorcycle Club', 'Band'),
		('Johnny', 'Herold', 'Black Veil Brides', 'Band'),
		('Garrett', 'Borns', 'Borns', 'Solo'),
		('Joe', 'Satriani', 'Joe Satriani', 'Solo'),
		('Meghan', 'Patrick', 'Meghan Patrick', 'Solo'),
		('Jenna', 'McDougall', 'Tonight Alive', 'Band'),
		('Rob', 'Reiner', 'Anvil', 'Band'),
		('Patrick', 'Stump', 'Fall Out Boy', 'Band'),
		('Kirshnik', 'Ball', 'Migos', 'Band'),
		('Don', 'Diablo', 'Don Diablo', 'Solo'),
		('Daniel', 'Hernandez', '6ix9ine', 'Solo'),
		('Robert', 'Hall', 'Logic', 'Solo'),
		('Scotty', 'McCreery', 'Scotty McCreery', 'Solo'),
		('Jack', 'White', 'Jack White', 'Solo'),
		('Troy', 'Cassar-Daley', 'Troy Cassar-Daley', 'Solo'),
		('Julian', 'Casablancas', 'The Voidz', 'Band'),
		('Joel', 'Zimmerman', 'Deadmau5', 'Solo');
go

--insert into the DiskHasArtist table
insert into DiskHasArtist
	(
		disk_ID,
		artist_ID
	)
	values
		(1, 1),
		(2, 2),
		(2, 3),
		(3, 4),
		(4, 4),
		(5, 5),
		(6, 6),
		(7, 7),
		(8, 8),
		(9, 8),
		(10, 9),
		(11, 10),
		(12, 12),
		(13, 13),
		(14, 14),
		(15, 15),
		(15, 11),
		(16, 16),
		(17, 17),
		(18, 18),
		(19, 19),
		(20, 20);
go

-- insert into the BorrowerInfo table
insert into BorrowerInfo
	(
		borrower_first_name,
		borrower_last_name,
		borrower_phone_number
	)
	values
		('Anthony', 'Armfield', '208-539-7916'),
		('Stephanie', 'Armfield', '208-421-7752'),
		('Mike', 'Larsen', '208-546-7845'),
		('Mike', 'Mitchell', '208-565-3256'),
		('Melissa', 'Mitchell', '208-325-6647'),
		('Mike', 'Parker', '208-784-5623'),
		('Genee', 'Parker', '208-784-3265'),
		('John', 'Baldauf', '208-342-2201'),
		('Brandon', 'Walters', '208-924-7619'),
		('Carolyn', 'Osario', '208-924-4612'),
		('Carry', 'Carmody', '208-924-8523'),
		('Sherriel', 'Cavelli', '208-433-8666'),
		('Brock', 'Tincher', '208-432-6598'),
		('Elizabeth', 'Tincher', '208-432-6599'),
		('Lori', 'Dickson', '208-528-8857'),
		('Howard', 'Dickson', '208-528-8858'),
		('Becky', 'Vasquez', '208-423-5497'),
		('Brooke', 'Vasquez', '208-423-5492'),
		('Todd', 'Cheney', '208-830-8730'),
		('Jeff', 'Powell', '208-697-1345'),
		('Jenny', 'Powell', '208-697-1345'),
		('Stephanie', 'Powell', '208-697-2357');
go

--Insert into the DiskHasBorrower table
insert into DiskHasBorrower
	(
		borrowed_date,
		returned_date,
		borrower_ID,
		disk_ID
	)
	values
		('10-10-2018', '10-14-2018', 1, 1),
		('10-10-2018', '10-14-2018', 1, 2),
		('10-10-2018', '10-14-2018', 4, 1),
		('10-10-2018', '10-11-2018', 3, 3),
		('10-10-2018', '10-14-2018', 5, 4),
		('10-10-2018', '10-14-2018', 6, 5),
		('10-10-2018', '10-14-2018', 7, 6),
		('10-10-2018', '10-14-2018', 8, 7),
		('10-10-2018', '10-14-2018', 9, 8),
		('10-10-2018', NULL, 10, 9),
		('10-10-2018', '10-14-2018', 11, 10),
		('10-10-2018', '10-14-2018', 12, 11),
		('10-10-2018', '10-14-2018', 13, 12),
		('10-10-2018', '10-14-2018', 14, 13),
		('10-10-2018', '10-14-2018', 15, 14),
		('10-10-2018', '10-14-2018', 16, 15),
		('10-10-2018', NULL, 17, 17),
		('10-12-2018', '10-14-2018', 3, 3),
		('10-10-2018', '10-14-2018', 18, 18),
		('10-10-2018', '10-14-2018', 20, 19),
		('10-10-2018', '10-14-2018', 21, 20);
go


--Additional Queries!!!

--Query to list all disks that have not been returned
select borrower_ID as 'Borrower ID', disk_ID as 'Disk ID', borrowed_date as 'Borrowed Date', returned_date as 'Return Date' from DiskHasBorrower
where returned_date is null
go

-- updating 1 row with a where clause in the Disk table
update Disk
set genre = 'Country'
where disk_ID = 12
go

-- deleting 1 row using the where clause from the borrower table
delete from BorrowerInfo
where borrower_ID = 22

use disk_inventory
go

---------------- end of project 3 info and adjustments, start of project 4
--3 showing disks by individual artists, not bands
select disk_name, release_date, artist_FirstName, artist_LastName
from Disk
	join DiskHasArtist on Disk.disk_ID = DiskHasArtist.disk_ID
	join ArtistInfo on DiskHasArtist.artist_ID = ArtistInfo.artist_ID
where artist_type = 'Solo'
order by artist_LastName, artist_FirstName, disk_name
go

--4 creating a view for artists that are solo and not band
create view View_Individual_Artist as
	select artist_FirstName, artist_LastName, artist_ID
	from ArtistInfo
	where artist_type = 'Solo'
go
select artist_FirstName, artist_LastName from View_Individual_Artist

--5 showing disk and artist info based on bands
select disk_name, release_date, artist_band
from Disk
	join DiskHasArtist on Disk.disk_ID = DiskHasArtist.disk_ID
	join ArtistInfo on DiskHasArtist.artist_ID = ArtistInfo.artist_ID
where artist_type = 'Band'
order by artist_band, disk_name
go

--6 showing disks that have been borrowed (which is all of them at this point)
select borrower_first_name, borrower_last_name, disk_name, borrowed_date
from BorrowerInfo
	join DiskHasBorrower on BorrowerInfo.borrower_ID = DiskHasBorrower.borrower_ID
	join Disk on DiskHasBorrower.disk_ID = Disk.disk_ID
order by borrower_last_name, borrower_first_name, disk_name, borrowed_date
go

--7 showing the number of times a disk has been borrowed
select DiskHasBorrower.disk_ID as DiskID, disk_name as 'Disk Name', count(borrowed_session_ID) as 'Times Borrowed'
from DiskHasBorrower
	join Disk
		on DiskHasBorrower.disk_ID = Disk.disk_ID
group by DiskHasBorrower.disk_ID, disk_name
go

--8 showing the disks that are still on loan and by who
select disk_name as 'Disk Name', borrowed_date as Borrowed, returned_date as Returned, borrower_last_name as 'Last Name'
from BorrowerInfo
	join DiskHasBorrower on BorrowerInfo.borrower_ID = DiskHasBorrower.borrower_ID
	join Disk on DiskHasBorrower.disk_ID = Disk.disk_ID
where returned_date is null
order by borrower_last_name, borrower_first_name, disk_name, borrowed_date
go

-------------------End of adjustments for project 4, starting of project 5

--use the disk_inventory DB
use disk_inventory
go

---------- 3 ----------

-- 3A. --
--do a select to see the info before the update
select * from ArtistInfo
where artist_ID = '14'
go
--create the stored procedure to update a row in the table ArtistInfo
drop proc sp_UpdateArtistInfo
go
	create proc sp_UpdateArtistInfo
	(
		@artist_FirstName varchar(50),
		@artist_LastName	varchar(50),
		@artist_band	varchar(50),
		@artist_type	varchar(50),
		@original_artist_FirstName	varchar(50),
		@original_artist_LastName	varchar(50),
		@original_artist_band	varchar(50),
		@original_artist_type	varchar(50)
	)
	as
		begin
		--start error checking
			begin try
				update ArtistInfo
					set 
						artist_FirstName = @artist_FirstName,
						artist_LastName = @artist_LastName,
						artist_band = @artist_band,
						artist_type = @artist_type
				WHERE	artist_FirstName = @original_artist_FirstName
					AND artist_LastName = @original_artist_LastName
					AND artist_band = @original_artist_band
					AND artist_type = @original_artist_type
				--display the change
			end try
			begin catch
				print error_message()
			end catch
		end
	go
--execute the update stored procedure
exec sp_UpdateArtistName '14', 'Toni', 'Braxton' --passing parameters in the execute
go
-------- end of 3A. -----

-- 3B. --
--create the stored procedure to insert a row in the table ArtistInfo
create proc sp_InsertArtistInfo
	@ArtistFName varchar(100),
	@ArtistLName varchar(100),
	@ArtistBand varchar(50),
	@artistType varchar(50)
as
	begin
		begin try
		--start error checking
			insert into ArtistInfo
				(
					artist_FirstName,
					artist_LastName,
					artist_band,
					artist_type
				)
				values
					(@ArtistFName, @ArtistLName, @ArtistBand, @artistType)
				
				--selct to display the change
				select * from ArtistInfo
				where artist_FirstName = @ArtistFName
				print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
--execute the stored procedure
execute sp_InsertArtistInfo 'Cardi', 'B', 'Cardi B', 'Solo' --passing parameters in the execute
go

-------- end of 3B. -----
-- 3C. --
--create the stored procedure for deleting an artist
drop proc sp_DeleteArtistInfo
go
	create proc sp_DeleteArtistInfo
	(
		@artist_FirstName varchar(50),
		@artist_LastName	varchar(50),
		@artist_band	varchar(50),
		@artist_type	varchar(50)
	)
	as
		begin
		--start error checking
			begin try
				DELETE FROM DiskHasArtist
				FROM	DiskHasArtist INNER JOIN
						ArtistInfo ON DiskHasArtist.artist_ID = ArtistInfo.artist_ID
				WHERE	ArtistInfo.artist_FirstName = @artist_FirstName
					AND ArtistInfo.artist_LastName = @artist_LastName
					AND ArtistInfo.artist_band = @artist_band
					AND ArtistInfo.artist_type = @artist_type
				delete from ArtistInfo
				WHERE	artist_FirstName = @artist_FirstName
					AND artist_LastName = @artist_LastName
					AND artist_band = @artist_band
					AND artist_type = @artist_type
			end try
			begin catch
				print error_message()
			end catch
		end
	go
--execute the stored procedure
exec sp_DeleteArtistInfo
go

------------ End of 3C. ----------------------

---------- 4 ----------
-- 4A. --
--do a select to see the info before the update
select * from BorrowerInfo
where borrower_ID = '14'
go
--create the stored procedure to update a row in the table
create proc sp_UpdateBorrowerName
	@BorrowerID int,
	@BorrowerFName varchar(100),
	@BorrowerLName varchar(100)
as
	begin
	--start error checking
		begin try
			update BorrowerInfo
				set 
					borrower_first_name = @BorrowerFName,
					borrower_last_name = @BorrowerLName
				where 
					borrower_ID = @BorrowerID
			--selct to display the change
			select * from BorrowerInfo
			where borrower_ID = @BorrowerID
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
--execute the update stored procedure
exec sp_UpdateBorrowerName '14', 'Johnny', 'Bravo' --passing parameters in the execute
go
-------- end of 4A. -----

-- 4B. --
--create the stored procedure to insert a row in the table
create proc sp_InsertBorrowerInfo
	@BorrowerFName varchar(100),
	@BorrowerLName varchar(100),
	@BorrowerPhone varchar(14)
as
	begin
		begin try
			insert into BorrowerInfo
				(
					borrower_first_name,
					borrower_last_name,
					borrower_phone_number
				)
				values
					(@BorrowerFName, @BorrowerLName, @BorrowerPhone)
			--selct to display the change
			select * from BorrowerInfo
			where borrower_first_name = @BorrowerFName
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
-- execute the stored procedure
execute sp_InsertBorrowerInfo 'Timmy', 'Johnson', '208-771-3549' --passing parameters in the execute
go
-------- end of 4B. -----
-- 4C. --
--create the stored procedure for deleting a borrower
create proc sp_DeleteBorrowerInfo
	@BorrowerID int
as
	begin
		begin try
			delete from DiskHasBorrower
				where borrower_ID = @BorrowerID
			delete from BorrowerInfo
				where borrower_ID = @BorrowerID
			-- check for changes
			select * from BorrowerInfo
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
--execute the stored procedure
exec sp_DeleteBorrowerInfo '24'
go
------------ End of 4C. ----------------------

---------- 5 ----------
-- 5A. --
--do a select to see the info before the update
select * from Disk
where disk_ID = '1'
go
--create the stored procedure to update a row in the table Disk
create proc sp_UpdateDisk
	@DiskID int,
	@DiskName varchar(100)
as
	begin
		begin try
			update Disk
				set 
					disk_name = @DiskName
				where 
					disk_ID = @DiskID
			--selct to display the change
			select * from Disk
			where disk_ID = @DiskID
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
--execute the update stored procedure
exec sp_UpdateDisk '1', 'Golden' --passing parameters in the execute
go
-------- end of 5A. -----
-- 5B. --
--create the stored procedure to insert a row in the table Disk
create proc sp_InsertDiskInfo
	@DiskName varchar(100),
	@Genre varchar(100),
	@ReleaseDate smalldatetime,
	@DiskType varchar(100),
	@StatusID int
as
	begin
		begin try
			insert into Disk
				(
					disk_name,
					genre,
					release_date,
					disk_type,
					status_ID
				)
				values
					(@DiskName, @Genre, @ReleaseDate, @DiskType, @StatusID)
			--selct to display the change
			select * from Disk
			where disk_name = @DiskName
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
-- execute the stored procedure
execute sp_InsertDiskInfo 'KOD', 'Hip Hop', '2018-04-20', 'CD', 2 --passing parameters in the execute
go
-- 5C. --
--create the stored procedure for deleting a Disk
create proc sp_DeleteDisk
	@DiskID int
as
	begin
		begin try
			delete from DiskHasBorrower
				where disk_ID = @DiskID
			delete from DiskHasArtist
				where disk_ID = @DiskID
			delete from Disk
				where disk_ID = @DiskID
			-- check for the changes
			select * from Disk
			print 'Table has been updated!'
		end try
		begin catch
			print error_message()
		end catch
	end
go
--execute the stored procedure
exec sp_DeleteDisk '22'
go
