﻿CREATE DATABASE BUOI_1_D1
IF OBJECT_ID('VANPHONG') IS NOT NULL
DROP TABLE VANPHONG
GO
CREATE TABLE VANPHONG
(
	MA_VP VARCHAR(10) NOT  NULL,
	TEN_VP NVARCHAR(50) NULL,
	CONSTRAINT PK_VANPHONG PRIMARY KEY(MA_VP)
)
IF OBJECT_ID('NHANVIEN') IS NOT NULL
DROP TABLE NHANVIEN
GO
CREATE TABLE NHANVIEN
(
	MA_NV    VARCHAR(10) NOT NULL,
	HOTEN    NVARCHAR(50) NULL,
	NGAYSINH DATETIME NULL,
	GIOITINH NVARCHAR(10) NULL,
	MA_VP    VARCHAR(10) NOT NULL,
	EMAIL    NVARCHAR(50) NULL,
	SDT      NVARCHAR(10) NULL,
	CONSTRAINT PK_NHANVIEN PRIMARY KEY(MA_NV),
	CONSTRAINT FK_NHANVIEN_VANPHONG FOREIGN KEY(MA_VP) 
			REFERENCES VANPHONG
)
IF OBJECT_ID('THANNHAN') IS NOT NULL
DROP TABLE THANNHAN
GO
CREATE TABLE THANNHAN
(
	MA_TN VARCHAR(10) NOT NULL,
	HOTEN_NV NVARCHAR(50) NULL,
	NGAY_SINH DATETIME NULL,
	MLH NVARCHAR(50) NULL,
	MA_NV VARCHAR(10) NOT NULL,
	CONSTRAINT PK_THANNHAN PRIMARY KEY (MA_TN),
	CONSTRAINT FK_THANNHAN_NHANVIEN FOREIGN KEY(MA_NV) 
			REFERENCES NHANVIEN
)
----NHẬP DỮ LIỆU
DELETE FROM VANPHONG
INSERT INTO VANPHONG VALUES
	('HC',N'HÀNH CHÍNH'),
	('CTSV',N'CÔNG TÁC SINH VIÊN')
DELETE FROM NHANVIEN
INSERT INTO NHANVIEN VALUES
	('NV1',N'NGUYỄN ANH TUẤN','12/11/1989',N'NAM','HC','TUANNA5@FPT.EDU.VN','0988554303'),
	('NV2',N'TRẦN THANH TÙNG','2/1/1988',N'NAM','CTSV','TUNGTT2@FPT.EDU.VN','0987792457'),
	('NV3',N'LÊ THỊ NGA','4/20/2003',N'NỮ','HC','NGALT40@FPT.EDU.VN','098855678')
DELETE FROM THANNHAN
INSERT INTO THANNHAN VALUES
	('TN01',N'NGUYỄN NGỌC ANH','7/12/1962',N'NGƯỜI THÂN','NV2'),
	('TN02',N'TRẦN TUẤN TÚ','6/06/1970',N'NGƯỜI QUEN','NV2')
SELECT * FROM VANPHONG
SELECT * FROM NHANVIEN
SELECT * FROM THANNHAN

/*Câu 2: Hiển thị MaNV, HotenNV, MaVP và tháng sinh là tháng nhỏ hơn 10. */
SELECT MA_NV,HOTEN,MA_VP 
FROM NHANVIEN 
WHERE MONTH(NGAYSINH) < 10
/*-Câu 3: Hiển thị MaNV, HotenNV, MaVP và Tuổi nhân viên.
Chỉ hiển thị những nhân viên có tuổi lớn hơn 20 và nhỏ hơn 40 */
SELECT MA_NV,HOTEN,MA_VP, DATEDIFF(YEAR,NGAYSINH,GETDATE()) AS TUOI
FROM NHANVIEN 
WHERE DATEDIFF(YEAR,NGAYSINH,GETDATE()) >20 AND DATEDIFF(YEAR,NGAYSINH,GETDATE()) < 40
/*Câu 4: Hiển thị thông tin: MaNV, HotenNV, TENVP, NGAYSINH, GIOITINH, EMAIL, 
SODT và chỉ hiển thị những nhân viên mà họ có 4 chữ cái */
SELECT MA_NV,HOTEN,TEN_VP,NGAYSINH,EMAIL,SDT 
FROM NHANVIEN JOIN VANPHONG ON VANPHONG.MA_VP=NHANVIEN.MA_VP
WHERE HOTEN LIKE N'____ %'
/*Câu 5: Hiển thị tất cả thông tin của những nhân viên có thân nhân.
Sắp xếp tăng dần theo tuổi, ngày sinh ở định dạng dd/mm/yyyy */
SELECT CONVERT(CHAR,NGAYSINH,101),MA_NV,HOTEN,GIOITINH,MA_VP,EMAIL,SDT FROM NHANVIEN 
WHERE MA_NV IN (SELECT MA_NV FROM THANNHAN WHERE THANNHAN.MA_NV=NHANVIEN.MA_NV)
ORDER BY DATEDIFF(YEAR,NGAYSINH,GETDATE()) ASC
/*Câu 6: Thêm một bản ghi mới vào bảng NHANVIEN, với giới tính là Nữ và MaVP là QL,
(Không hạn chế số lượng bảng thao tác) dữ liệu phù hợp nhưng không được nhập giá trị null */
INSERT INTO VANPHONG VALUES ('QL',N'QUẢN LÝ')
INSERT INTO NHANVIEN VALUES ('NV4',N'LÊ THỊ MAI','4/25/2003',N'NỮ','QL','MAILT20@FPT.EDU.VN','0988556584')
/*Câu 7: Cập nhật lại SODT của MaNV NV2 là 0987792444 */
UPDATE NHANVIEN SET SDT = '0987792444'
WHERE MA_NV = 'NV2'
/*Câu 8: Xóa thông tin của NHANTHAN có mối liên hệ là “người quen” */
DELETE FROM THANNHAN
WHERE MLH = N'NGƯỜI QUEN'

