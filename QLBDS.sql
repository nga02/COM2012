﻿--- Tao CSDL
CREATE DATABASE QLBDS
---Tao Bang
--------BẢNG VĂN PHÒNG
IF OBJECT_ID('VANPHONG') IS NOT NULL
   DROP TABLE VANPHONG
GO
CREATE TABLE VANPHONG
(
    MAVP     NVARCHAR(10) NOT NULL,
    TENVP      NVARCHAR(10) NULL,
    SDT      NVARCHAR(15) NULL,
    EMAIL    NVARCHAR(50) NULL,
	TRUONGPHONG NVARCHAR(10) NULL,
    CONSTRAINT  PK_VANPHONG PRIMARY KEY(MAVP)
)
---------BẢNG BDS
IF OBJECT_ID('BDS') IS NOT NULL
   DROP TABLE BDS
GO
CREATE TABLE BDS
(
	MABDS     NVARCHAR(10) NOT NULL,
    TENBDS      NVARCHAR(10) NULL,
    DIACHI   NVARCHAR(50) NULL,
    MACSH    NVARCHAR(10) NULL,
    MAVP      NVARCHAR(10) NULL,
   CONSTRAINT  PK_BDS PRIMARY KEY(MABDS),
   CONSTRAINT FK_BDS_VANPHONG FOREIGN KEY (MAVP)
	         REFERENCES VANPHONG
)
---NHẬP DỮ LIỆU
----BẢNG VĂN PHÒNG
DELETE FROM VANPHONG
INSERT INTO VANPHONG VALUES
	('VP01',N'HÀ NỘI','0987654321','HNBSD@FPT.EDU.VN','TP01'),
	('VP02',N'ĐÀ NẴNG','0879654321','DNBSD@FPT.EDU.VN','TP02'),
	('VP03',N'NHA TRANG','0912345678','NTBSD@FPT.EDU.VN','TP03')
----BẢNG BDS
DELETE FROM BDS
INSERT INTO BDS VALUES
	('DT01',N'CHUNG CƯ',N'SỐ 1 TRỊNH VĂN BÔ NAM TỪ LIÊM HÀ NỘI','001','VP01'),
	('DT02',N'NHÀ VƯỜN',N'15 LIÊN CHIỀU ĐÀ NẴNG','002','VP02'),
	('DT03',N'BIỆT THỰ',N'113 TRẦN HƯNG ĐẠO QUẬN 1 TP HCM','003','VP03')
-----TRUY VẤN
SELECT * FROM VANPHONG
SELECT * FROM BDS
/*1. Hiển thị thông tin Văn phòng bao gồm: MAVP, TENVP.*/
SELECT  MAVP, TENVP
FROM VANPHONG
/*2. Hiển thị thông tin BDS gồm: MABDS, MAVP, Tenbds, diachi. Trong đó: Chỉ hiển thị những địa chỉ ở Hà Nội.*/
SELECT MABDS, MAVP,TENBDS,DIACHI
FROM BDS
WHERE DIACHI LIKE N'%HÀ NỘI'
/*3. Hiển thị tất cả BDS có mã văn phòng kết thúc là ‘01’.*/
SELECT * FROM BDS
WHERE MAVP LIKE'%01'
/*4. Hiển thị tất cả thông tin trong bảng VANPHONG của những văn phòng có tenvp bắt đầu là chữ ‘N’.*/
SELECT *FROM VANPHONG
WHERE TENVP LIKE N'N%'
/*5. Hiển thị MAVP và số văn phòng. Yêu cầu chỉ hiển thị mavp nào có số văn phòng >=1. Sắp xếp maVP  theo thứ tự tăng dần. */

SELECT MAVP,COUNT(MAVP) AS SVP
FROM BDS
GROUP BY MAVP
HAVING COUNT(MAVP)>=1
ORDER BY MAVP

/*6. Đưa ra văn phòng bán được nhiều BDS nhất gồm: mavp, soluong.*/
SELECT TOP 1 MAVP,COUNT(MAVP) AS SL
FROM BDS
GROUP BY MAVP
ORDER BY SL DESC
