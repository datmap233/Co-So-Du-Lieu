use master 
go
if db_id('QuanLyBaiHat') is not null
drop database QuanLyBaiHat
go

create database QuanLyBaiHat

go
use QuanLyBaiHat
go

create table BAIHAT
(
	IDTheLoai varchar(10),
	IDBaiHat varchar(10),
	TenBaiHat nvarchar(30),
	IDTacGia int,
	constraint PK_BAIHAT primary key (IDTheLoai,IDBaiHat),
)

create table THELOAI
(
	IDTheLoai varchar(10),
	TenTheLoai nvarchar(30),
	IDBaiHatTieuBieu varchar(10),
	IDTheLoaiCha varchar(10),
	constraint PK_THELOAI primary key (IDTheLoai),
)

create table TACGIA
(
	IDTacGia int,
	HoTen nvarchar(30),
	IDTheLoaiSoTruongNhat varchar(10),
	IDBaiHatTieuBieuNhat varchar(10),
	constraint PK_TACGIA primary key (IDTacGia),
)

--BAIHAT IDBaiHat -> THELOAI IDBaiHatTieuBieu
alter table THELOAI
add constraint TK_IDBaiHat foreign key (IDBaiHatTieuBieu) references BAIHAT(IDBaiHat)

--BAIHAT IDBaiHat -> TACGIA IDBaiHatTieuBieuNhat
alter table TACGIA
add constraint TK_IDBaiHat_TacGia foreign key (IDBaiHatTieuBieuNhat) references BAIHAT(IDBaiHat)

--THELOAI IDTheLoai-> BAIHAT IDTheLoai v
alter table BAIHAT
add constraint FK_IDTheLoai foreign key (IDTheLoai) references THELOAI(IDTheLoai)

--THELOAI IDTheLoai -> THELOAI IDTheLoaiCha v
alter table THELOAI
add constraint TK_IDTheLoai_CHA foreign key (IDTheLoaiCha) references THELOAI(IDTheLoai)

--TACGIA IDTacGia-> BAIHAT IDTacGia v
alter table BAIHAT
add constraint TK_IDTacGia foreign key (IDTacGia) references TACGIA(IDTacGia)

--THELOAI IDTheLoai -> TACGIA IDTheLoaiSoTruongNhat v
alter table TACGIA
add constraint TK_IDTheLoai_TacGia foreign key (IDTheLoaiSoTruongNhat) references THELOAI(IDTheLoai)