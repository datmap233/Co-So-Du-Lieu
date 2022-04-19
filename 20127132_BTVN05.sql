go
use QLDT
go

--QLDT
--Q36
select *
from GIAOVIEN
where LUONG >= all(
	select LUONG
	from GIAOVIEN
)

--Q38
select T.HOTEN
from (
	select HOTEN,NGSINH,MAGV,GIAOVIEN.MABM
	from GIAOVIEN, BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hệ thống thông tin'
) as T
where year(T.NGSINH) = (
	select min(year(NGSINH))
	from GIAOVIEN gv
	where gv.MABM=T.MABM
)

--Q40
select T.HOTEN, T.TENKHOA, T.LUONG
from (
	select HOTEN,LUONG,GIAOVIEN.MAGV,KHOA.TENKHOA
	from GIAOVIEN, BOMON, KHOA
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.MAKHOA=KHOA.MAKHOA
) as T
where T.LUONG = (
	select max(LUONG)
	from GIAOVIEN
)

--Q42
select TENDT
from DETAI
where MADT not in(
	select MADT
	from THAMGIADT,GIAOVIEN
	where THAMGIADT.MAGV=GIAOVIEN.MAGV and GIAOVIEN.HOTEN=N'Nguyễn Hoài An'
)

--Q44
select distinct GIAOVIEN.HOTEN
from GIAOVIEN,BOMON,KHOA
where KHOA.TENKHOA=N'Công nghệ thông tin' and KHOA.MAKHOA=BOMON.MAKHOA and
	GIAOVIEN.MAGV not in (select MAGV from THAMGIADT)

--Q46
select gv1.MAGV,gv1.HOTEN
from GIAOVIEN gv1, GIAOVIEN gv2
where gv1.LUONG > gv2.LUONG and gv2.HOTEN=N'Nguyễn Hoài An'

--Q48
select distinct gv1.MAGV,gv1.HOTEN
from GIAOVIEN gv1, GIAOVIEN gv2
where gv1.HOTEN=gv2.HOTEN and gv1.PHAI=gv2.PHAI and gv1.MABM=gv2.MABM and gv1.MAGV!=gv2.MAGV

--Q50
select *
from GIAOVIEN
where LUONG >= all(
	select LUONG
	from GIAOVIEN,BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hệ thống thông tin'
)

--Q52
select HOTEN
 from GIAOVIEN GV
 where GV.MAGV IN (select MAGV
	from GIAOVIEN GV1, DETAI DT1
	where GV1.MAGV = DT1.GVCNDT 
	group by GV1.MAGV
	having count(*) >= ALL (
		select GV2.MAGV
		from GIAOVIEN GV2, DETAI DT2
		where GV2.MAGV = DT2.GVCNDT 
		group by GV2.MAGV)
	)

--Q54
select HOTEN, TENBM
from GIAOVIEN GV1, BOMON BM
where GV1.MABM = BM.MABM and exists (
	select GV2.MAGV
    from GIAOVIEN GV2, THAMGIADT TG
	where GV2.MAGV = TG.MAGV  AND GV1.MAGV = GV2.MAGV
	group by GV2.MAGV
	having count(*) >=all (
		select (count(*))
		from GIAOVIEN GV3, THAMGIADT TG3
		where GV3.MAGV = TG3.MAGV
		group by GV3.MAGV)
	)


--Q56
select HOTEN, TENBM
from GIAOVIEN GV1, BOMON BM
where GV1.MABM = BM.MABM and exists (
	select GV2.MAGV
    from GIAOVIEN GV2, NGUOITHAN NT
	where GV2.MAGV = NT.MAGV  AND GV1.MAGV = GV2.MAGV
	group by GV2.MAGV
	having count(*) >=all (
		select (count(*))
		from GIAOVIEN GV3, NGUOITHAN NT2
		where GV3.MAGV = NT2.MAGV
		group by GV3.MAGV)
	)

go
use QLCB
go

--QLCB
--Q34
select HANGSX,LMB.MALOAI,LB.SOHIEU
from LOAIMB LMB,LICHBAY LB
where LMB.MALOAI=LB.MALOAI
group by HANGSX,LMB.MALOAI,LB.SOHIEU
having count(LB.SOHIEU) >= all(
	select count(*)
	from LICHBAY LMB2
	group by LMB2.MALOAI,LMB2.SOHIEU
)

--Q35
select NV.TEN
from NHANVIEN NV, PHANCONG PC
where NV.MANV=PC.MANV and NV.LOAINV=0
group by NV.TEN
having count(NV.MANV) >= all(
	select count(*)
	from NHANVIEN NV2, PHANCONG PC2
	where NV2.MANV=PC2.MANV and NV2.LOAINV=0
	group by PC2.MANV
)
--Q36
select NV.TEN,NV.DCHI,NV.DTHOAI
from NHANVIEN NV, PHANCONG PC
where NV.MANV=PC.MANV and NV.LOAINV=1
group by NV.TEN,NV.DCHI,NV.DTHOAI
having count(NV.MANV) >= all(
	select count(*)
	from NHANVIEN NV2, PHANCONG PC2
	where NV2.MANV=PC2.MANV and NV2.LOAINV=1
	group by PC2.MANV
)

