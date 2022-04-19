--Tên: Nguyễn Văn Đạt
--MSSV: 20127132
--Lớp: 20CLC5
--Đề: 282

use master
go
if db_id('QuanLyNhaDat') is not null
drop database QuanLyNhaDat
go

create database QuanLyNhaDat

go
use QuanLyNhaDat
go

create table LOAINHA
(
	MaLoaiNha varchar(4),
	TenLoaiNha nvarchar(20),
	ChiNhanh varchar(4),
	NhaDD varchar(5),
	constraint PK_LOAINHA primary key(MaLoaiNha)
)

create table NHA
(
	ChiNhanh varchar(4),
	MaNha varchar(5),
	LoaiNha varchar(4),
	DiaChi nvarchar(50),
	TienThue money,
	constraint PK_NHA primary key(ChiNhanh,MaNha)
)

create table NGUOITHUE
(
	MaNguoiThue varchar(6),
	HoTen nvarchar(50),
	SDT varchar(11),
	LoaiNha varchar(4),
	constraint PK_NGUOITHUE primary key(MaNguoiThue)
)

create table XEMNHA
(
	NguoiThue varchar(6),
	ChiNhanh varchar(4),
	Nha varchar(5),
	NgayXem date,
	NhanXet nvarchar(100),
	constraint PK_XEMNHA primary key(NguoiThue)
)

--NHA
--ChiNhanh -> LOAINHA ChiNhanh
--LoaiNha -> LOAINHA MaLoaiNha

alter table NHA
add
constraint FK_NHA_LoaiNha foreign key(LoaiNha) references LOAINHA(MaLoaiNha)
--constraint FK_LOAINHA_NHA foreign key(ChiNhanh) references NHA(ChiNhanh)

--NGUOITHUE
--LoaiNha -> LOAINHA MaLoaiNha
alter table NGUOITHUE
add
constraint FK_NGUOITHUE_LoaiNha foreign key(LoaiNha) references LOAINHA(MaLoaiNha)
--XEMNHA
--NguoiThue -> NGUOITHUE MaNguoiThue
--ChiNhanh,Nha -> NHA ChiNhanh,MaNha

alter table XEMNHA
add
constraint FK_XEMNHA_NGUOITHUE foreign key(NguoiThue) references NGUOITHUE(MaNguoiThue),
constraint FK_XEMNHA_NHA foreign key(ChiNhanh,Nha) references NHA(ChiNhanh,MaNha)

insert into NGUOITHUE values('NT0001',N'Trần Hữu Tiến','0935936521',null)
insert into NGUOITHUE values('NT0002',N'Đỗ Văn Nhuận',null,null)
insert into NGUOITHUE values('NT0003',N'Phan Huỳnh Mạnh','0945563293',null)
insert into NGUOITHUE values('NT0004',N'Vi Nhật Linh','0386547746',null)

insert into LOAINHA values('LN01',N'Nhà phố','CN01','N0002')
insert into LOAINHA values('LN02',N'Biệt thự','CN02','N0001')
insert into LOAINHA values('LN03',N'Nhà cấp 4','CN02','N0002')

insert into NHA values('CN01','N0001',null,N'245/3 Nguyễn Tri Phương, P4, Q5, TP HCM',8000000)
insert into NHA values('CN01','N0002',null,N'245/3 Nguyễn Tri Phương, P4, Q5, TP HCM',8000000)
insert into NHA values('CN02','N0001',null,N'245/3 Nguyễn Tri Phương, P4, Q5, TP HCM',8000000)
insert into NHA values('CN02','N0002',null,N'245/3 Nguyễn Tri Phương, P4, Q5, TP HCM',8000000)

update NHA set LoaiNha='LN01' where ChiNhanh='CN01' and MaNha='N0002' 
update NHA set LoaiNha='LN02' where ChiNhanh='CN01' and MaNha='N0001' 
update NHA set LoaiNha='LN02' where ChiNhanh='CN02' and MaNha='N0001' 
update NHA set LoaiNha='LN03' where ChiNhanh='CN021' and MaNha='N0002'

update NGUOITHUE set LoaiNha='LN01' where MaNguoiThue='NT0001'
update NGUOITHUE set LoaiNha='LN03' where MaNguoiThue='NT0002'
update NGUOITHUE set LoaiNha='LN02' where MaNguoiThue='NT0003'
update NGUOITHUE set LoaiNha='LN01' where MaNguoiThue='NT0004'

insert into XEMNHA values('NT0001','CN01','N0002','02/03/2022',N'Bồn rửa bị hư chưa sửa, nhà thoáng')
insert into XEMNHA values('NT0002','CN02','N0001','04/02/2022',N'Nhà thiết kế chật, ít ánh sáng')
insert into XEMNHA values('NT0001','CN01','N0002','27/03/2022',N'Bồn rửa sửa sạch đẹp')
insert into XEMNHA values('NT0001','CN02','N0002','24/11/2022',N'Nhà nhỏ')
insert into XEMNHA values('NT0004','CN01','N0001','10/12/2022',N'Nhà đẹp, rộng rãi')

--cau 2
select NGUOITHUE.MaNguoiThue,NGUOITHUE.HoTen,NGUOITHUE.LoaiNha,count(XEMNHA.NguoiThue) from NGUOITHUE,XEMNHA where XEMNHA.NguoiThue=NguoiThue.MaNguoiThue