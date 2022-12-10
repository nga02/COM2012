---- Tao CSDL
CREATE DATABASE QLBHANG
---Tao Bang
------BANG KHÁCH HÀNG
IF OBJECT_ID('KHACHHANG') IS NOT NULL
   DROP TABLE KHACHHANG
GO
CREATE TABLE KHACHHANG
(
   MAKH     NVARCHAR(10) NOT NULL,
   HODEM    NVARCHAR(30) NULL,
   TEN      NVARCHAR(10) NULL,
   DIACHI   NVARCHAR(50) NULL,
   EMAIL    NVARCHAR(50) NULL,
   SDT      NVARCHAR(15) NULL,
  CONSTRAINT  PK_KHACHHANG PRIMARY KEY(MAKH)
)

-----BẢNG SẢN PHẨM
IF OBJECT_ID('SANPHAM') IS NOT NULL
   DROP TABLE SANPHAM
GO
CREATE TABLE SANPHAM
(
   MASP   NVARCHAR(10) NOT NULL,
   TENSP  NVARCHAR(30) NULL,
   SLTON  INT          NULL,
   DONGIA MONEY        NULL,
   MOTA   NVARCHAR(50) NULL,
   CONSTRAINT PK_SANPHAM PRIMARY KEY (MASP)
)
------BẢNG HÓA ĐƠN
IF OBJECT_ID('HOADON') IS NOT NULL
   DROP TABLE HOADON
GO
CREATE TABLE HOADON
(
     MAHD       NVARCHAR(10)     NOT NULL,
	 NGAYMUA    DATETIME         NULL,
	 MAKH       NVARCHAR(10)     NULL,
	 TRANGTHAI  NVARCHAR(50)     NULL,
	 CONSTRAINT PK_HOADON PRIMARY KEY (MAHD),
	 CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MAKH)
	         REFERENCES KHACHHANG
)
---BẢNG HÓA ĐƠN CT
IF OBJECT_ID('HOADONCT') IS NOT NULL
    DROP TABLE HOADONCT
GO
CREATE TABLE HOADONCT
(
   MAHD NVARCHAR(10)  NOT NULL,
   MASP NVARCHAR(10)  NOT NULL,
   SLMUA INT        NULL,
   CONSTRAINT FK_HOADONCT_HOADON  FOREIGN KEY (MAHD)
       REFERENCES HOADON,
   CONSTRAINT FK_HOADONCT_SANPHAM FOREIGN KEY (MASP)
	   REFERENCES SANPHAM,
   CONSTRAINT PK_HOADONCT PRIMARY KEY (MAHD,MASP)
)
----CHÈN DỮ LIỆU
----BẢNG KHÁCH HÀNG
DELETE FROM KHACHHANG
INSERT INTO KHACHHANG VALUES
	('KH01', N'LE THỊ',N'NGA',N'THANH HÓA','NGALTPH26840@FPT.EDU.VN','0763058638'),
	('KH02', N'NGUYỄN THỊ',N'LOAN',N'HÀ NỘI','LOANNT@FPT.EDU.VN','0359815872'),
	('KH03', N'VŨ ANH ',N'TÚ',N'ĐÀ NẴNG','TUNT@FPT.EDU.VN','0359815834'),
	('KH04', N'DÀO ANH',N'QUANG',N'THÁI BÌNH','QUANGNT@FPT.EDU.VN','0359815868'),
	('KH05', N'VŨ THỊ',N'NHÀN',N'NAM ĐỊNH','NHANNT@FPT.EDU.VN','0359815826')
----BẢNG SẢN PHẨM
DELETE FROM SANPHAM
INSERT INTO SANPHAM VALUES
	('SP01','IPHONE 7',11,4000000,N'HÀNG MỚI'),
	('SP02','IPHONE 6',5,2000000,N'HÀNG 99%'),
	('SP03','SAMSUNG',20,12000000,N'HÀNG MỚI'),
	('SP04','IPHONE 10',7,19000000,N'HÀNG MỚI'),
	('SP05','VERTUR',2,8000000,N'HÀNG MỚI')
---- BẢNG HÓA ĐƠN
DELETE FROM HOADON
INSERT INTO HOADON VALUES('HD01','1/18/2022','KH05',N'ĐÃ THANH TOÁN'),
						 ('HD02','1/12/2022','KH01',N'CHƯA THANH TOÁN'),
						 ('HD03','1/2/2022','KH02',N'ĐÃ THANH TOÁN'),
						 ('HD04','1/11/2022','KH01',N'ĐÃ THANH TOÁN'),
						 ('HD05','1/10/2022','KH03',N'CHƯA THANH TOÁN')
