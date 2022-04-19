go
use QLDT
go

--Q1
go
if object_id('sp_PhanCongGV','p') is not null
	drop proc sp_PhanCongGV
go

go
create procedure sp_PhanCongGV @magv char(5), @madt char(3),@stt int
as
	if(exists(
		select count(*)
		from THAMGIADT
		where @magv=MAGV
		group by MAGV, MADT,STT
		having count(*)<=3
	))
	begin
		insert into THAMGIADT values (@magv,@madt,@stt,null,null)
		print N'Hợp lệ'
	end
	else
		print (N'Số lượng công việc quá quy định')
go

go
exec sp_PhanCongGV '002', '006', 2
go

--Q2
go
if object_id('sp_CapNhatNgayKT','p') is not null
	drop proc sp_CapNhatNgayKT
go

go
create procedure sp_CapNhatNgayKT @madt char(3),@ngaykt datetime
as
	declare @capql nvarchar(40) = (select CAPQL from DETAI where @madt=MADT)
	declare @ngaybd datetime = (select NGAYBD from DETAI where @madt = MADT)
	if(datediff(month,@ngaybd,@ngaykt)>=3 and datediff(m,@ngaybd,@ngaykt)<=6 and @capql = N'Trường')
	begin
		update DETAI set NGAYKT=@ngaykt where MADT=@madt
		print N'Cập nhật thành công'
	end
	else if(datediff(month,@ngaybd,@ngaykt)>=6 and datediff(m,@ngaybd,@ngaykt)<=9 and @capql = N'ĐHQG')
	begin
		update DETAI set NGAYKT=@ngaykt where MADT=@madt
		print N'Cập nhật thành công'
	end
	else if(datediff(month,@ngaybd,@ngaykt)>=12 and datediff(m,@ngaybd,@ngaykt)<=24 and @capql = N'Nhà nước')
	begin
		update DETAI set NGAYKT=@ngaykt where MADT=@madt
		print N'Cập nhật thành công'
	end
	else
		print N'Cập nhật thất bại'
go

go
exec sp_CapNhatNgayKT '001', '2008-5-20'
go

--Q3
go
if object_id('sp_CapNhatGVQLCM','p') is not null
	drop proc sp_CapNhatGVQLCM
go

go
create procedure sp_CapNhatGVQLCM @magv char(5), @gvqlcm char(5)
as
	declare @mabm_gvqlcm char(3)=(select MABM from GIAOVIEN where MAGV=@gvqlcm)
	declare @mabm_gv char(3)=(select MABM from GIAOVIEN where MAGV=@magv)
	if (@mabm_gv=@mabm_gvqlcm)
	begin
		update GIAOVIEN set GVQLCM=@gvqlcm where @magv=MAGV
		print N'Cập nhật thành công'
	end
	else
		print N'Cập nhật thất bại'

go

go
exec sp_CapNhatGVQLCM '002', '003'
go

--Q4
go
if object_id('fDemDT',N'FN') is not null
	drop function fDemDT
go

go
create function fDemDT (@magv char(5))
returns int
as
begin
	declare @demDT int=(select count(distinct MADT) from THAMGIADT where MAGV=@magv)
	return @demDT
end
go

--Q5
go
if object_id('sp_GV_ThamGiaDT','p') is not null
	drop proc sp_GV_ThamGiaDT
go

go
create procedure sp_GV_ThamGiaDT
as
	select MAGV,HOTEN,TENBM from GIAOVIEN, BOMON where GIAOVIEN.MABM=BOMON.MABM and dbo.fDemDT(MAGV) > 3
go

exec sp_GV_ThamGiaDT
go

--Q6
go
if object_id('fDemCNDT',N'FN') is not null
	drop function fDemCNDT
go

go
create function fDemCNDT (@magv char(5))
returns int
as
begin
	declare @demDT int=(select count(*) from DETAI where GVCNDT=@magv)
	return @demDT
end
go


--Q7
go
if object_id('sp_Gv_HTTT_SLDTCN','p') is not null
	drop proc sp_Gv_HTTT_SLDTCN
go

go
create procedure sp_Gv_HTTT_SLDTCN
as
	select MAGV,HOTEN,dbo.fDemCNDT(MAGV) as N'Số lượng đề tài tham gia' from GIAOVIEN where MABM='HTTT'
go

exec sp_Gv_HTTT_SLDTCN
go