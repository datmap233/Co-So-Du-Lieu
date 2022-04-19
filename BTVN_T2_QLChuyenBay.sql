create database QLChuyenBay

go
use QLChuyenBay
go

create table KHACHHANG
(
	MAKH varchar(10),
	TEN nvarchar(50) NOT NULL,
	DCHI nvarchar(100),
	DTHOAI nvarchar(10),
	Constraint PK_KHACHHANG primary key (MAKH)
)

create table DATCHO
(
	MAKH varchar(10),
	NGAYDI datetime,
	MACB varchar(10),
	Constraint PK_DATCHO primary key (MAKH,NGAYDI,MACB)
)

create table LICHBAY
(
	NGAYDI datetime,
	MACB varchar(10),
	SOHIEU nvarchar(5),
	MALOAI varchar(5),
	Constraint PK_LICHBAY primary key (NGAYDI,MACB)
)

create table CHUYENBAY
(
	MACB varchar(10),
	SBDEN nvarchar(50), -- SÂN BAY ĐẾN
	GIODI datetime,
	GIODEN datetime,
	Constraint PK_CHUYENBAY primary key (MACB)
)

create table MAYBAY
(
	SOHIEU nvarchar(5),
	MALOAI varchar(5),
	Constraint PK_MAYBAY primary key (SOHIEU,MALOAI)
)

create table LOAIMAYBAY
(
	MALOAI varchar(5),
	HANGSANXUAT nvarchar(20),
	Constraint PK_LOAIMAYBAY primary key (MALOAI)
)

create table KHANANG
(
	MANV varchar(10),
	MALOAI varchar(5),
	Constraint PK_KHANANG primary key (MANV,MALOAI)
)

create table NHANVIEN
(
	MANV varchar(10),
	TEN nvarchar(50) NOT NULL,
	DCHI nvarchar(100),
	DTHOAI nvarchar(10),
	LUONG int default(0),
	LOAINV nvarchar(20),
	Constraint PK_NHANVIEN primary key (MANV)
)

create table PHANCONG
(
	MANV varchar(10),
	NGAYDI datetime,
	MACB varchar(10),
	Constraint PK_PHANCONG primary key (MANV, NGAYDI, MACB)
)

alter table DATCHO
add constraint FK_DATCHO_MAKH Foreign key (MAKH) references KHACHHANG(MAKH)

alter table DATCHO
add constraint FK_DATCHO Foreign key (NGAYDI,MACB) references LICHBAY(NGAYDI,MACB)

alter table LICHBAY
add constraint FK_LICHBAY_MACB Foreign key (MACB) references CHUYENBAY(MACB)

alter table KHANANG
add constraint FK_KHANANG_MALOAI Foreign key (MALOAI) references LOAIMAYBAY(MALOAI)

alter table KHANANG
add constraint FK_KHANANG_MANV Foreign key (MANV) references NHANVIEN(MANV)

alter table PHANCONG
add constraint FK_PHANCONG_MANV Foreign key (MANV) references NHANVIEN(MANV)

alter table PHANCONG
add constraint FK_PHANCONG Foreign key (NGAYDI,MACB) references LICHBAY(NGAYDI,MACB)

alter table MAYBAY
add constraint FK_MAYBAY_MALOAI Foreign key (MALOAI) references LOAIMAYBAY(MALOAI)

alter table LICHBAY
add constraint FK_LICHBAY Foreign key (SOHIEU,MALOAI) references MAYBAY(SOHIEU,MALOAI)

insert into KHACHHANG values('KH00000001',N'Nguyễn Văn Long',N'75 Võ Văn Ngân', '0937373737')
insert into KHACHHANG values('KH00000002',N'Trần Thị Lan',N'65 Nguyễn Văn Cừ', '0937666666')
insert into KHACHHANG values('KH00000003',N'Trương Thanh Khang',N'99 Bạch Đằng', '0937212121')
insert into KHACHHANG values('KH00000004',N'Nguyễn Thị Bưởi',N'112 Cách Mạng Tháng Tám', '0937343434')
insert into KHACHHANG values('KH00000005',N'Phạm Nam Thành',N'99 Nguyễn Thái Học', '0937765765')
insert into KHACHHANG values('KH00000006',N'Trần Hoàng Nam',N'743 Trường Chinh', '0937123876')

