﻿go
use QLDT
go

--Q1
select gv.HOTEN,gv.LUONG from GIAOVIEN gv where gv.PHAI=N'Nữ'
--Q2
select HOTEN,LUONG*1.1 from GIAOVIEN
--Q3
select distinct MAGV,LUONG from GIAOVIEN,KHOA where HOTEN like N'Nguyễn%' and LUONG > 2000 or year(NGAYNHANCHUC) > 1995
--Q4
select HOTEN from GIAOVIEN,BOMON where GIAOVIEN.MABM = BOMON.MABM and MAKHOA='CNTT'
--Q5
select * from GIAOVIEN,BOMON where GIAOVIEN.MAGV = BOMON.TRUONGBM
--Q6
select * from GIAOVIEN,BOMON where GIAOVIEN.MABM = BOMON.MABM
--Q7
select distinct TENDT, HOTEN from GIAOVIEN,THAMGIADT,DETAI where GIAOVIEN.MAGV = THAMGIADT.MAGV and THAMGIADT.MADT = DETAI.MADT
--Q8
select HOTEN from GIAOVIEN,KHOA where GIAOVIEN.MAGV = KHOA.TRUONGKHOA
--Q9
select distinct HOTEN from GIAOVIEN,THAMGIADT where GIAOVIEN.MAGV = THAMGIADT.MAGV and THAMGIADT.MADT='006'
--Q10
select distinct MADT,TenDT,HOTEN,NGSINH,DiaChi from GIAOVIEN,DETAI where DETAI.CapQL=N'Thành phố'
--Q11
select GV.HOTEN AS GV, GVQL.HOTEN AS 'GVQL' from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM = GVQL.MAGV
--Q12
select GV.HOTEN AS GV, GVQL.HOTEN AS 'GVQL' from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM = GVQL.MAGV AND GVQL.HOTEN = N'Nguyễn Thanh Tùng'
--Q13
select HOTEN from GIAOVIEN,BOMON where BOMON.TRUONGBM = GIAOVIEN.MAGV and BOMON.TENBM = N'Hệ thống thông tin'
--Q14
select HOTEN from GIAOVIEN,DETAI where DETAI.GVCNDT = GIAOVIEN.MAGV and DETAI.MACD='QLGD'
--Q15
select TENCV from CONGVIEC where MONTH(NGAYBD) = 3 AND YEAR(NGAYBD) = 2008
--Q16
select GV.HOTEN AS GV, GVQL.HOTEN AS 'GVQL' from GIAOVIEN GV join GIAOVIEN GVQL on GV.GVQLCM = GVQL.MAGV
--Q17
select TENCV from CONGVIEC where NGAYBD BETWEEN '01-01-2007' AND '01-08-2007'
--Q18
select GV.HOTEN AS GV from GIAOVIEN GV join GIAOVIEN LVCHUNG on GV.MABM = LVCHUNG.MABM AND LVCHUNG.HOTEN=N'Trần Trà Hương'AND GV.HOTEN!=N'Trần Trà Hương'
--Q19
select distinct DETAI.GVCNDT from DETAI,BOMON where DETAI.GVCNDT = BOMON.TRUONGBM
--Q20
select distinct KHOA.TRUONGKHOA from KHOA,BOMON where KHOA.TRUONGKHOA= BOMON.TRUONGBM
--Q21
select distinct GIAOVIEN.HOTEN from GIAOVIEN,DETAI,BOMON where DETAI.GVCNDT = BOMON.TRUONGBM AND GIAOVIEN.MAGV=DETAI.GVCNDT
--Q22
select distinct KHOA.TRUONGKHOA from KHOA,DETAI where KHOA.TRUONGKHOA= DETAI.GVCNDT
--Q23
select distinct GIAOVIEN.MAGV from GIAOVIEN,THAMGIADT where GIAOVIEN.MABM='HTTT' OR (THAMGIADT.MADT='001' AND GIAOVIEN.MAGV = THAMGIADT.MAGV)
--Q24
select GV.HOTEN AS GV from GIAOVIEN GV join GIAOVIEN LVCHUNG on GV.MABM = LVCHUNG.MABM AND LVCHUNG.MAGV='002'AND GV.MAGV!='002'
--Q25
select HOTEN from GIAOVIEN,BOMON where GIAOVIEN.MAGV = BOMON.TRUONGBM
--Q26
select HOTEN,LUONG from GIAOVIEN