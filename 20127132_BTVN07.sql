go
use QLDT
go

--Q58
select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	except
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV
)

select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	where not exists(
		select DT.MACD
		from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
		where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and DT.MACD=CD.MACD
	)
)

select HOTEN
from GIAOVIEN GV, THAMGIADT TG, DETAI DT
where GV.MAGV=TG.MAGV and DT.MADT=TG.MADT
group by HOTEN
having count(distinct DT.MACD) = (
	select count(distinct CD.MACD)
	from CHUDE CD
)


--Q59
select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV
		where GV.MABM='HTTT'
		except
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV
		where GV.MABM='HTTT' and not exists(
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT and GV.MAGV=TG.MAGV
		)
	)
)

select TENDT
from DETAI DT,THAMGIADT TG,GIAOVIEN GV
where DT.MADT=TG.MADT and TG.MAGV=GV.MAGV and GV.MABM='HTTT'
group by TENDT, DT.MADT
having count(distinct GV.MAGV) = (
	select count(distinct MAGV)
	from GIAOVIEN
	where MABM='HTTT'
)

--Q60
select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.TENBM=N'Hệ thống thông tin'
		except
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.TENBM=N'Hệ thống thông tin' and not exists(
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT and GV.MAGV=TG.MAGV
		)
	)
)

select TENDT
from DETAI DT,THAMGIADT TG,GIAOVIEN GV, BOMON BM
where DT.MADT=TG.MADT and TG.MAGV=GV.MAGV and GV.MABM=BM.MABM and BM.TENBM=N'Hệ thống thông tin'
group by TENDT, DT.MADT
having count(distinct GV.MAGV) = (
	select count(distinct MAGV)
	from GIAOVIEN, BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hệ thống thông tin'
)

--Q61
select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	where CD.MACD='QLGD'
	except
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV
)

select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	where CD.MACD='QLGD' and not exists(
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV and CD.MACD=DT.MACD
	)
)

select HOTEN
from GIAOVIEN GV, THAMGIADT TG, DETAI DT
where TG.MAGV=GV.MAGV and DT.MADT=TG.MADT and DT.MACD='QLGD'
group by HOTEN,GV.MAGV
having count(distinct DT.MACD)=(
	select count(MACD)
	from CHUDE
	where MACD='QLGD'
)

--Q62
select GV.HOTEN
from GIAOVIEN GV
where GV.HOTEN!=N'Trần Trà Hương' and  not exists(
	select DT.MADT
	from DETAI DT,THAMGIADT TG, GIAOVIEN GV1
	where DT.MADT=TG.MADT and TG.MAGV=GV1.MAGV and GV1.HOTEN=N'Trần Trà Hương'
	except
	select TG1.MADT
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV
)

select GV.HOTEN
from GIAOVIEN GV
where GV.HOTEN!=N'Trần Trà Hương' and  not exists(
	select DT.MADT
	from DETAI DT,THAMGIADT TG, GIAOVIEN GV1
	where DT.MADT=TG.MADT and TG.MAGV=GV1.MAGV and GV1.HOTEN=N'Trần Trà Hương' and not exists(
		select TG1.MADT
		from THAMGIADT TG1
		where TG1.MAGV=GV.MAGV and TG.MADT=TG1.MADT
	)
)

select distinct HOTEN
from GIAOVIEN GV,THAMGIADT TG1,(
	select DT.MADT
	from DETAI DT,THAMGIADT TG, GIAOVIEN GV1
	where DT.MADT=TG.MADT and TG.MAGV=GV1.MAGV and GV1.HOTEN=N'Trần Trà Hương'
) as DTMADT
where TG1.MAGV=GV.MAGV and DTMADT.MADT=TG1.MADT and GV.HOTEN!=N'Trần Trà Hương'
group by HOTEN,GV.MAGV
having count(distinct DTMADT.MADT)=(
	select count(DT.MADT)
	from DETAI DT,THAMGIADT TG, GIAOVIEN GV1
	where DT.MADT=TG.MADT and TG.MAGV=GV1.MAGV and GV1.HOTEN=N'Trần Trà Hương'
)

--Q63
select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.TENBM=N'Hóa Hữu Cơ'
		except
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.TENBM=N'Hóa Hữu Cơ' and not exists (
			select TG.MAGV
			from THAMGIADT TG
			where TG.MADT=DT.MADT and TG.MAGV=GV.MAGV
		)
	)
)

