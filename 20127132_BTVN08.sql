use master

go
if db_id('QuanLyNhaNghi') is not null
	drop database QuanLyNhaNghi
go

create database QuanLyNhaNghi

go
use QuanLyNhaNghi
go

create table PHONG
(
	MAPHONG char(4),
	TINHTRANG nvarchar(4),
	LOAIPHONG nvarchar(11),
	DONGIA int,
	constraint PK_PHONG primary key (MAPHONG),
	constraint C_TINHTRANG check (TINHTRANG in (N'Rãnh',N'Bận')),
	constraint C_LOAIPHONG check (LOAIPHONG in (N'VIP',N'Bình Thường')),
)

create table KHACHHANG
(
	MAKH char(5),
	HOTEN nvarchar(20),
	DIACHI nvarchar(100),
	DIENTHOAI char(10),
	constraint PK_KHACH primary key (MAKH),
)

create table DATPHONG
(
	MADATPHONG int,
	MAKH char(5),
	MAPHONG char(4),
	NGAYDP date,
	NGAYTRA date,
	THANHTIEN int,
)

alter table DATPHONG
add constraint FK_DATPHONG_PHONG foreign key(MAPHONG) references PHONG(MAPHONG)

alter table DATPHONG
add constraint FK_DATPHONG_KHACHHANG foreign key(MAKH) references KHACHHANG(MAKH)


insert into PHONG values ('1001',N'Rãnh',N'Bình Thường', 100000)
insert into PHONG values ('1002',N'Rãnh',N'VIP', 300000)
insert into PHONG values ('1003',N'Bận',N'Bình Thường', 100000)

insert into KHACHHANG values ('KH001',N'Nguyễn Thị Anh Thơ',N'Quận 1, TPHCM', '0978686868')
insert into KHACHHANG values ('KH002',N'Trương Anh Quân',N'Quận 2, TPHCM', '0978333333')
insert into KHACHHANG values ('KH003',N'Trần Mạnh Dũng',N'Quận 3, TPHCM', '0978909090')


--Q1
if object_id('spDatPhong','p') is not null
	drop proc spDatPhong

create procedure spDatPhong @makh char(5), @maphong char(4), @ngaydat date
AS
	--Cập nhật Mã Đặt Phòng
	declare @madatphong int = (select count(MADATPHONG) from DATPHONG)
	if (@madatphong = 0)
		set @madatphong = 1
	else
		set @madatphong = (select max(MADATPHONG) from DATPHONG) + 1
	--Kiểm tra Mã Khách Hàng
	if (
		exists(
		select *
		from KHACHHANG
		where MAKH=@makh
		)
	)
	begin
	--Kiểm tra Mã Phòng, Tình Trạng Phòng
		if (
		exists(
			select *
			from PHONG
			where MAPHONG=@maphong and TINHTRANG=N'Rãnh'
			)
		)
		begin
			insert into DATPHONG values(@madatphong,@makh,@maphong,@ngaydat,null,null)
			update PHONG set TINHTRANG=N'Bận' where MAPHONG=@maphong
			print N'Đặt Phòng Thành Công'
		end
		else
			print N'Đặt Phòng Không Thành Công'
	end
	else
		print N'Đặt Phòng Không Thành Công'

exec spDatPhong 'KH001', '1001', '2-21-2022'


--Q2
if object_id('fTinhTienPhong', N'FN') is not null
	drop function fTinhTienPhong
if object_id('spTraPhong','p') is not null
	drop proc spTraPhong
create function fTinhTienPhong (@ngaydat date, @dongia int)
returns int
as
begin
return datediff(d, @ngaydat, getdate()) * @dongia
end

create procedure spTraPhong @makh char(5), @maphong char(4)
AS
	--Tìm mã đặt phòng
	declare @madatphong int = (select count(*) from DATPHONG where MAKH=@makh and MAPHONG=@maphong)
	if (@madatphong = 0)
		print N'Mã Khách Hàng Hoặc Mã Phòng Không Hợp Lệ !!!'
	else
	begin
		set @madatphong = (select MADATPHONG from DATPHONG where MAKH=@makh and MAPHONG=@maphong)
		update PHONG set TINHTRANG=N'Rãnh' where MAPHONG=@maphong
		update DATPHONG set NGAYTRA=GETDATE() where MAPHONG=@maphong and MAKH=@makh
		update DATPHONG set THANHTIEN=dbo.fTinhTienPhong(NGAYDP,(select DONGIA from PHONG where MAPHONG=@maphong))
					where MAPHONG=@maphong and MAKH=@makh
		print N'Trả Phòng Không Thành Công'
	end
exec spTraPhong 'KH001', '1002'