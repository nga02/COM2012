-----Tạo database
create database QLBH_on3
---bảng Khách hàng
if OBJECT_ID('khachhang') is not null
 drop table khachhang
 go
 create table khachhang
 (
	ma_kh varchar(10) not null,
	ho_dem nvarchar(40) null,
	ten  nvarchar(20) null,
	dia_chi nvarchar(50) null,
	email nvarchar(50) null,
	sdt nvarchar(15) null,
	constraint pk_khachhang primary key(ma_kh)
)
------bảng sản phẩm
if OBJECT_ID('sanpham') is not null
 drop table sanpham
 go
 create table sanpham
 (
	ma_sp varchar(10) not null,
	ten_sp  nvarchar(50) null,
	sl_ton int   null,
	dongia money null,
	mota    nvarchar(50) null,
	constraint pk_sanpham primary key(ma_sp)
)
------bảng hóa đơn
if OBJECT_ID('hoadon') is not null
 drop table hoadon
 go
 create table hoadon
 (
	ma_hd varchar(10) not null,
	ngaymua date null,
	ma_kh varchar(10) not null,
	trangthai nvarchar(50) null,
	constraint pk_hoadon primary key(ma_hd),
	constraint fk_hoadon_khachhang foreign key(ma_kh)
				references khachhang
)
------bảng hóa đơn chi tiết
if OBJECT_ID('hoadonct') is not null
 drop table hoadonct
 go
 create table hoadonct
 (
	ma_hd varchar(10) not null,
	ma_sp varchar(10) not null,
	slmua int null,
	constraint fk_hoadonct_hoadon foreign key(ma_hd)
				references hoadon,
	constraint fk_hoaodnct_sanpham foreign key(ma_sp)
				references sanpham,
	constraint pk_hoadonct primary key(ma_hd,ma_sp)
)
---Chèn dữ liệu
delete from khachhang
insert into khachhang values
	('KH01', N'LE THỊ',N'NGA',N'THANH HÓA','NGALTPH26840@FPT.EDU.VN','0763058638'),
	('KH02', N'NGUYỄN THỊ',N'LOAN',N'HÀ NỘI','LOANNT@FPT.EDU.VN','0359815872'),
	('KH03', N'VŨ ANH ',N'TÚ',N'ĐÀ NẴNG','TUNT@FPT.EDU.VN','0359815834'),
	('KH04', N'DÀO ANH',N'QUANG',N'THÁI BÌNH','QUANGNT@FPT.EDU.VN','0359815868'),
	('KH05', N'VŨ THỊ',N'NHÀN',N'NAM ĐỊNH','NHANNT@FPT.EDU.VN','0359815826')
delete from sanpham
insert into sanpham values
	('SP01','IPHONE 7',11,4000000,N'HÀNG MỚI'),
	('SP02','IPHONE 6',5,2000000,N'HÀNG 99%'),
	('SP03','SAMSUNG',20,12000000,N'HÀNG MỚI'),
	('SP04','IPHONE 10',7,19000000,N'HÀNG MỚI'),
	('SP05','VERTUR',2,8000000,N'HÀNG MỚI')

delete from hoadon
insert into hoadon values
	('HD01','1/18/2022','KH05',N'ĐÃ THANH TOÁN'),
	('HD02','1/12/2022','KH01',N'CHƯA THANH TOÁN'),
	('HD03','1/2/2022','KH02',N'ĐÃ THANH TOÁN'),
	('HD04','1/11/2022','KH01',N'ĐÃ THANH TOÁN'),
	('HD05','1/10/2022','KH03',N'CHƯA THANH TOÁN')

delete from hoadonct
insert into hoadonct values
	('HD05', 'SP01',4),
	('HD05', 'SP05',1),
	('HD01', 'SP04',7),
	('HD02', 'SP02',8),
	('HD02', 'SP01',3)

select * from khachhang
select * from sanpham
select * from hoadon 
select * from hoadonct

----Truy vấn
-------Lab 5
-------Câu 1;
/*1. Hiển thị tất cả thông tin có trong bảng khách hàng bao gồm tất cả các cột */
select * from khachhang

/*2. Hiển thị 3 KHÁCH HÀNG ĐẦU TIÊN  trong bảng khách hàng bao gồm các cột: mã
khách hàng, họ và tên, email, số điện thoại*/
select top 3 ma_kh,ho_dem,ten,email,sdt from khachhang

/*c3. Hiển thị thông tin từ bảng Sản phẩm gồm các cột: mã sản phẩm, tên sản phẩm,
tổng tiền tồn kho. Với tổng tiền tồn kho = đơn giá* số lượng*/
select ma_sp,ten_sp,dongia*sl_ton as [TỔNG TIỀN TỒN KHO]
from sanpham

/*d4. Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘L’ gồm các cột:
maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột
hoVaTenLot và Ten*/
select ma_kh, ho_dem + ' ' + ten as [HỌ VÀ TÊN], dia_chi
from khachhang 
where ten like N'L%'

/*e5. Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Đà Nẵng’*/
select * from khachhang 
where dia_chi like N'ĐÀ NẴNG%'

/*f6. Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 4 đén 15*/
select * from sanpham
where sl_ton between 4 and 15

/*g7. Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng
trong năm 2016*/
select * from hoadon 
where trangthai like N'chưa thanh toán%' and year(ngaymua) =2022

/*h8. Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH01, KH03,
KH05*/
select * from khachhang 
where ma_kh='kh01' or ma_kh = 'kh03' or ma_kh = 'kh05'

