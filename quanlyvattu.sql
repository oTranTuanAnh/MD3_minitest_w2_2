create database quanlyvattu;
use quanlyvattu;
create table vat_tu (
id int not null primary key,
ma_vat_tu varchar(15),
ten_vat_tu varchar(50),
don_vi_tinh varchar(10),
gia_tien float);
create table ton_kho (
id int not null primary key,
vat_tu_id int,
so_luong_dau float,
so_luong_nhap float,
so_luong_xuat float,
foreign key (vat_tu_id) references vat_tu(id));
create table nha_cung_cap (
id int not null primary key,
ma_nha_cung_cap int,
ten varchar(50),
dia_chi varchar(255),
so_dien_thoai varchar(10));
create table don_dat_hang (
id int not null primary key,
ma_don varchar(10),
ngay_dat_hang date,
nha_cung_cap_id int,
foreign key (nha_cung_cap_id) references nha_cung_cap(id));
create table phieu_nhap (
id int not null primary key,
ma_phieu_nhap varchar(10),
ngay_nhap date,
don_hang_id int,
foreign key (don_hang_id) references don_dat_hang(id));
create table phieu_xuat (
id int not null primary key,
ma_phieu_xuat varchar(10),
ngay_xuat date,
ten_khach_hang varchar(255));
create table ct_don_hang (
id int not null primary key,
don_hang_id int,
vat_tu_id int,
so_luong_dat float,
foreign key (don_hang_id) references don_dat_hang(id),
foreign key (vat_tu_id) references vat_tu(id));
create table ct_phieu_nhap (
id int not null primary key,
phieu_nhap_id int,
vat_tu_id int,
so_luong_nhap float,
don_gia_nhap float,
ghi_chu varchar(255),
foreign key (phieu_nhap_id) references phieu_nhap(id),
foreign key (vat_tu_id) references vat_tu(id));
create table ct_phieu_xuat (
id int not null primary key,
phieu_xuat_id int,
vat_tu_id int,
so_luong_xuat float,
don_gia_xuat float,
ghi_chu varchar(255),
foreign key (phieu_xuat_id) references phieu_xuat(id),
foreign key (vat_tu_id) references vat_tu(id));

insert into vat_tu values (1, 'B01', 'bim bim', 'goi', 5000),
(2, 'SKX', 'sua chua', 'hop', 7500),
(3, 'KK23', 'keo deo', 'goi', 25000),
(4, 'CL12', 'cocacola', 'chai', 10000),
(5, 'CF111', 'cafe sua', 'hop', 75000);
insert into ton_kho values (1, 2, 100, 25, 70),(2, 3, 70, 50, 50),(3, 4, 0, 100, 55),
(4, 1, 100, 0, 80),(5, 5, 100, 100, 0);
insert into nha_cung_cap values (1, 'AB112', 'Cong ty ABC', 'HN', '0987657485'),
(2, '56HFG', 'Cong ty GI DO', 'HP', '0956452341'),
(3, 'NJHGF', 'Cong ty cung cap sap pham', 'SG', '0976859898');
insert into don_dat_hang values (1, 'DX0101', '2024-6-7',2),
(2, 'DD323', '2024-2-15',1),(3, 'DDT45', '2024-3-8',3);
insert into phieu_nhap values (1, 'PN1', '2024-1-15',2), 
(2, 'PN2', '2024-1-16',3),(3, 'PN3', '2024-1-20',1);
insert into phieu_xuat values (1, 'PX1', '2024-1-16','Nguyen Thi Thao'), 
(2, 'PX2', '2024-1-20', 'Le Van Manh'),(3, 'PX3', '2024-1-20','Pham Thanh Trung');
insert into ct_don_hang values (1, 2, 5, 25),(2, 1, 3, 10),
(3, 2, 4, 100),(4, 3, 2, 30),
(5, 3, 1, 15),(6, 1, 2, 38);
insert into ct_phieu_nhap values (1,1,3,50,17000,'ko'),
(2,2,1,100,7000,'xong'),
(3,1,2,50,7000,'ko'),
(4,3,4,45,8000,'ko'),
(5,1,4,20,8500,'xong'),
(6,2,3,30,22000,'ko');
insert into ct_phieu_xuat values (1,3,1,30,6000, 'con'),
(2,2,2,45,7500, 'ok'),
(3,1,3,70,27000, 'oke'),
(4,1,4,55,11000, 'tam tam'),
(5,2,2,15,6000, 'chan k muon ban'),
(6,2,2,30,6700, 'ban re');

-- Câu 1. Tạo view có tên vw_CTPNHAP bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP as
select  pn.ma_phieu_nhap, vt.ma_vat_tu, ctpn.so_luong_nhap, ctpn.don_gia_nhap, (ctpn.so_luong_nhap*ctpn.don_gia_nhap) as thanh_tien_nhap
from phieu_nhap pn join ct_phieu_nhap ctpn on pn.id = ctpn.phieu_nhap_id
join vat_tu vt on ctpn.vat_tu_id = vt.id;
select * from vw_CTPNHAP;

-- Câu 2. Tạo view có tên vw_CTPNHAP_VT bao gồm các thông tin sau: số phiếu nhập hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập
create view vw_CTPNHAP_VT as
select  pn.ma_phieu_nhap, vt.ma_vat_tu, vt.ten_vat_tu, ctpn.so_luong_nhap, ctpn.don_gia_nhap, (ctpn.so_luong_nhap*ctpn.don_gia_nhap) as thanh_tien_nhap
from phieu_nhap pn join ct_phieu_nhap ctpn on pn.id = ctpn.phieu_nhap_id
join vat_tu vt on ctpn.vat_tu_id = vt.id;
select * from vw_CTPNHAP_VT;

-- Câu 3. Tạo view có tên vw_CTPNHAP_VT_PN bao gồm các thông tin sau: số phiếu nhập hàng, ngày nhập hàng, số đơn đặt hàng, mã vật tư, tên vật tư, số lượng nhập, đơn giá nhập, thành tiền nhập.
create view vw_CTPNHAP_VT_PN  as
select  pn.ma_phieu_nhap, pn.ngay_nhap, ddh.ma_don, vt.ma_vat_tu, vt.ten_vat_tu, ctpn.so_luong_nhap, ctpn.don_gia_nhap, (ctpn.so_luong_nhap*ctpn.don_gia_nhap) as thanh_tien_nhap
from ct_phieu_nhap ctpn join phieu_nhap pn on ctpn.phieu_nhap_id = pn.id
join don_dat_hang ddh on pn.don_hang_id = ddh.id
join ct_don_hang ctdh on  ddh.id = ctdh.don_hang_id
join vat_tu vt on ctdh.vat_tu_id = vt.id;
select * from vw_CTPNHAP_VT_PN ;
-- phieu nhap, ct don dat hang, vat tu, don dat hang
















