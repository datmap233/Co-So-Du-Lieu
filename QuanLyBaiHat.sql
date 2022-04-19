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
	constraint PK_BAIHAT primary key(IDTheLoai,IDBaiHat)
)

create table THELOAI
(
	IDTheLoai varchar(10),
	TenTheLoai nvarchar(30),
	IDBaiHatTieuBieu varchar(10),
	IDTheLoaiCha varchar(10),
	constraint PK_THELOAI primary key(IDTheLoai)
)

create table TACGIA
(
	IDTacGia int,
	HoTen nvarchar(30),
	IDTheLoaiSoTruongNhat varchar(10),
	IDBaiHatTieuBieuNhat varchar(10),
	constraint PK_TACGIA primary key(IDTacGia)
)

alter table BAIHAT
add
constraint FK_BAIHAT_THELOAI foreign key(IDTheLoai) references THELOAI(IDTheLoai),
constraint FK_BAIHAT_TACGIA foreign key(IDTacGia) references TACGIA(IDTacGia)

alter table THELOAI
add
constraint FK_THELOAI_BAIHAT foreign key(IDTheLoai,IDBaiHatTieuBieu) references BAIHAT(IDTheLoai,IDBaiHat),
constraint FK_THELOAI_THELOAI foreign key(IDTheLoaiCha) references THELOAI(IDTheLoai)

alter table TACGIA
add
constraint FK_TACGIA_BAIHAT foreign key(IDTheLoaiSoTruongNhat,IDBaiHatTieuBieuNhat) references BAIHAT(IDTheLoai,IDBaiHat)

insert into THELOAI values('TL01',N'Nhạc trữ tình',null,null)
insert into THELOAI values('TL02',N'Nhạc cách mạng',null,null)
insert into THELOAI values('TL00',N'Nhạc Việt Nam',null,null)

insert into BAIHAT values('TL01','BH01',N'Ngẫu hứng lý qua cầu',null)
insert into BAIHAT values('TL01','BH02',N'Chuyến đò quê hương',null)
insert into BAIHAT values('TL02','BH01',N'Du kích sông Thao',null)
insert into BAIHAT values('TL02','BH02',N'Sợi nhớ sợi thương',null)

insert into TACGIA values(1,N'Trần Tiến','TL01','BH01')
insert into TACGIA values(2,N'Đỗ Nhuận','TL02','BH01')
insert into TACGIA values(3,N'Phan Huỳnh Điểu','TL02','BH02')
insert into TACGIA values(4,N'Vi Nhật Tảo','TL01','BH02')

update THELOAI set IDTheLoaiCha='TL00' where IDTheLoai='TL01' or IDTheLoai='TL02'
update THELOAI set IDBaiHatTieuBieu='BH01' where IDTheLoai='TL01'
update THELOAI set IDBaiHatTieuBieu='BH02' where IDTheLoai='TL02'
update BAIHAT set IDTacGia=1 where IDBaiHat='BH01' and IDTheLoai='TL01'
update BAIHAT set IDTacGia=2 where IDBaiHat='BH02' and IDTheLoai='TL01'
update BAIHAT set IDTacGia=3 where IDBaiHat='BH02' and IDTheLoai='TL02'
update BAIHAT set IDTacGia=4 where IDBaiHat='BH01' and IDTheLoai='TL02'

--Yêu cầu 2

--Q1
select BAIHAT.IDBaiHat,BAIHAT.IDTheLoai,BAIHAT.TenBaiHat
from BAIHAT,TACGIA
where TACGIA.HoTen=N'Đỗ Nhuận' and TACGIA.IDTacGia=BAIHAT.IDTacGia

--Q2
select THELOAI.IDTheLoai,THELOAI.TenTheLoai
from THELOAI
where not exists(select * from BAIHAT where BAIHAT.IDTheLoai=THELOAI.IDTheLoai)

--Q3
select TACGIA.IDTacGia,TACGIA.HoTen,count(BAIHAT.TenBaiHat) as N'Số lượng bài hát'
from BAIHAT,TACGIA
where TACGIA.IDTacGia=BAIHAT.IDTacGia
group by TACGIA.IDTacGia,TACGIA.HoTen