select TENDT
from DETAI DT,THAMGIADT TG,GIAOVIEN GV, BOMON BM
where DT.MADT=TG.MADT and TG.MAGV=GV.MAGV and GV.MABM=BM.MABM and BM.TENBM=N'Hóa Hữu Cơ'
group by TENDT, DT.MADT
having count(distinct GV.MAGV) = (
	select count(distinct MAGV)
	from GIAOVIEN, BOMON
	where GIAOVIEN.MABM=BOMON.MABM and BOMON.TENBM=N'Hóa Hữu Cơ'
)

--Q64
select GV.HOTEN
from GIAOVIEN GV
where not exists(
	select CV.MADT,CV.SOTT
	from CONGVIEC CV
	where CV.MADT='006'
	except
	select distinct TG1.MADT,TG1.STT
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV and MADT='006'
)

select GV.HOTEN
from GIAOVIEN GV
where not exists(
	select *
	from CONGVIEC CV
	where CV.MADT='006' and not exists(
		select *
		from THAMGIADT TG1
		where TG1.MAGV=GV.MAGV and TG1.MADT=CV.MADT and TG1.STT=CV.SOTT
	)
)

select GV.HOTEN
from GIAOVIEN GV, THAMGIADT TG
where TG.MAGV=GV.MAGV and TG.MADT='006'
group by GV.HOTEN,GV.MAGV
having count(distinct STT)=(
	select count(*)
	from CONGVIEC
	where MADT='006'
	)

--Q65
select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	where CD.TENCD=N'Ứng dụng công nghệ'
	except
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV
)

select HOTEN
from GIAOVIEN GV
where not exists (
	select CD.MACD
	from CHUDE CD
	where CD.TENCD=N'Ứng dụng công nghệ' and not exists (
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV and CD.MACD=DT.MACD
	)
)

select distinct HOTEN
from GIAOVIEN GV,THAMGIADT TG,DETAI DT, CHUDE CD
where TG.MAGV=GV.MAGV and DT.MADT=TG.MADT and DT.MACD=CD.MACD and CD.TENCD=N'Ứng dụng công nghệ'
group by HOTEN,GV.MAGV
having count(distinct DT.MACD)=(
	select count(MACD)
	from CHUDE
	where TENCD=N'Ứng dụng công nghệ'
)

--Q66
select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV and not exists (
	select MADT
	from DETAI,GIAOVIEN GV2
	where DETAI.GVCNDT=GV2.MAGV and GV2.HOTEN=N'Trần Trà Hương'
	except
	select MADT
	from THAMGIADT TG3
	where TG3.MAGV=GV.MAGV
)

select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV and not exists (
	select MADT
	from DETAI,GIAOVIEN GV2
	where DETAI.GVCNDT=GV2.MAGV and GV2.HOTEN=N'Trần Trà Hương' and not exists (
		select MADT
		from THAMGIADT TG3
		where TG3.MAGV=GV.MAGV and TG3.MADT=DETAI.MADT
	)
)

select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV
group by GV.HOTEN, GV.MAGV
having count(distinct TG1.MADT)=(
	select count(MADT)
	from DETAI,GIAOVIEN GV2
	where DETAI.GVCNDT=GV2.MAGV and GV2.HOTEN=N'Trần Trà Hương'
)

--Q67
select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.MAKHOA='CNTT'
		except
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.MAKHOA='CNTT' and not exists (
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT and TG.MAGV=GV.MAGV
		)
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT,THAMGIADT TG
	where TG.MADT=DT.MADT
	group by DT.MADT,TG.MAGV
	having count(distinct TG.MAGV)=(
		select count(GV.MAGV)
		from GIAOVIEN GV, BOMON BM
		where GV.MABM=BM.MABM and BM.MAKHOA='CNTT'
	)
)

--Q68
select GV.HOTEN
from GIAOVIEN GV
where not exists(
	select CV.MADT,CV.SOTT
	from CONGVIEC CV,DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Nghiên cứu tế bào gốc'
	except
	select distinct TG1.MADT,TG1.STT
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV
)

select GV.HOTEN
from GIAOVIEN GV
where not exists(
	select *
	from CONGVIEC CV,DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Nghiên cứu tế bào gốc' and not exists(
	select *
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV and TG1.MADT=DT.MADT and TG1.MADT=CV.MADT and TG1.STT=CV.SOTT
	)
)

select GV.HOTEN
from GIAOVIEN GV, THAMGIADT TG,DETAI DT
where TG.MAGV=GV.MAGV and TG.MADT=DT.MADT and DT.TENDT=N'Nghiên cứu tế bào gốc'
group by GV.HOTEN,GV.MAGV
having count(distinct STT)=(
	select count(*)
	from CONGVIEC CV,DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Nghiên cứu tế bào gốc'
	)

