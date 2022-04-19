create database DeAnCongTy

go
use DeAnCongTy
go

create table PHONGBAN
(
	MAPHONG varchar(5),
	TENPHONG nvarchar(50),
	TRUONGPHONG nvarchar(3),
	DIADIEM nvarchar(100),
	Constraint PK_PHONGBAN primary key (MAPHONG)
)

create table DEAN
(
	MADN varchar(5),
	TENDN nvarchar(50),
	MAPHONG varchar(5),
	DIADIEM nvarchar(100),
	Constraint PK_DEAN primary key (MADN)
)

create table NHANVIEN
(
	MANV varchar(5),
	TENNV nvarchar(50),
	DIACHI nvarchar(100),
	PHAI nvarchar(3) CHECK(PHAI in ('Nam',N'Nữ')),
	LUONG int default(0),
	MAPHONG varchar(5),
	MADN varchar(5),
	QUANLY varchar(5),
	Constraint PK_NHANVIEN primary key (MANV)
)

create table NGUOITHAN
(
	MANV varchar(5),
	TEN nvarchar(50),
	PHAI nvarchar(3) CHECK(PHAI in ('Nam',N'Nữ')),
	NGAYSINH date,
	MOIQUANHE varchar(10),
	Constraint PK_NGUOITHAN primary key (MANV)
)

alter table NHANVIEN
add constraint FK_NHANVIEN_MANV Foreign key (MANV) references NGUOITHAN(MANV)

alter table NHANVIEN
add constraint FK_NHANVIEN_QUANLY Foreign key (QUANLY) references NHANVIEN(MANV)

alter table NHANVIEN
add constraint FK_DEAN_MADN Foreign key (MADN) references DEAN(MADN)

alter table DEAN
add constraint FK_PHONGBAN_DN Foreign key (MAPHONG) references PHONGBAN(MAPHONG)

alter table NHANVIEN
add constraint FK_PHONGBAN_NV Foreign key (MAPHONG) references PHONGBAN(MAPHONG)