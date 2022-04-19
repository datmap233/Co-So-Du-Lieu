--a In ra câu chào “Hello World !!!”.
if object_id('sp_print','p') is not null
	drop proc sp_print
create procedure sp_print
AS
	print('Hello World !!!')
exec sp_print

--b In ra tổng 2 số.
if object_id('sp_InTong','p') is not null
	drop proc sp_InTong
create procedure sp_InTong @So1 int, @So2 int
AS
	print @So1 + @So2;
exec sp_InTong 1, -2

--c Tính tổng 2 số (sử dụng biến output để lưu kết quả trả về).
if object_id('sp_Tong','p') is not null
	drop proc sp_Tong
create procedure sp_Tong @So1 int, @So2 int, @Tong int out
AS
	SET @Tong = @So1 + @So2;
declare @Sum int
exec sp_Tong 1, -2, @Sum out
print @Sum

--d In ra tổng 3 số (Sử dụng lại stored procedure Tính tổng 2 số).
if object_id('sp_Tong3','p') is not null
	drop proc sp_Tong3
create procedure sp_Tong3 @So1 int, @So2 int, @So3 int, @Tong int out
AS
	exec sp_Tong @So1, @So2, @Tong out
	exec sp_Tong @Tong, @So3, @Tong out
declare @Sum int
exec sp_Tong3 1, -2, 3, @Sum out
print @Sum

--e In ra tổng các số nguyên từ m đến n.
if object_id('sp_TongMN','p') is not null
	drop proc sp_TongMN
create procedure sp_TongMN @m int, @n int
AS
	declare @Tong int
	declare @i int
	set @Tong = 0
	set @i = @m
	while (@i < @n)
		begin
			set @Tong = @Tong + @i
			set @i = @i + 1
		end
			print @tong

exec sp_TongMN 1,20

--f Kiểm tra 1 số nguyên có phải là số nguyên tố hay không.
if object_id('sp_KTSoNguyenTo','p') is not null
	drop proc sp_KTSoNguyenTo

create procedure sp_KTSoNguyenTo @n int
AS
	declare @i int
	set @i = 2
	while (@i < @n/2)
		begin
		if (@n = 2)
			begin
				print 'La So Nguyen To'
				return 1
			end
		else if(@n  % @i != 0)
			set @i = @i + 1
		else
			begin
				print 'Khong La So Nguyen To'
				return 0
			end
		end
			print 'La So Nguyen To'
			return 1

exec sp_KTSoNguyenTo 133

--g In ra tổng các số nguyên tố trong đoạn m, n.
if object_id('sp_TongNguyenTo','p') is not null
	drop proc sp_TongNguyenTo

create procedure sp_TongNguyenTo @m int, @n int
AS
	declare @Tong int
	declare @i int
	set @Tong = 0
	set @i = @m
	while (@i <= @n)
		begin
			if (@i >= 2)
			begin
				if (@i = 2)
				begin
					set @Tong = @Tong + @i
					set @i = @i + 1
					continue
				end
				else
				begin
					declare @j int
					set @j = 2
					while (@j < @i/2)
					begin
						if(@i % @j = 0)
							break
						else
							set @j = @j + 1
					end
						if(@i % @j != 0)
						set @Tong = @Tong + @i
						set @i = @i + 1
				end
			end
			else
				set @i = @i + 1
		end
			print @Tong

exec sp_TongNguyenTo 1,10

--h Tính ước chung lớn nhất của 2 số nguyên.
if object_id('sp_UCLN','p') is not null
	drop proc sp_UCLN

create procedure sp_UCLN @m int,@n int
AS
	declare @i int
	declare @j int
	set @i = @m
	set @j = @n
	while (@j!=0)
		begin
			declare @tmp int
			set @tmp =@i%@j
			set @i = @j
			set @j = @tmp
		end
			print @i
exec sp_UCLN 2,3


--i Tính bội chung nhỏ nhất của 2 số nguyên.
if object_id('sp_BCNN','p') is not null
	drop proc sp_BCNN

