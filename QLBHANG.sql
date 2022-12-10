---- Tao CSDL
CREATE DATABASE QLBH
---Tao Bang
------BANG KHÁCH HÀNG
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
CREATE TABLE HOADON
(
     MAHD       NVARCHAR(10)     NOT NULL,
	 NGAYMUA    DATETIME         NULL,
	 MAKH       NVARCHAR(10)     NOT NULL,
	 TRANGTHAI  NVARCHAR(50)     NULL,
	 CONSTRAINT PK_HOADON PRIMARY KEY (MAHD),
	 CONSTRAINT FK_HOADON_KHACHHANG FOREIGN KEY (MAKH) REFERENCES KHACHHANG
)
---BẢNG HÓA ĐƠN CT
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
	('KH01', N'LÊ THỊ',N'NGA',N'THANH HÓA','NGALTPH26840@FPT.EDU.VN','0763058638'),
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
SELECT HODEM+''+TEN as Hovaten,EMAIL,SDT,HOADON.MAHD,TRANGTHAI,SUM(SLMUA * DONGIA) AS TONGTIEN
FROM KHACHHANG JOIN HOADON ON KHACHHANG.MAKH = HOADON.MAKH
     JOIN HOADONCT ON HOADON.MAHD = HOADONCT.MAHD
	 JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
WHERE TRANGTHAI LIKE N'CHƯA%'
GROUP BY HODEM+''+TEN,EMAIL,SDT,HOADON.MAHD,TRANGTHAI

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
-- SỮA LẠI - LỖI
SELECT * FROM KHACHHANG
WHERE NOT EXISTS (SELECT * FROM HOADON
                 WHERE KHACHHANG.MAKH = HOADON.MAKH AND 
				   YEAR(NGAYMUA) = 2022 AND MONTH( NGAYMUA) =1)

/* select: đưa ra, hiển thị cái nào
   where: điều kiện
   from: đến bảng nào
   */

/*b. Hiển thị mã sản phẩm, tên sản phẩm có lượt mua nhiều nhất trong tháng 12/2016*/
SELECT TOP 1 SANPHAM.MASP,TENSP, COUNT(HOADONCT.MASP) AS SOLUOTMUA
FROM HOADONCT JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
GROUP BY SANPHAM.MASP,TENSP
ORDER BY SOLUOTMUA DESC

/*c. Hiển thị top 2 khách hàng có tổng số tiền mua hàng nhiều nhất trong năm 2016*/
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


-- BÀI LÀM THÊM:
 -- 1:Hiển thị tất cả thông tin có trong 2 bảng Hoá đơn và Hoá đơn chi tiết gồm các cột
--sau: maHoaDon, maKhachHang, trangThai, maSanPham, soLuong, ngayMua với
--điều kiện maKhachHang = ‘KH01’ mua sản phẩm có số lượng > 1
  SELECT HOADON.MAHD, MAKH,TRANGTHAI,MASP,SLMUA,NGAYMUA
FROM HOADON JOIN HOADONCT ON HOADONCT.MAHD = HOADON.MAHD
where MAKH = 'KH01' AND SLMUA >1

/*2. Hiển thị thông tin từ 3 bảng Hoá đơn, Hoá đơn chi tiết và Sản phẩm gồm các cột
sau: maHoaDon, ngayMua, tenSP, donGia, soLuong mua trong hoá đơn, thành
tiền. (Với thành tiền= donGia* soLuong) với điều kiện Ngày mua sau năm 2015
và mua sản phẩm là “VERTUR”.*/
SELECT HOADON.MAHD, NGAYMUA, TENSP, DONGIA, SLMUA, DONGIA*SLMUA AS THANHTIEN
FROM HOADON JOIN HOADONCT ON HOADONCT.MAHD = HOADON.MAHD
			JOIN SANPHAM ON SANPHAM.MASP = HOADONCT.MASP
WHERE  TENSP=N'VERTUR' AND YEAR(NGAYMUA) > 2015

-- Chưa mua_not in


/*  alter table phong_ban add constraint pk2 primary key (ma_pb) 
	alter table nhan_vien add constraint fk1 foreign key (phg) references phong_ban (ma_pb)
	*/
			