--Q69
select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV and not exists (
	select MADT
	from DETAI
	where KINHPHI > 100
	except
	select MADT
	from THAMGIADT TG3
	where TG3.MAGV=GV.MAGV
)

select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV and not exists (
	select MADT
	from DETAI
	where KINHPHI > 100 and not exists(
	select distinct MADT
	from THAMGIADT TG3
	where TG3.MAGV=GV.MAGV and DETAI.MADT=TG3.MADT
	)
)

select distinct GV.HOTEN
from THAMGIADT TG1, GIAOVIEN GV
where TG1.MAGV=GV.MAGV
group by HOTEN,GV.MAGV
having count(distinct TG1.MADT)=(
	select count(MADT)
	from DETAI
	where KINHPHI > 100
)

--Q70
select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM, KHOA K
		where GV.MABM=BM.MABM and BM.MAKHOA=K.MAKHOA and K.TENKHOA=N'Sinh Học'
		except
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT
	where not exists (
		select GV.MAGV
		from GIAOVIEN GV, BOMON BM, KHOA K
		where GV.MABM=BM.MABM and BM.MAKHOA=K.MAKHOA and K.TENKHOA=N'Sinh Học' and not exists (
		select TG.MAGV
		from THAMGIADT TG
		where TG.MADT=DT.MADT and TG.MAGV=GV.MAGV
		)
	)
)

select TENDT
from DETAI DT
where DT.MADT in (
	select DT.MADT
	from DETAI DT,THAMGIADT TG,GIAOVIEN GV, BOMON BM, KHOA K
	where TG.MADT=DT.MADT and TG.MAGV=GV.MAGV and GV.MABM=BM.MABM and BM.MAKHOA=K.MAKHOA and K.TENKHOA=N'Sinh Học'
	group by DT.MADT
	having count(distinct TG.MAGV)=(
		select count(GV.MAGV)
		from GIAOVIEN GV, BOMON BM, KHOA K
		where GV.MABM=BM.MABM and BM.MAKHOA=K.MAKHOA and K.TENKHOA=N'Sinh Học'
	)
)

--Q71
select GV.MAGV,GV.HOTEN,GV.NGSINH
from GIAOVIEN GV
where not exists(
	select CV.MADT,CV.SOTT
	from CONGVIEC CV, DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Ứng dụng hóa học xanh'
	except
	select distinct TG1.MADT,TG1.STT
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV
	)

select GV.MAGV,GV.HOTEN,GV.NGSINH
from GIAOVIEN GV
where not exists(
	select *
	from CONGVIEC CV, DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Ứng dụng hóa học xanh' and not exists(
	select *
	from THAMGIADT TG1
	where TG1.MAGV=GV.MAGV and TG1.MADT=CV.MADT and TG1.STT=CV.SOTT
	)
)

select GV.MAGV,GV.HOTEN,GV.NGSINH
from GIAOVIEN GV,THAMGIADT TG1
where TG1.MAGV=GV.MAGV
group by GV.MAGV,GV.HOTEN,GV.NGSINH
having count(distinct TG1.STT)=(
	select count(*)
	from CONGVIEC CV, DETAI DT
	where CV.MADT=DT.MADT and DT.TENDT=N'Ứng dụng hóa học xanh'
	)

--Q72
select GV1.HOTEN
from GIAOVIEN GV, GIAOVIEN GV1
where GV.GVQLCM = GV1.MAGV and not exists (
	select CD.MACD
	from CHUDE CD
	where CD.TENCD=N'Nghiên cứu phát triển'
	except
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV
)

select GV1.HOTEN
from GIAOVIEN GV, GIAOVIEN GV1
where GV.GVQLCM = GV1.MAGV and not exists (
	select CD.MACD
	from CHUDE CD
	where CD.TENCD=N'Nghiên cứu phát triển' and not exists (
	select DT.MACD
	from THAMGIADT TG2,GIAOVIEN GV2,DETAI DT
	where TG2.MAGV=GV2.MAGV and DT.MADT=TG2.MADT and GV2.MAGV=GV.MAGV and CD.MACD=DT.MACD
	)
)


select distinct GV1.HOTEN
from GIAOVIEN GV,THAMGIADT TG,DETAI DT, CHUDE CD,GIAOVIEN GV1
where TG.MAGV=GV.MAGV and DT.MADT=TG.MADT and DT.MACD=CD.MACD and CD.TENCD=N'Nghiên cứu phát triển' and GV1.MAGV=GV.GVQLCM
group by GV.HOTEN,GV.MAGV,GV1.HOTEN
having count(distinct DT.MACD)=(
	select count(MACD)
	from CHUDE
	where TENCD=N'Nghiên cứu phát triển'
)