create procedure sp_BCNN @m int,@n int
AS
	declare @i int
	declare @j int
	declare @a int
	declare @b int
	set @i = 1
	set @j = 1
	set @a = @m
	set @b = @n
	while (@a* @i!=@b* @j)
		begin
			if(@a* @i < @b* @j)
				set @i = @i + 1
			else
				set @j = @j + 1
		end
			print @a * @i
exec sp_BCNN 2,11

--j Xuất ra toàn bộ danh sách giáo viên.
if object_id('sp_DSGV','p') is not null
	drop proc sp_DSGV

create procedure sp_DSGV
as
	select *
	from GIAOVIEN
exec sp_DSGV

--k Tính số lượng đề tài mà một giáo viên đang thực hiện.
if object_id('sp_SLDT','p') is not null
	drop proc sp_SLDT

create procedure sp_SLDT @magv char(3), @sldt int out
as
	select @sldt = count(THAMGIADT.MADT)
	from GIAOVIEN left join THAMGIADT on GIAOVIEN.MAGV=THAMGIADT.MAGV
	where GIAOVIEN.MAGV=@magv

declare @sl_dt int
exec sp_SLDT '003',@sl_dt out
print @sl_dt

--l In thông tin chi tiết của một giáo viên(sử dụng lệnh print): Thông tin cá 
--nhân, Số lượng đề tài tham gia, Số lượng thân nhân của giáo viên đó.
if object_id('sp_ThongTinGV','p') is not null
	drop proc sp_ThongTinGV
create procedure sp_ThongTinGV @magv char(3)
as
	declare @ten nvarchar(50)=(select HOTEN from GIAOVIEN where MAGV=@magv)
	declare @luong int=(select LUONG from GIAOVIEN where MAGV=@magv)
	declare @phai nvarchar(50)=(select PHAI from GIAOVIEN where MAGV=@magv)
	declare @ngsinh char(50)=(select NGSINH from GIAOVIEN where MAGV=@magv)
	declare @diachi nvarchar(50)=(select DIACHI from GIAOVIEN where MAGV=@magv)
	declare @gvql char(3)=(select GVQLCM from GIAOVIEN where MAGV=@magv)
	declare @mabm varchar(5)=(select MABM from GIAOVIEN where MAGV=@magv)
	declare @sodt int=(select count(distinct madt) from THAMGIADT where MAGV=@magv)
	declare @sothannhan int=(select count(*) from NGUOITHAN where MAGV=@magv)
	print 'Ma Giao Vien: ' + @magv
	print 'Ho Ten: ' + @ten
	print 'Luong: ' + cast(@luong as varchar) 
	print 'Phai: ' + cast(@phai as nvarchar)
	print 'Ngay Sinh: ' + @ngsinh
	print 'Dia Chi: ' + @diachi
	print 'GVQLCM: ' + @gvql
	print 'Ma Bo Mon: ' + @mabm
	print 'So Luong De Tai Tham Gia: ' + cast(@sodt as char)
	print 'So Luong Nhan Than: ' + cast(@sothannhan as char)

exec sp_ThongTinGV '003'

--m Kiểm tra xem một giáo viên có tồn tại hay không (dựa vào MAGV).
if object_id('sp_KTGV','p') is not null
	drop proc sp_KTGV
create procedure sp_KTGV @magv char(3), @kq int out
as
	if (
		exists(
			select*
			from GIAOVIEN
			where @magv=MAGV
		)
	)
	set @kq = 1
	else
		set @kq = 0

declare @TonTai int
exec sp_KTGV '002',@TonTai out
if (@TonTai = 1)
	print 'Ton Tai'
else
	print 'Khong Ton Tai'

--n Kiểm tra quy định của một giáo viên: Chỉ được thực hiện các đề tài mà bộ
--môn của giáo viên đó làm chủ nhiệm.
if object_id('sp_KTBM_DT','p') is not null
	drop proc sp_KTBM_DT