/*Bài 2 (4 điểm) Viết các câu truy vấn sau:*/
/*a. Hiển thị số lượng khách hàng có trong bảng khách hàng*/
select count(*) as soluongKH 
from khachhang

/*b. Hiển thị đơn giá lớn nhất trong bảng SanPham*/
select max(dongia) as [Đơn giá lớn nhất]
from sanpham

/*c. Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm*/
select min(sl_ton) as [SỐ LƯỢNG TỒN THẤP NHẤT] 
FROM sanpham

/*d. Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm*/
select sum(sl_ton) as [TỔNG SỐ LƯỢNG TỒN]
FROM sanpham

/*e. Hiển thị số hoá đơn đã xuất trong tháng 1/2022 mà có trạng thái chưa thanh toán*/
select * from hoadon
where trangthai like N'CHƯA THANH TOÁN %' and year(ngaymua)=2022 and month(ngaymua)=1

 /*KHÔNG HIỂU*/
/*f. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn*/
select ma_hd, count(ma_sp) as [SỐ LƯỢNG SẢN PHẨM]
FROM HOADONCT															                              /*KHÔNG HIỂU*/
GROUP BY ma_hd 

 /*KHÔNG HIỂU*/
/*g. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. 
Yêu cầu	chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5.*/
SELECT ma_hd, COUNT(ma_sp) AS SOLOAISP
FROM hoadonct
GROUP BY ma_hd
HAVING COUNT(ma_sp) >=2

/*h. Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang,
maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang */

select ma_hd, ngaymua,ma_kh 
from hoadon 
order by ngaymua desc

-------lab 6
----Bài 1 (4 điểm) Viết các câu truy vấn sau:
/*a. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột 
sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua*/
select hoadon.ma_hd,ma_kh,trangthai,ma_sp,slmua,ngaymua
from hoadon join hoadonct on hoadonct.ma_hd=hoadon.ma_hd

/*b. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột 
sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với 
điều kiện maKhachHang = ‘KH001’*/
select hoadon.ma_hd,ma_kh,trangthai,ma_sp,slmua,ngaymua
from hoadon join hoadonct on hoadonct.ma_hd=hoadon.ma_hd
where ma_kh='KH01'
/*c. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột 
sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành 
tiền. Với thành tiền= donGia* soLuong */
select hoadon.ma_hd,ngaymua,ten_sp,dongia,slmua,dongia*slmua as [Thành tiền] --Thành tiền ở dday là chỉ tổng tiền của 4 cái iphone7 
from hoadon join hoadonct on hoadonct.ma_hd=hoadon.ma_hd
			join sanpham on sanpham.ma_sp=hoadonct.ma_sp
/*d. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các 
cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và 
tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh 
toán.*/
select ho_dem,ten,email,sdt,hoadon.ma_hd,trangthai,sum(dongia*slmua) as [Tổng tiền]----TÍnh tổng tiền người đó cần phải trả
from khachhang join hoadon on khachhang.ma_kh=hoadon.ma_kh
			   join hoadonct on hoadonct.ma_hd=hoadon.ma_hd
			   join sanpham on sanpham.ma_sp=hoadonct.ma_sp
where trangthai like N'chưa thanh toán%'
group by ho_dem,ten,email,sdt,hoadon.ma_hd,trangthai                                ----vì sử dụng hàm nên phải nhóm lại với nhau
/*e. Hiển thị maHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ
hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần 
của cột tổng tiền.*/
select hoadon.ma_hd,ngaymua,sum(dongia*slmua) as [Tổng tiền]
from hoadon join hoadonct on hoadon.ma_hd=hoadonct.ma_hd
			join sanpham on sanpham.ma_sp=hoadonct.ma_sp
group by hoadon.ma_hd,ngaymua 
having sum(dongia*slmua) >=500000 
/* trường hợp sắp xếp theo thứ thự tăng dần: ORDER BY  SUM(DONGIA*SLMUA) ASC */
 ORDER BY  SUM(DONGIA*SLMUA) ASC

							/* XEM LẠI NHÉ*/

/*Bài 2 (4 điểm) Viết các câu truy vấn sau:*/
/*a. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2022*/
select * from khachhang 
where not exists (select * from hoadon 
				 where khachhang.ma_kh = hoadon.ma_kh and
				 year(ngaymua) = 2022 and month(ngaymua) = 1)

/*b.Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2022*/
select top 1 sanpham.ma_sp,ten_sp,count(hoadonct.ma_sp) as soluotmua
from hoadonct join sanpham on sanpham.ma_sp = hoadonct.ma_sp
group by sanpham.ma_sp,ten_sp
order by soluotmua desc

/*c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016*/
select top 2 ma_kh,sum(slmua * dongia) as tongtt
from hoadon join hoadonct on hoadon.ma_hd = hoadonct.ma_hd
			join sanpham on sanpham.ma_sp = hoadonct.ma_sp
where year(ngaymua) = 2022
group by ma_kh
order by tongtt desc

/*d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên 
“Iphone 7 32GB” trong tháng 12/2016*/
select khachhang.*,ten_sp,ngaymua
from khachhang join hoadon on khachhang.ma_kh = hoadon.ma_kh
				join hoadonct on hoadon.ma_hd = hoadonct.ma_hd
				join sanpham on sanpham.ma_sp = hoadonct.ma_sp
where dia_chi = N'ĐÀ NẴNG' and ten_sp = N'IPHONE 7' and year(ngaymua)=2022 and 
month(ngaymua) = 1

/*e. Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các các sản 
phẩm.*/

select ten_sp,slmua
from sanpham join hoadonct on sanpham.ma_sp = hoadonct.ma_sp
where slmua < (select avg(slmua) from hoadonct)