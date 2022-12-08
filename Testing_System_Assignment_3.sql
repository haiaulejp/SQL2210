USE testing_system;
-- câu 2 lấy ra tất cả các phòng ban --
select * from department;
-- câu 3 lấy ra id của phòng ban "Sale"--
select * from department
where departmentname like '%sale';
-- câu 4 lấy ra thông tin account có full name dài nhất--
select * from `account`
where length(fullname) = (select max(length(fullname)) from `account`);

-- câu 5 Lấy ra thông tin account có full name dài nhất và thuộc phòng ban có id = 3 --
select * from `account`
where length(fullname) = (select max(length(fullname)) from `account`) and departmentid = 3;

-- câu 6 Lấy ra tên group đã tham gia trước ngày 20/12/2019--
select * from `group`
where createdDate < '2019-12-20';
-- câu 7 Lấy ra ID của question có >= 4 câu trả lời--
select questionid
from answer
group by questionid
having count(questionid) >= 4;
 -- câu 8 Lấy ra các mã đề thi có thời gian thi >= 60 phút và được tạo trước ngày 20/12/2019--
 select `code`
 from exam 
 where duration >= 60 and createdDate < '2019-12-20';
 
 -- câu 9 Lấy ra 5 group được tạo gần đây nhất--
 select groupname,createddate
from `group`
order by createdDate desc
limit 5;
-- câu 10 Đếm số nhân viên thuộc department có id = 2--
select departmentid,count(accountid)
from `account`
group by departmentid
having departmentid = 2;
-- câu số 11 Lấy ra nhân viên có tên bắt đầu bằng chữ "D" và kết thúc bằng chữ "o"
select fullname
from `account`
where fullname like '%D%' and fullname like '%O';
-- câu số 12 Xóa tất cả các exam được tạo trước ngày 20/12/2019--
set sql_safe_updates=0;
delete from exam
 where createddate < '2019-12-19';
 -- câu 13 Xóa tất cả các question có nội dung bắt đầu bằng từ "câu hỏi" --
 delete from question
where content like 'câu hỏi%';
-- câu 14 Update thông tin của account có id = 5 thành tên "Nguyễn Bá Lộc" và email thành loc.nguyenba@vti.com.vn
 update `account`
 set fullname = 'Nguyễn Bá Lộc' , email = 'loc.nguyenba@vti.com.vn'
 where accountid = 5;
 -- câu 15 update account có id = 5 sẽ thuộc group có id = 4--
 update `groupaccount`
 set groupid = 4
where accountid = 5;