create procedure sp_KTBM_DT @magv char(3), @madt char(3), @kq int out
as
	if (
		exists(
			select*
			from BOMON,DETAI
			where @magv=BOMON.TRUONGBM and DETAI.GVCNDT=BOMON.TRUONGBM and @madt=DETAI.MADT
		)
	)
	set @kq = 1
	else
		set @kq = 0

declare @ThucHien int
exec sp_KTBM_DT '002','005', @ThucHien out
if (@ThucHien = 1)
	print 'Duoc Thuc Hien'
else
	print 'Khong Duoc Thuc Hien'

--o Thực hiện thêm một phân công cho giáo viên thực hiện một công việc của đề tài:
--Kiểm tra thông tin đầu vào hợp lệ: giáo viên phải tồn tại, công việc phải tồn tại, thời gian tham gia phải >0
--Kiểm tra quy định ở câu n.

--làm xong em không hiểu đề luôn
if object_id('sp_ThemCV','p') is not null
	drop proc sp_ThemCV
if object_id('sp_KTCV','p') is not null
	drop proc sp_KTCV
if object_id('sp_KTTG','p') is not null
	drop proc sp_KTTG
create procedure sp_KTCV
	@madt char(3),
	@stt int,
	@kq int out
as
	if (
		exists(
			select*
			from CONGVIEC
			where @madt=CONGVIEC.MADT and @stt=CONGVIEC.SOTT
		)
	)
	set @kq = 1
	else
		set @kq = 0

create procedure sp_KTTG
	@ngaybd datetime,
	@ngaykt datetime,
	@kq int out
as
	if ( datediff(d,@ngaykt,@ngaybd) < 0)
		set @kq = 1
	else
		set @kq = 0

create procedure sp_ThemCV
	@magv char(5),
	@madt char(3),
	@stt int,
	@tencv nvarchar(40),
	@ngaybd datetime,
	@ngaykt datetime,
	@kq int out
as
	--Kiểm tra câu n
	declare @checkBM_DT int
	exec sp_KTBM_DT @magv,@madt, @checkBM_DT out
	--Kiểm tra tồn tại giáo viên
	declare @checkGV_DT int
	exec sp_KTGV @magv, @checkGV_DT out
	--Kiểm tra tồn tại công việc
	declare @checkTCV int
	exec sp_KTCV @madt,@stt, @checkTCV out
	--Kiểm tra ngày tháng
	declare @checkTG int
	exec sp_KTTG @ngaybd,@ngaykt, @checkTG out
	if (@checkBM_DT = 1 and @checkGV_DT = 1 and @checkTCV = 1 and @checkTG = 1)
		begin
		set @kq = 1
		insert into THAMGIADT values (@magv, @madt, @stt, null, null)
		insert into CONGVIEC values (@madt, @stt, @tencv, @ngaybd, @ngaykt)
		end
	else
		set @kq = 0

declare @ThucHien int
exec sp_ThemCV '002','001', 1,N'Cài đặt thử nghiệm','2006-10-20','2007-02-20', @ThucHien out
if (@ThucHien = 1)
	print 'Da Thuc Hien'
else
	print 'Khong Duoc Thuc Hien'

--p Thực hiện xoá một giáo viên theo mã. Nếu giáo viên có thông tin liên quan
--(Có thân nhân, có làm đề tài, ...) thì báo lỗi.
if object_id('sp_XoaGV','p') is not null
	drop proc sp_XoaGV
create procedure sp_XoaGV @magv char(3)
as
	declare @check int
	set @check = 1

	if(	@magv in (
			select MAGV
			from THAMGIADT ))
	set @check = 0
	
	if(	@magv in (
			select GVCNDT
			from DETAI ))
	set @check = 0

	if(	@magv in (
			select MAGV
			from NGUOITHAN ))
	set @check = 0

	if(	@magv in (
			select TRUONGBM
			from BOMON ))
	set @check = 0

	if(	@magv in (
			select TRUONGKHOA
			from KHOA ))
	set @check = 0

	if(@check = 1)
	begin
		delete from GIAOVIEN
		where @magv=MAGV
		print 'Da Xoa'
	end
	else
		print 'Xoa That Bai'
exec sp_XoaGV '011'