insert into CHUYENBAY values('CB00000001', N'Nội Bài','2022-02-20 08:00', '2022-02-20 10:00')
insert into CHUYENBAY values('CB00000002', N'Tân Sơn Nhất','2022-02-22 09:00', '2022-02-22 12:00')
insert into CHUYENBAY values('CB00000003', N'Quy Nhơn','2022-02-23 10:00', '2022-02-23 12:00')
insert into CHUYENBAY values('CB00000004', N'Đà Nẵng','2022-02-24 11:00', '2022-02-24 14:00')

insert into LOAIMAYBAY values('B210', 'Airbus')
insert into LOAIMAYBAY values('B220', 'Airbus')
insert into LOAIMAYBAY values('B230', 'Boeing')
insert into LOAIMAYBAY values('B240', 'Boeing')

insert into MAYBAY values('MB001','B210')
insert into MAYBAY values('MB002','B220')
insert into MAYBAY values('MB003','B230')
insert into MAYBAY values('MB004','B240')

insert into LICHBAY values('2022-02-20 08:00','CB00000001','MB001','B210')
insert into LICHBAY values('2022-02-22 09:00','CB00000002','MB002','B220')
insert into LICHBAY values('2022-02-23 10:00','CB00000003','MB003','B230')
insert into LICHBAY values('2022-02-24 11:00','CB00000004','MB004','B240')

insert into NHANVIEN values('NV00000001', N'Nguyễn Thị Chi', N'12 Nguyễn Văn Cừ','0308808080', 15000000, N'Tiếp viên')
insert into NHANVIEN values('NV00000002', N'Trần Trà Hương', N'215 Lý Thường Kiệt','0308777777', 15000000, N'Tiếp viên')
insert into NHANVIEN values('NV00000003', N'Lý Hoàng Hà', N'127 Hùng Vương','0308727272', 15000000, N'Tiếp viên')
insert into NHANVIEN values('NV00000004', N'Nguyễn Văn Đô', N'12/21 Võ Văn Ngân','0308121212', 30000000, N'Cơ trưởng')
insert into NHANVIEN values('NV00000005', N'Trần Anh Khôi', N'22/5 Nguyễn Xí','0308345345', 25000000, N'Cơ phó')
insert into NHANVIEN values('NV00000006', N'Trần Văn Long', N'234 Trần Não, An Phú','0308565656', 30000000, N'Cơ trưởng')
insert into NHANVIEN values('NV00000007', N'Đinh Văn Khang', N'221 Hùng Vương','0308666666', 25000000, N'Cơ phó')

insert into KHANANG values('NV00000004','B210')
insert into KHANANG values('NV00000004','B230')
insert into KHANANG values('NV00000004','B240')
insert into KHANANG values('NV00000006','B220')
insert into KHANANG values('NV00000006','B240')

insert into DATCHO values('KH00000001','2022-02-20 08:00', 'CB00000001')
insert into DATCHO values('KH00000002','2022-02-22 09:00', 'CB00000002')
insert into DATCHO values('KH00000003','2022-02-20 08:00', 'CB00000001')
insert into DATCHO values('KH00000004','2022-02-23 10:00', 'CB00000003')
insert into DATCHO values('KH00000005','2022-02-22 09:00', 'CB00000002')
insert into DATCHO values('KH00000006','2022-02-24 11:00', 'CB00000004')

insert into PHANCONG values('NV00000004','2022-02-20 08:00','CB00000001')
insert into PHANCONG values('NV00000005','2022-02-20 08:00','CB00000001')
insert into PHANCONG values('NV00000001','2022-02-20 08:00','CB00000001')
insert into PHANCONG values('NV00000003','2022-02-20 08:00','CB00000001')
insert into PHANCONG values('NV00000006','2022-02-22 09:00','CB00000002')
insert into PHANCONG values('NV00000007','2022-02-22 09:00','CB00000002')
insert into PHANCONG values('NV00000002','2022-02-22 09:00','CB00000002')
insert into PHANCONG values('NV00000004','2022-02-23 10:00','CB00000003')
insert into PHANCONG values('NV00000005','2022-02-23 10:00','CB00000003')
insert into PHANCONG values('NV00000001','2022-02-23 10:00','CB00000003')
insert into PHANCONG values('NV00000006','2022-02-24 11:00','CB00000004')
insert into PHANCONG values('NV00000007','2022-02-24 11:00','CB00000004')
insert into PHANCONG values('NV00000002','2022-02-24 11:00','CB00000004')
insert into PHANCONG values('NV00000003','2022-02-24 11:00','CB00000004')