----BẢNG HÓA ĐƠN CT
DELETE FROM HOADONCT
INSERT INTO HOADONCT VALUES('HD05', 'SP01',4),
						   ('HD05', 'SP05',1),
						   ('HD01', 'SP04',7),
						   ('HD02', 'SP02',8),
						   ('HD02', 'SP01',3)
----TRUY VẤN
SELECT * FROM KHACHHANG
SELECT * FROM SANPHAM
SELECT * FROM HOADON
SELECT * FROM HOADONCT


-----------Lab 5
----Bài 1 (4 điểm) Viết các câu truy vấn sau:
/*a. Hiển thị tất cả thông tin có trong bảng khách hàng bao gồm tất cả các cột */
SELECT *FROM KHACHHANG
/*b. Hiển thị 10 khách hàng đầu tiên trong bảng khách hàng bao gồm các cột: mã
khách hàng, họ và tên, email, số điện thoại*/
SELECT TOP 3 MAKH, HODEM, TEN,EMAIL,SDT
FROM KHACHHANG   
/*c. Hiển thị thông tin từ bảng Sản phẩm gồm các cột: mã sản phẩm, tên sản phẩm,
tổng tiền tồn kho. Với tổng tiền tồn kho = đơn giá* số lượng*/
SELECT MASP, TENSP, SLTON, DONGIA, SLTON * DONGIA AS [TỔNG TIỀN]
FROM SANPHAM
/*d. Hiển thị danh sách khách hàng có tên bắt đầu bởi kí tự ‘H’ gồm các cột:
maKhachHang, hoVaTen, diaChi. Trong đó cột hoVaTen ghép từ 2 cột
hoVaTenLot và Ten*/
SELECT MAKH, HODEM + ' ' + TEN AS HOTEN,DIACHI
FROM KHACHHANG
WHERE TEN LIKE N'T%'
                        
/*e. Hiển thị tất cả thông tin các cột của khách hàng có địa chỉ chứa chuỗi ‘Đà Nẵng’*/
SELECT * FROM KHACHHANG
WHERE DIACHI like N'ĐÀ NẴNG%'            
                     
/*f. Hiển thị các sản phẩm có số lượng nằm trong khoảng từ 100 đến 500.*/
SELECT *FROM SANPHAM 
WHERE SLTON BETWEEN 10 AND 50 --SLTON>=10 AND SLTON<=50
/*g. Hiển thị danh sách các hoá hơn có trạng thái là chưa thanh toán và ngày mua hàng
trong năm 2016*/
SELECT *FROM HOADON 
WHERE TRANGTHAI LIKE N'CHƯA%' AND YEAR(NGAYMUA) = 2022
/*h. Hiển thị các hoá đơn có mã Khách hàng thuộc 1 trong 3 mã sau: KH001, KH003,
KH006*/
SELECT *FROM HOADON
WHERE MAKH ='KH01' OR MAKH ='KH03' OR MAKH = 'KH06'

/*Bài 2 (4 điểm) Viết các câu truy vấn sau:*/
/*a. Hiển thị số lượng khách hàng có trong bảng khách hàng*/
SELECT COUNT(*) AS SLKH
FROM KHACHHANG
/*b. Hiển thị đơn giá lớn nhất trong bảng SanPham*/
SELECT MAX(DONGIA) AS DGLN
FROM SANPHAM
/*c. Hiển thị số lượng sản phẩm thấp nhất trong bảng sản phẩm*/
SELECT MIN(SLTON) AS SLNN
FROM SANPHAM
/*d. Hiển thị tổng tất cả số lượng sản phẩm có trong bảng sản phẩm*/
SELECT SUM(SLTON) AS TONGSL FROM SANPHAM
/*e. Hiển thị số hoá đơn đã xuất trong tháng 1/2022 mà có trạng thái chưa thanh toán*/
SELECT *FROM HOADON
WHERE TRANGTHAI LIKE N'CHƯA%' AND YEAR (NGAYMUA) = 2022 AND MONTH(NGAYMUA)=1
/*f. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn*/
SELECT MAHD, COUNT(MASP) AS SOLOAISP
FROM HOADONCT
GROUP BY MAHD
/*g. Hiển thị mã hoá đơn và số loại sản phẩm được mua trong từng hoá đơn. Yêu cầu
chỉ hiển thị hàng nào có số loại sản phẩm được mua >=5.*/
SELECT MAHD, COUNT(MASP) AS SOLOAISP
FROM HOADONCT
GROUP BY MAHD
HAVING COUNT(MASP) >=2
/*h. Hiển thị thông tin bảng HoaDon gồm các cột maHoaDon, ngayMuaHang,
maKhachHang. Sắp xếp theo thứ tự giảm dần của ngayMuaHang */
SELECT MAHD, NGAYMUA,MAKH
FROM HOADON
ORDER BY NGAYMUA DESC
-----LAB 06
/*Bài 1 (4 điểm) Viết các câu truy vấn sau:
/*a. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột */
sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua*/
SELECT HOADON.MAHD, MAKH,TRANGTHAI,MASP,SLMUA,NGAYMUA
FROM HOADON JOIN HOADONCT ON HOADONCT.MAHD = HOADON.MAHD
/*b. Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột 
sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với 
điều kiện maKhachHang = ‘KH001’*/
SELECT HOADON.MAHD,MAKH, TRANGTHAI,MASP,SLMUA,NGAYMUA
FROM HOADON JOIN HOADONCT ON HOADONCT.MAHD = HOADON.MAHD
WHERE MAKH = 'KH01'
/*c. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột 
sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành 
tiền. Với thành tiền= donGia* soLuong */
SELECT HOADON.MAHD,NGAYMUA,TENSP,DONGIA,SLMUA,SLMUA *DONGIA AS THANHTIEN
FROM HOADON JOIN HOADONCT ON HOADON.MAHD =HOADONCT.MAHD
    JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
