-- 1.1
Select Monhoc.MaMH as 'Mã môn học', TenMH as 'Tên môn học',Diem as 'Điểm'
from Sinhvien, Monhoc, Ketqua
where (Sinhvien.TenSV like N'% Thức') and (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH)


-- 1.2
Select Monhoc.MaMH as 'Mã môn học', TenMH as 'Tên môn học', Diem as 'Điểm'
from Sinhvien, Monhoc, Ketqua
where (Sinhvien.TenSV like N'% Dung') and (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH) and (Diem < 5)


-- 1.3
Select distinct Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Monhoc, Ketqua
where TenMH in (N'CSDL', N'Tin đại cương', N'Mạng máy tính') and (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH)

-- 1.4

Select Monhoc.MaMH as 'Mã môn học', TenMH as 'Tên môn học', Diem as 'Điểm'
from Monhoc, Ketqua
where (MaSV = 1) and (Monhoc.MaMH = Ketqua.MaMH) and (Diem is null)


-- 1.5

Select max(Diem) as 'Điểm cao nhất'
from Ketqua
where Ketqua.MaMH = 1


-- 1.6
Select distinct Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Monhoc, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH) and Ketqua.MaMH = 2
		and (Diem > (select min(Diem) from Ketqua where Ketqua.MaMH = 2))

-- 1.7
Select distinct Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Monhoc, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH) and Ketqua.MaMH = 1
		and (Diem > (select Diem from Ketqua where Ketqua.MaSV = 3 and Ketqua.MaMH = 1))


-- 1.8
select count(*) as N'Số SV thi lại'
from Monhoc, Ketqua
where (Monhoc.MaMH = Ketqua.MaMH) and (Monhoc.TenMH = N'CSDL') and (Diem < 6)

-- 1.9
select Monhoc.TenMH, count(Diem) as N'Số SV thi lại'
from Monhoc, Ketqua
where (Monhoc.MaMH = Ketqua.MaMH) and Diem < 5
group by Monhoc.TenMH
having count(Diem) > 2

-- 1.10
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and Diem = (
									select MAX(Diem)
									from Monhoc, Ketqua
									where (Monhoc.MaMH = Ketqua.MaMH) and Monhoc.TenMH = N'CSDL'
									)

-- 1.11
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên', AVG(Diem) as N'Diem TB'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV)
group by Sinhvien.MaSV, Sinhvien.TenSV

-- 1.12
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên', AVG(Diem) as N'Diem TB'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and Lop = N'L04'
group by Sinhvien.MaSV, Sinhvien.TenSV

-- 1.13
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên', AVG(Diem) as N'Diem TB'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and Lop = N'L04' and Diem < 4
group by Sinhvien.MaSV, Sinhvien.TenSV
having count(Diem) > 2

-- 1.14
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV)
group by Sinhvien.MaSV, Sinhvien.TenSV
having count(Diem) = (select count(MaMH) from Monhoc)

-- 1.15
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV)
group by Sinhvien.MaSV, Sinhvien.TenSV
having avg(Diem) >= 6

-- 1.16
Select Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên'
from Sinhvien, Ketqua, Monhoc
where (Sinhvien.MaSV = Ketqua.MaSV) and (Monhoc.MaMH = Ketqua.MaMH) and Sinhvien.MaSV != 3 and Diem < 5 and Monhoc.TenMH in
	(
	select TenMH from Monhoc, Ketqua where (Monhoc.MaMH = Ketqua.MaMH) and (Ketqua.MaSV = 3)
	)

-- 1.17
Select distinct Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên', count(MaMH) as N'Số lượng'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV)
group by Sinhvien.MaSV, TenSV
having count(MaMH) >= (select count(distinct MaMH) / 2 from Ketqua where Diem >= 5)

-- 1.18
Select distinct MaSV as 'Mã Sinh viên', count(MaMH) as N'Số lượng'
from Ketqua
where Diem > 7
group by MaSV
having count(MaMH) >= (select count(distinct MaMH) / 2 from Ketqua where Diem >= 7)


-- 1.19
Select distinct Sinhvien.MaSV as 'Mã Sinh viên',TenSV as 'Họ và tên', avg(Diem) as N'Điểm TB'
from Sinhvien, Ketqua
where (Sinhvien.MaSV = Ketqua.MaSV) and Lop like N'L0%'
group by Sinhvien.MaSV, Sinhvien.TenSV
having avg()