--Q37
select SBDEN, count(*) as N'Số chuyến bay đáp'
from CHUYENBAY CB
group by SBDEN
having count(*) <= all(
	select count(*)
	from CHUYENBAY CB
	group by SBDEN
)

--Q38
select SBDI, count(*) as N'Số chuyến bay đi'
from CHUYENBAY CB
group by SBDI
having count(*) >= all(
	select count(*)
	from CHUYENBAY CB
	group by SBDI
)

--Q39
select TEN,DCHI,DTHOAI
from KHACHHANG KH,DATCHO DC
where KH.MAKH=DC.MAKH
group by TEN,DCHI,DTHOAI
having count(*) >= all(
	select count(*)
	from DATCHO DC2
	group by DC2.MAKH
)

--Q40
select NV.MANV,TEN,LUONG
from NHANVIEN NV,KHANANG KN
where NV.MANV=KN.MANV and NV.LOAINV=1
group by NV.MANV,TEN,LUONG
having count(*) >= all(
	select count(*)
	from KHANANG KN
	group by KN.MANV
)
--Q41
select MANV,TEN,LUONG
from NHANVIEN
where LUONG = (
	select MAX(LUONG)
	from NHANVIEN
)

--Q42
select NV.TEN,NV.DCHI
from NHANVIEN NV
where exists (
	select *
	from NHANVIEN NV1, PHANCONG PC1
	where NV1.MANV=PC1.MANV
	group by PC1.MACB,PC1.NGAYDI
	having NV.LUONG in (
		select max(NV2.LUONG)
		from NHANVIEN NV2, PHANCONG PC2
		where NV2.MANV=PC2.MANV
	)
)

--Q43
select CB.MACB,CB.GIODI,CB.GIODEN
from LICHBAY LB, CHUYENBAY CB
where LB.MACB=CB.MACB and exists (
	select *
	from LICHBAY LB1, CHUYENBAY CB1
	where LB1.MACB=CB1.MACB and LB.NGAYDI=LB1.NGAYDI
	group by LB1.NGAYDI
	having CB.GIODI=MIN(CB1.GIODI)
)

--Q44
select CB.MACB, datediff(MI, CB.GIODI, CB.GIODEN) as N'Số phút đi'
from CHUYENBAY CB
where datediff(MI, CB.GIODI, CB.GIODEN) >= all (
	select datediff(MI, CB.GIODI, CB.GIODEN) 
	from CHUYENBAY CB
)

--Q45
select CB.MACB, datediff(MI, CB.GIODI, CB.GIODEN) as N'Số phút đi'
from CHUYENBAY CB
where datediff(MI, CB.GIODI, CB.GIODEN) <= all (
	select datediff(MI, CB.GIODI, CB.GIODEN) 
	from CHUYENBAY CB
)

--Q46
select MACB, NGAYDI
from LICHBAY LB
where exists(
	select *
	from LICHBAY LB1
	where LB.MACB=LB1.MACB and LB1.MALOAI='B747'
	group by MACB
	having count (LB1.NGAYDI) >= all(
		select count (LB2.NGAYDI)
		from LICHBAY LB2
		where LB2.MALOAI='B747'
		group by MACB
	)
)

--Q47
select LB.MACB, count(distinct PC.MANV) as N'Số lượng nhân viên'
from DATCHO DC,PHANCONG PC,LICHBAY LB
where DC.MACB=PC.MACB and PC.MACB=LB.MACB and DC.NGAYDI=PC.NGAYDI and PC.NGAYDI=LB.NGAYDI
group by LB.MACB
having count(distinct DC.MAKH) >= 3

--Q48
select LOAINV, count(MANV) as N'Số lượng'
from NHANVIEN
group by LOAINV
having sum(lUONG) >= 600000

--Q49
select LB.MACB, count(distinct DC.MAKH) as N'Số lượng khách hàng'
from PHANCONG PC, LICHBAY LB, DATCHO DC
where PC.MACB=LB.MACB and LB.MACB=DC.MACB and LB.NGAYDI=PC.NGAYDI and DC.NGAYDI=PC.NGAYDI
group by LB.MACB, LB.NGAYDI
having count(distinct PC.MANV)>=2

--Q50
select LB.MALOAI, count(*) as N'Số lượng chuyến bay'
from LICHBAY LB
where LB.MALOAI in (
	select MALOAI
	from MAYBAY MB
	group by MALOAI
	having count (*)>=2
	)
group by LB.MALOAI