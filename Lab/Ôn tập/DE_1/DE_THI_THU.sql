CREATE DATABASE QLSV
IF OBJECT_ID('SINHVIEN') IS NOT NULL
DROP TABLE SINHVIEN
GO
CREATE TABLE SINHVIEN
(
	MA_SV VARCHAR(10) NOT NULL,
	HO_TEN NVARCHAR(50) NULL,
	NGAY_SINH DATETIME NULL,
	GIOI_TINH NVARCHAR(10) NULL,
	CONSTRAINT PK_SINHVIEN PRIMARY KEY (MA_SV)
)
IF OBJECT_ID('MONHOC') IS NOT NULL
DROP TABLE MONHOC
GO
CREATE TABLE MONHOC
( 
	MA_MH VARCHAR(10) NOT NULL,
	TEN_MH NVARCHAR(50) NULL,
	SO_TC INT NULL,
	CONSTRAINT PK_MONHOC PRIMARY KEY(MA_MH)
)
IF OBJECT_ID('DIEM') IS NOT NULL
DROP TABLE DIEM
GO
CREATE TABLE DIEM
(
	MA_SV VARCHAR(10) NOT NULL,
	MA_MH VARCHAR(10) NOT NULL,
	DIEM_THI INT NULL,
	CONSTRAINT PK_DIEM PRIMARY KEY(MA_SV,MA_MH),
	CONSTRAINT FK_SINHVIEN_DIEM FOREIGN KEY(MA_SV) REFERENCES SINHVIEN,
	CONSTRAINT FK_MONHOC_DIEM FOREIGN KEY(MA_MH) REFERENCES MONHOC
)
-------NHẬP DỮ LIỆU
DELETE FROM SINHVIEN
INSERT INTO SINHVIEN 
VALUES   ('DL001',N'LÊ THỊ NGA','12/11/1989',N'NAM'),
		 ('LT001',N'NGUYỄN THANH HOA','02/01/1988',N'NAM')
DELETE FROM MONHOC
INSERT INTO MONHOC 
VALUES	('SQL',N'CƠ SỞ DỮ LIỆU SQL SERVER',3),
		('XML',N'NGÔN NGỮ ĐÁNH DẤU MỞ',4)
DELETE FROM DIEM
INSERT INTO DIEM 
VALUES  ('DL001','SQL',8),
		('DL001','XML',7),
		('LT001','SQL',4)

SELECT * FROM SINHVIEN
SELECT * FROM MONHOC
SELECT * FROM DIEM

/*Câu 2: Hiển thị thông tin sinh viên gồm: 
Masv, hoten, ngaysinh, gioitinh, tuổi*/
SELECT MA_SV,HO_TEN,NGAY_SINH,GIOI_TINH, DATEDIFF(YEAR,NGAY_SINH,GETDATE()) AS TUOI
FROM SINHVIEN 
/*Câu 3: Hiển thị thông tin: Masv, hoten , Mamh và có điểm thi >=5. (1 điểm)*/
SELECT SINHVIEN.MA_SV,HO_TEN,MONHOC.MA_MH ,DIEM_THI
FROM SINHVIEN JOIN DIEM ON DIEM.MA_SV=SINHVIEN.MA_SV
			  JOIN MONHOC ON MONHOC.MA_MH=DIEM.MA_MH
 WHERE DIEM_THI >=5

/*Câu 4: Hiển thị thông tin Masv, hoten và ĐTB của các sinh viên.
Trong đó ĐTB = (điểm thi  * Số tín chỉ)/tổng số tín chỉ. (1 điểm)*/
SELECT SINHVIEN.MA_SV,HO_TEN,SUM(DIEM_THI * SO_TC)/SUM(SO_TC) AS DTB
FROM SINHVIEN JOIN DIEM ON DIEM.MA_SV=SINHVIEN.MA_SV
			JOIN MONHOC ON MONHOC.MA_MH=DIEM.MA_MH
GROUP BY SINHVIEN.MA_SV,HO_TEN
/*Câu 5: Hiển thị thông tin Masv, hoten, Tuổi của sinh viên. 
Chỉ hiển thị  những sinh viên có tuổi lớn hơn 33 tuổi. (1 điểm)*/
SELECT MA_SV,HO_TEN,DATEDIFF(YEAR,NGAY_SINH,GETDATE()) AS TUOI
FROM SINHVIEN  
WHERE DATEDIFF(YEAR,NGAY_SINH,GETDATE()) > 33
/*Câu 6: Chèn thêm một bản ghi mới vào bảng DIEM; 
dữ liệu phù hợp nhưng không được nhập giá trị null. (1 điểm)*/
INSERT INTO DIEM VALUES ('LT001','XML',6)
/*Câu 7: Cập nhật lại số tín chỉ môn SQL là 4 (1 điểm)*/
UPDATE MONHOC SET SO_TC = 4
WHERE MA_MH ='SQL'
/*Câu 8: Xóa những sinh viên có điểm thi <5 trong bảng DIEM. (1 điểm)*/
DELETE FROM DIEM
WHERE DIEM_THI < 5
