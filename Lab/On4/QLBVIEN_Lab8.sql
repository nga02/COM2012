﻿----TAO CSDL
CREATE DATABASE QLBVIEN
----BẢNG THUỐC
IF OBJECT_ID('THUOC') IS NOT NULL
  DROP TABLE THUOC
GO
CREATE TABLE THUOC
(
	MATHUOC     VARCHAR(10) NOT NULL,
    TENTH       NVARCHAR(30) NULL,
    DVT         NVARCHAR(10) NULL,
	GIA         MONEY   NULL,
	NHOMDTRI    NVARCHAR(50) NULL,
    CONSTRAINT  PK_THUOC PRIMARY KEY(MATHUOC)
)
-------BẢNG HỒ SƠ
IF OBJECT_ID('HOSO') IS NOT NULL
  DROP TABLE HOSO
GO
CREATE TABLE HOSO
(
	MAHS       VARCHAR(10) NOT NULL,
	HOTEN      NVARCHAR(50) NULL,
	NGSINH     DATETIME NULL,
	GIOITINH   NVARCHAR(10) NULL,
	CMND       NVARCHAR(15) NULL,
	NGAYLAP    DATETIME NULL,
	CONSTRAINT  PK_HOSO PRIMARY KEY(MAHS)
)
-------BANG KHAM BENH
IF OBJECT_ID('KHAMBENH') IS NOT NULL
  DROP TABLE KHAMBENH
GO
CREATE TABLE KHAMBENH
(
	MAKB VARCHAR(10) NOT NULL,
	MAHS VARCHAR(10) NOT NULL,
	NGAYKHAM DATETIME NULL,
	BACSI   NVARCHAR(50) NULL,
	KETLUAN  NVARCHAR(50) NULL,
	CONSTRAINT  PK_KHAMBENH PRIMARY KEY(MAKB),
   CONSTRAINT FK_KHAMBENH_HOSO FOREIGN KEY (MAHS)
	         REFERENCES HOSO
)
------BANG TOA THUOC
IF OBJECT_ID('TOATHUOC') IS NOT NULL
  DROP TABLE TOATHUOC
GO
CREATE TABLE TOATHUOC
(
	MAKB VARCHAR(10) NOT NULL,
	MATHUOC     VARCHAR(10) NOT NULL,
	SOLUONG    INT     NULL,
	CONSTRAINT FK_TOATHUOC_KHAMBENH FOREIGN KEY (MAKB)
                        REFERENCES KHAMBENH,
    CONSTRAINT FK_TOATHUOC_THUOC FOREIGN KEY (MATHUOC)
                        REFERENCES THUOC,
    CONSTRAINT PK_TOATHUOC PRIMARY KEY (MAKB,MATHUOC)
)

---NHAP DU LIEU 
DELETE FROM THUOC
INSERT INTO THUOC VALUES
	('K01',N'THUỐC A','A01',200000,N'TIÊU HÓA'),
    ('K02',N'THUỐC B','B02',1000000,N'MẮT'),
    ('K03',N'THUỐC C','C03',550000,N'TAI MŨI HỌNG')
--NHẬP BẢNG HỒ SƠ
DELETE FROM HOSO
INSERT INTO HOSO VALUES 
	('024',N'NGUYỄN VĂN A','1/6/1970',N'NAM',123456789,'1/10/2022'),
	('025',N'LÊ THỊ NGA','4/20/2003',N'NỮ',123459864,'2/11/2022'),
	('026',N'HÀ THU HIỀN','1/8/1995',N'NAM',245056789,'3/12/2022')
--NHẬP BẢNG KHÁM BỆNH
DELETE FROM KHAMBENH
INSERT INTO KHAMBENH VALUES 
	('A21','024',1/6/2007,N'LÊ THỊ HÀ','KHỎE'),
	('B32','025',5/6/2008,N'LÊ THỊ NGỌC','KHỎE'),
	('C43','026',4/6/2009,N'NGUYỄN KIM LIÊN','KHÔNG TỐT')
--NHẬP BẢNG TOA THUỐC
DELETE FROM TOATHUOC
INSERT INTO TOATHUOC VALUES 
	('A21','K01',10),
	('B32','K02',15),
	('C43','K03',20)

SELECT * FROM THUOC
SELECT * FROM HOSO
SELECT * FROM KHAMBENH 
SELECT * FROM TOATHUOC

----CÂU 2:
/*1) Hiển thị (Mathuoc, tenthuoc, soluong) trong những lần khám bệnh của hồ sơ có mã là ‘024’. */
SELECT THUOC.MATHUOC,TENTH,SOLUONG
FROM TOATHUOC JOIN THUOC ON THUOC.MATHUOC = TOATHUOC.MATHUOC 
			  JOIN KHAMBENH ON TOATHUOC.MAKB= KHAMBENH.MAKB
WHERE MAHS='024'
/*2) Hiển thị (Mahs, Hotenbn, Bacsi, Ketluan) được khám bệnh trong ngày 1/6/2007. */
SELECT HOSO.MAHS, HOTEN, BACSI,KETLUAN
FROM HOSO join KHAMBENH ON HOSO.MAHS = KHAMBENH.MAHS
WHERE HOSO.NGAYLAP= '1/6/2007'
/*3) Hiển thị (Mahs, Hotenbn, Bacsi, Ketluan) được khám bệnh trong ngày 1/6/2007. Sxếp d.sách theo Mahs (tăng dần).*/
SELECT HOSO.MAHS, HOTEN, BACSI,KETLUAN
FROM HOSO JOIN KHAMBENH ON HOSO.MAHS = KHAMBENH.MAHS
WHERE HOSO.NGAYLAP= '1/6/2007'
/*4)Tìm các loại thuốc thuộc nhóm điều trị “tiêu hoá” có giá từ 500 đến 1000 đồng. */
SELECT HOSO.MAHS, HOSO.HOTEN, KHAMBENH.BACSI, KHAMBENH.KETLUAN
FROM HOSO JOIN KHAMBENH ON HOSO.MAHS = KHAMBENH.MAHS
WHERE HOSO.NGAYLAP = '1/6/2007'
ORDER BY HOSO.MAHS ASC
/*5) Hiển thị (Ngkham, Bacsi, Ketluan) của bệnh nhân có tên “Nguyen Van A” , s.ngày1/7/1970. */

/*6) In chi tiết các lần khám bệnh (Ngkham, Bacsi, Ketluan) của bệnh có tên “Nguyen Van A”,  sinh ngày 1/7/1970. Sắp xếp theo Ngkham (tăng dần).*/