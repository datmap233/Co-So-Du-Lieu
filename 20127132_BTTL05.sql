go
use QLDT
go

--Q35
select max(LUONG)
from GIAOVIEN

--Q36
select *
from GIAOVIEN
where LUONG >= all(
	select LUONG
	from GIAOVIEN
)

--Q37
select *
from GIAOVIEN
where MABM='HTTT' and LUONG >= all(
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
--Q39
select T.HOTEN
from (
	select HOTEN,NGSINH,MAGV,GIAOVIEN.MABM
	from GIAOVIEN, BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hệ thống thông tin'
) as T
where year(T.NGSINH) = (
	select max(year(NGSINH))
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

--Q41
select T.HOTEN, T.LUONG,T.MABM
from (
	select HOTEN,LUONG,GIAOVIEN.MABM
	from GIAOVIEN, BOMON
	where GIAOVIEN.MABM=BOMON.MABM
) as T
where T.LUONG = (
	select max(LUONG)
	from GIAOVIEN
	where GIAOVIEN.MABM=T.MABM
)

--Q42
select TENDT
from DETAI
where MADT not in(
	select MADT
	from THAMGIADT,GIAOVIEN
	where THAMGIADT.MAGV=GIAOVIEN.MAGV and GIAOVIEN.HOTEN=N'Nguyễn Hoài An'
)

--Q43
select TENDT,HOTEN
from DETAI,GIAOVIEN
where MADT not in(
	select MADT
	from THAMGIADT,GIAOVIEN
	where THAMGIADT.MAGV=GIAOVIEN.MAGV and GIAOVIEN.HOTEN=N'Nguyễn Hoài An'
) and GVCNDT=MAGV

--Q44
select distinct GIAOVIEN.HOTEN
from GIAOVIEN,BOMON,KHOA
where KHOA.TENKHOA=N'Công nghệ thông tin' and KHOA.MAKHOA=BOMON.MAKHOA and
	GIAOVIEN.MAGV not in (select MAGV from THAMGIADT)

--Q45
select GIAOVIEN.HOTEN
from GIAOVIEN
where MAGV not in (select MAGV from THAMGIADT)

--Q46
select gv1.MAGV,gv1.HOTEN
from GIAOVIEN gv1, GIAOVIEN gv2
where gv1.LUONG > gv2.LUONG and gv2.HOTEN=N'Nguyễn Hoài An'

--Q47
select GIAOVIEN.MAGV,GIAOVIEN.HOTEN
from GIAOVIEN
where GIAOVIEN.MAGV in (
	select MAGV
	from THAMGIADT,BOMON
	where MAGV=TRUONGBM
)

--Q48
select distinct gv1.MAGV,gv1.HOTEN
from GIAOVIEN gv1, GIAOVIEN gv2
where gv1.HOTEN=gv2.HOTEN and gv1.PHAI=gv2.PHAI and gv1.MABM=gv2.MABM and gv1.MAGV!=gv2.MAGV

--Q49
select *
from GIAOVIEN
where LUONG >= any(
	select LUONG
	from GIAOVIEN,BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Công nghệ phần mềm'
)

--Q50
select *
from GIAOVIEN
where LUONG >= all(
	select LUONG
	from GIAOVIEN,BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hệ thống thông tin'
)

--Q51
select TENKHOA
from GIAOVIEN, BOMON, KHOA
where GIAOVIEN.MABM=BOMON.MABM and BOMON.MAKHOA=KHOA.MAKHOA
group by TENKHOA
having count(*) > all( select count(*)
from GIAOVIEN, BOMON, KHOA
where GIAOVIEN.MABM=BOMON.MABM and BOMON.MAKHOA=KHOA.MAKHOA
group by GIAOVIEN.MABM)

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
--Q53
select MABM
from GIAOVIEN
group by MABM
having count(*) >=all( select count(*)
from GIAOVIEN
group by MABM)

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

--Q55
select HOTEN, TENBM
from GIAOVIEN GV1, BOMON BM
where GV1.MABM = BM.MABM and BM.MABM='HTTT' and exists (
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

--Q57
select HOTEN
 from GIAOVIEN GV, BOMON BM
 where GV.MAGV IN (select MAGV
	from GIAOVIEN GV1, DETAI DT1
	where GV1.MAGV = DT1.GVCNDT and BM.TRUONGBM=GV.MAGV and BM.TRUONGBM=GV1.MAGV
	group by GV1.MAGV
	having count(*) >= ALL (
		select GV2.MAGV
		from GIAOVIEN GV2, DETAI DT2, BOMON BM2
		where GV2.MAGV = DT2.GVCNDT and BM.TRUONGBM=GV2.MAGV
		group by GV2.MAGV)
	)