--q In ra danh sách giáo viên của một phòng ban nào đó cùng với số lượng đề
--tài mà giáo viên tham gia, số thân nhân, số giáo viên mà giáo viên đó quản
--lý nếu có, ...
if object_id('sp_DSGV_PhongBan','p') is not null
    drop proc sp_DSGV_PhongBan

create procedure sp_DSGV_PhongBan @mabm nchar(5)
as
	select *, 
		(select count(distinct MADT) from THAMGIADT where GV.MAGV = THAMGIADT.MAGV) AS sldttg,
		(select count(TEN) from NGUOITHAN WHERE GV.MAGV = NGUOITHAN.MAGV) AS slnt,
		(select count(GV1.MAGV) from GIAOVIEN GV1 WHERE GV1.MAGV = GV.MAGV) AS slgvql	
	FROM GIAOVIEN GV
	WHERE @mabm = MABM

exec sp_DSGV_PhongBan 'HTTT'

--r Kiểm tra quy định của 2 giáo viên a, b: Nếu a là trưởng bộ môn c của b thì
--lương của a phải cao hơn lương của b. (a, b: mã giáo viên)
if object_id('sp_KTLuong','p') is not null
	drop proc sp_KTLuong
create procedure sp_KTLuong @magv1 char(3),@magv2 char(3)
as
	declare @check int
	set @check = 0
	if (@magv1 in (
		select TRUONGBM
		from GIAOVIEN join BOMON on GIAOVIEN.MABM=BOMON.MABM
		where GIAOVIEN.MAGV=@magv2
	))
	begin
		declare @luong1 float,@luong2 float

		select @luong1=LUONG
		from GIAOVIEN
		where MAGV=@magv1

		select @luong2=LUONG
		from GIAOVIEN
		where MAGV=@magv2

		if (@luong1 <= @luong2)
			set @check = 1
	end
	if(@check = 0)
		print 'Dung quy dinh'
	else
		print 'Sai quy dinh'

exec sp_KTLuong '003', '002'


--s Thêm một giáo viên: Kiểm tra các quy định: Không trùng tên, tuổi > 18, lương > 0
if object_id('sp_ThemGV','p') is not null
	drop proc sp_ThemGV
create procedure sp_ThemGV
	@magv char(5),
	@hoten nvarchar(40),
	@luong float,
	@phai nchar(3),
	@ngsinh datetime,
	@diachi nvarchar(100),
	@gvqlcm char(5),
	@mabm nchar(5)
as
	declare @check int
	set @check = 1
	if(@hoten in (
		select hoten
		from giaovien))
		set @check = 0
	if(datediff(y, @ngsinh, getdate()) <= 18)
		set @check = 0
	if(@luong < 0)
		set @check = 0
	if(@check = 1)
	begin
		insert into GIAOVIEN values (@magv, @hoten, @luong, @phai, @ngsinh, @diachi, @gvqlcm, @mabm)
		print 'Da Them'
	end
	else
		print 'Khong Them Duoc'

exec sp_ThemGV '011', N'Đạt', 1500.0, null, '03-06-2002', null, null, null


--t Mã giáo viên được xác định tự động theo quy tắc: Nếu đã có giáo viên 001,
--002, 003 thì MAGV của giáo viên mới sẽ là 004. Nếu đã có giáo viên 001,
--002, 005 thì MAGV của giáo viên mới là 003.
if object_id('sp_ThemMaGV_TuDong','p') is not null
	drop proc sp_ThemMaGV_TuDong
create procedure sp_ThemMaGV_TuDong 
	@ten nvarchar(40),
	@luong float,
	@phai nchar(3),
	@ngsinh datetime,
	@dchi nvarchar(100),
	@gcqlcm char(5),
	@mabm nchar(3)
as
	declare @stt int
	set @stt = 1
	while exists(select * from GIAOVIEN where MAGV = @stt)
		begin
			set @stt = @stt + 1
		end
exec sp_ThemMaGV_TuDong 'Dat', 2000, 'Nam', '03-06-2002', 'TPHCM', '001', 'HTTT'