/*d. Hiển thị thông tin từ bảng khách hàng, bảng hoá đơn, hoá đơn chi tiết gồm các 
cột: họ và tên khách hàng, email, điện thoại, mã hoá đơn, trạng thái hoá đơn và 
tổng tiền đã mua trong hoá đơn. Chỉ hiển thị thông tin các hoá đơn chưa thanh 
toán.*/
SELECT HODEM,TEN,EMAIL,SDT,HOADON.MAHD,TRANGTHAI,SUM(SLMUA * DONGIA) AS TONGTIEN
FROM KHACHHANG JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
     JOIN HOADONCT ON HOADON.MAHD = HOADONCT.MAHD
	 JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
WHERE TRANGTHAI LIKE N'CHƯA%'
GROUP BY HODEM,TEN,EMAIL,SDT,HOADON.MAHD,TRANGTHAI
/*e. Hiển thị maHoaDon, ngàyMuahang, tổng số tiền đã mua trong từng hoá đơn. Chỉ
hiển thị những hóa đơn có tổng số tiền >=500.000 và sắp xếp theo thứ tự giảm dần 
của cột tổng tiền.*/
SELECT HOADON.MAHD,NGAYMUA,SUM(SLMUA * DONGIA) AS TONGTT
FROM HOADON JOIN HOADONCT ON HOADON.MAHD = HOADONCT.MAHD
     JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
GROUP BY HOADON.MAHD,NGAYMUA
HAVING SUM(SLMUA * DONGIA) >= 500000

/*Bài 2 (4 điểm) Viết các câu truy vấn sau:*/
/*a. Hiển thị danh sách các khách hàng chưa mua hàng lần nào kể từ tháng 1/1/2016*/
SELECT * FROM KHACHHANG
WHERE NOT EXISTS (SELECT * FROM HOADON
                 WHERE KHACHHANG.MAKH = HOADON.MAKH AND 
				   YEAR(NGAYMUA) = 2022 AND MONTH( NGAYMUA) =1)
/*b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016*/
SELECT TOP 1 SANPHAM.MASP,TENSP, COUNT(HOADONCT.MASP) AS SOLUOTMUA
FROM HOADONCT JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
GROUP BY SANPHAM.MASP,TENSP
ORDER BY SOLUOTMUA DESC
/*c. Hiển thị top 5 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016*/
SELECT TOP 2 MAKH, SUM(SLMUA * DONGIA) AS TONGTT
FROM HOADON JOIN HOADONCT ON HOADON.MAHD = HOADONCT.MAHD
      JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
WHERE YEAR(NGAYMUA) = 2022
GROUP BY MAKH
ORDER BY TONGTT DESC
/*d. Hiển thị thông tin các khách hàng sống ở ‘Đà Nẵng’ có mua sản phẩm có tên 
“Iphone 7 32GB” trong tháng 12/2016*/
SELECT KHACHHANG.*,TENSP, NGAYMUA
FROM KHACHHANG JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
     JOIN HOADONCT ON HOADON.MAHD = HOADONCT.MAHD
	 JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
WHERE DIACHI = N'ĐÀ NẴNG' AND TENSP = N'IPHONE 7' AND YEAR(NGAYMUA) = 2022
        AND MONTH(NGAYMUA) = 1
/*e. Hiển thị tên sản phẩm có lượt đặt mua nhỏ hơn lượt mua trung bình các các sản 
phẩm.*/
SELECT TENSP,SLMUA
FROM SANPHAM JOIN HOADONCT ON SANPHAM.MASP = HOADONCT.MASP
WHERE SLMUA < (SELECT AVG(SLMUA) FROM HOADONCT)