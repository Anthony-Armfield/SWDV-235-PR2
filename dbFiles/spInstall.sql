--create the stored procedure to update a row in the table ArtistInfo
drop proc sp_UpdateArtistInfo
go
	create proc sp_UpdateArtistInfo
	(
		@artist_ID	int,
		@artist_FirstName varchar(50),
		@artist_LastName	varchar(50),
		@artist_band	varchar(50),
		@artist_type	varchar(50)
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
				WHERE	artist_ID = @artist_ID
			end try
			begin catch
				print error_message()
			end catch
		end
	go


--create the stored procedure to insert a row in the table ArtistInfo
drop proc sp_InsertArtistInfo
go
create proc sp_InsertArtistInfo
	@artist_FirstName varchar(100),
	@artist_LastName varchar(100),
	@artist_band varchar(50),
	@artist_type varchar(50)
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
					(@artist_FirstName, @artist_LastName, @artist_band, @artist_type)
		end try
		begin catch
			print error_message()
		end catch
	end
go


--create the stored procedure for deleting an artist
drop proc sp_DeleteArtistInfo
go
	create proc sp_DeleteArtistInfo
	(
		@artist_ID	int
	)
	as
		begin
		--start error checking
			begin try
				DELETE FROM DiskHasArtist
				where artist_ID = @artist_ID
				delete from ArtistInfo
				WHERE	artist_ID = @artist_ID
			end try
			begin catch
				print error_message()
			end catch
		end
	go

--create the stored procedure to update a row in the table
drop proc sp_UpdateBorrowerName
go
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

-- 4B. --
--create the stored procedure to insert a row in the table

drop proc sp_InsertBorrowerInfo
go
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

--create the stored procedure for deleting a borrower
drop proc sp_DeleteBorrowerInfo
go
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


--create the stored procedure to update a row in the table Disk
drop proc sp_UpdateDisk
go
create proc sp_UpdateDisk
	@disk_ID	int,
	@disk_name varchar(50),
	@genre varchar(100),
	@release_date datetime,
	@disk_type varchar(100),
	@status varchar(100)

as
	begin
		begin try
		declare @status_ID as int
		select @status_ID = status_ID from Status
		where status = @status;
		update Disk
			set 
				disk_name = @disk_name,
				genre = @genre,
				release_date = @release_date,
				disk_type = @disk_type,
				status_ID = @status_ID
			where 
				disk_ID = @disk_ID
		end try
		begin catch
			print error_message()
		end catch
	end
go


--create the stored procedure to insert a row in the table Disk
drop proc sp_InsertDiskInfo
go
create proc sp_InsertDiskInfo
	@disk_ID	int,
	@disk_name varchar(50),
	@genre varchar(100),
	@release_date datetime,
	@disk_type varchar(100),
	@status varchar(100)
as
	begin
		begin try
		declare @status_ID as int
		select @status_ID = status_ID from Status
		where status = @status;
		insert into Disk
			(
				disk_name,
				genre,
				release_date,
				disk_type,
				status_ID
			)
			values
				(@disk_name, @genre, @release_date, @disk_type, @status_ID)
		end try
		begin catch
			print error_message()
		end catch
	end
go


--create the stored procedure for deleting a Disk
drop proc sp_DeleteDisk
go
create proc sp_DeleteDisk
(
	@disk_ID	int
)
as
	begin
		begin try
			delete from DiskHasBorrower
				where disk_ID = @disk_ID
			delete from DiskHasArtist
				where disk_ID = @disk_ID
			delete from Disk
				where disk_ID = @disk_ID
		end try
		begin catch
			print error_message()
		end catch
	end
go
