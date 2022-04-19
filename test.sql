--Q1
select HoTen, count(MaHD) as N'Số lượng đơn hàng'
from KhachHang, HoaDon
where KhachHang.MaKH=HoaDon.MaKH
group by HoTen

--Q2
select HoTen
from KhachHang, HoaDon, CTHoaDon, SanPham, LoaiSanPham
where KhachHang.MaKH=HoaDon.MaKH and HoaDon.MaHD=CTHoaDon.MaHD
	and SanPham.MASP=CTHoaDon.MASP and SanPham.MaLoai=LoaiSanPham.MaLoai
	and LoaiSanPham.TenLoai=N'Nồi cơm điện'

--Q3

go
	if OBJECT_ID('sp_ThemDonHang','p') is not null
		drop proc sp_ThemDonHang
go

go
create procedure sp_ThemDonHang @MaKH varchar(5), @MaHD varchar(5), @MaSP varchar(5), @SoLuong int
as
	declare @check int = (select count(MaKH) from KhachHang where MaKH=@MaKH)
	if (@check = 0)
	begin
		print N'Lỗi: Mã khách hàng chưa tồn tại'
		return
	end
	
	set @check = (select count(MaHD) from HoaDon where MaHD=@MaHD)
	if (@check != 0)
	begin
		print N'Lỗi: Mã hóa đơn đã tồn tại'
		return
	end

	set @check = (select count(MASP) from SanPham where @MaSP=MASP)
	if (@check = 0)
	begin
		print N'Lỗi: Mã sản phẩm chưa tồn tại'
		return
	end

	set @check = (select SLTon-@SoLuong from SanPham where @MaSP=MASP)
	if (@check < 0)
	begin
		print N'Lỗi: Số lượng không hợp lệ'
		return
	end

	insert into HoaDon values(@MaHD,getdate(),@MaKH,null)
	insert into CTHoaDon values(@MaHD,@MaSP,@SoLuong,(select GiaTien from SanPham where MASP=@MaSP))
go

go
exec sp_ThemDonHang 'KH01', 'HD08', 'SP07', 99
go