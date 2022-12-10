create database benh_vien

use benh_vien

if OBJECT_ID('thuoc') is not null
drop table thuoc

create table thuoc(
   ma_thuoc varchar(10) not null,
   ten_thuoc nvarchar(20) null,
   don_vi_tinh nvarchar(20) null,
   gia money null,
   nhom_dieu_tri nvarchar(50) null,
   constraint PK_thuoc primary key(ma_thuoc)

)

if OBJECT_ID('ho_so') is not null
drop table ho_so

create table ho_so(
   ma_ho_so varchar(10) not null,
   ho_ten nvarchar(50) null,
   ngay_sinh date null,
   gioi_tinh nvarchar(10) null,
   cmnd varchar(20) null,
   ngay_lap date null,
   constraint PK_ho_so primary key(ma_ho_so)

)


if OBJECT_ID('kham_benh') is not null
drop table kham_benh

create table kham_benh(
  ma_kham_benh varchar(10) not null,
  ma_ho_so varchar(10) null,
  ngay_kham date null,
  bac_si nvarchar(50) null,
  ket_luan nvarchar(50) null
  constraint PK_kham_benh primary key(ma_kham_benh) ,
  constraint FK_kham_benh foreign key(ma_ho_so) references ho_so
)

if OBJECT_ID('toa_thuoc') is not null
drop table toa_thuoc

create table toa_thuoc(
  ma_kham_benh varchar(10) not null,
  ma_thuoc varchar(10) not null,
  so_luong int null,
  constraint PK_toa_thuoc primary key(ma_kham_benh,ma_thuoc),
  constraint FK_kham_benh_toa_thuoc foreign key(ma_kham_benh) references kham_benh,
  constraint FK_thuoc_toa_thuoc foreign key(ma_thuoc) references thuoc
)

insert into thuoc 
values ('T001','astra01',N'Lọ',20000,'covid'),
       ('T002','penixilin01',N'Chai',30000,'covid'),
	   ('T003','astra01',N'Lọ',40000,'covid')

insert into ho_so
values ('HS01',N'Nguyễn Văn A','11/25/2001',N'Nam','034201000','2/22/2022'),
        ('HS02',N'Nguyễn Văn B','11/23/1999',N'Nữ','034201000','2/22/2022'),
		('HS03',N'Nguyễn Văn C','11/25/1995',N'Nam','034201000','2/22/2022')

insert into kham_benh
values ('KB01','HS01','2/15/2019',N'Hoàng đình Công',N'Không qua khỏi'),
        ('KB02','HS02','2/15/2018',N'Hoàng đình Công',N'Không qua khỏi'),
		('KB03','HS01','2/15/2019',N'Nguyễn Minh Quang',N'Không qua khỏi')

insert into toa_thuoc
values ('KB01','T001',20),
       ('KB02','T001',30),
	   ('KB01','T002',20)

-- Phần II
-- câu 1:
 select thuoc.ma_thuoc,thuoc.ten_thuoc,toa_thuoc.so_luong from toa_thuoc
 join thuoc on thuoc.ma_thuoc = toa_thuoc.ma_thuoc
 join kham_benh on kham_benh.ma_kham_benh  = toa_thuoc.ma_kham_benh
 where kham_benh.ma_ho_so = '024'
 --cau 2:
 select ho_so.ma_ho_so,ho_so.ho_ten,kham_benh.bac_si,kham_benh.ket_luan from kham_benh
 join ho_so on kham_benh.ma_ho_so = ho_so.ma_ho_so
 where kham_benh.ngay_kham = '6/1/2017'

 --cau 3:
  select ho_so.ma_ho_so,ho_so.ho_ten,kham_benh.bac_si,kham_benh.ket_luan from kham_benh
 join ho_so on kham_benh.ma_ho_so = ho_so.ma_ho_so
 where kham_benh.ngay_kham = '6/1/2017'
 order by ho_so.ma_ho_so asc

 -- cau 4:
 select * from thuoc
 where thuoc.nhom_dieu_tri = N'tiêu hóa'  and (gia >=500 and gia <=1000)

 -- cau 5
 select kham_benh.ngay_kham ,kham_benh.bac_si ,kham_benh.ket_luan from kham_benh
 join ho_so on ho_so.ma_ho_so = kham_benh.ma_ho_so
 where ho_so.ho_ten = N'Nguyễn Văn A' and ho_so.ngay_sinh = '7/1/1970'


 --cau 6:
 select kham_benh.ngay_kham ,kham_benh.bac_si ,kham_benh.ket_luan from kham_benh
 join ho_so on ho_so.ma_ho_so = kham_benh.ma_ho_so
 where ho_so.ho_ten = N'Nguyễn Văn A' and ho_so.ngay_sinh = '7/1/1970'
 order by kham_benh.ngay_kham asc





