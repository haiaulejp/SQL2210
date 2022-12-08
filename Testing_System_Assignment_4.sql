use testing_system;
-- câu 1 Viết lệnh để lấy ra danh sách nhân viên và thông tin phòng ban của họ--
select *
from `account` a
join department d on d.departmentid = a.departmentid;
-- câu 2 Viết lệnh để lấy ra thông tin các account được tạo sau ngày 20/12/2010 
select *
from `account`
where createdDate > '2010-12-20';
-- câu 3 Viết lệnh để lấy ra tất cả các developer-- 
select * 
from `account` a
join position p on p.positionid = a.positionid
where positionname like 'dev%';
-- câu 4 Viết lệnh để lấy ra danh sách các phòng ban có >3 nhân viên-- 
select d.departmentid,d.departmentname,count(a.departmentid) as totalMember
from `account` a
join department d on d.departmentid = a.departmentid
group by a.departmentid
having totalMember >3;
-- câu 5 Viết lệnh để lấy ra danh sách câu hỏi được sử dụng trong đề thi nhiều nhất-- 
select q.*, count(q.QuestionID) as maxquestion
from question q
join examquestion eq on q.QuestionID = eq.QuestionID
group by q.QuestionID
having maxquestion = (select Max(sl) 
						from
						(select  (count(q.QuestionID)) as sl
						from question q
						join examquestion eq on q.QuestionID = eq.QuestionID
						group by q.QuestionID)  as t);

-- câu 6 Thông kê mỗi category Question được sử dụng trong bao nhiêu Question-- 
select q.categoryid,count(q.categoryid)
from question q
join categoryquestion cq on cq.categoryid = q.categoryid
group by q.CategoryID;
-- câu 7 Thông kê mỗi Question được sử dụng trong bao nhiêu Exam --
select q.questionid,q.content, count(eq.questionid)
from examquestion eq
join question q on q.questionid = eq.questionid
group by q.questionid;
-- câu 8 Lấy ra Question có nhiều câu trả lời nhất--
select q.questionid,q.content, count(a.questionid)
from answer a
join question q on q.questionid = a.questionid
group by a.questionid;
-- câu 9 Thống kê số lượng account trong mỗi group--
select g.groupid,g.groupname, count(gc.accountid)
from groupaccount gc
join `group` g on g.groupid = gc.groupid
group by gc.groupid;
-- câu 10 Tìm chức vụ có ít người nhất--
select p.positionid,p.positionname, count(a.positionid) as totalmember
from `account` a
join position p on p.positionid = a.positionid
group by a.positionid;

select min(total) from (select p.positionid, count(a.positionid) as total
from `account` a
join position p on p.positionid = a.positionid
group by a.positionid) as temp_table;

select p.positionid,p.positionname, count(a.positionid) as totalmember
from `account` a
join position p on p.positionid = a.positionid
group by a.positionid
having totalmember = (select min(total) from (select p.positionid, count(a.positionid) as total
from `account` a
join position p on p.positionid = a.positionid
group by a.positionid) as temp_table);
-- câu 11 Thống kê mỗi phòng ban có bao nhiêu dev, test, scrum master, PM-- 
select p.positionname,p.positionid, count(a.positionid)
from `account` a
join position p on p.positionid = a.positionid
group by a.positionid;
-- câu 12 Lấy thông tin chi tiết của câu hỏi bao gồm: thông tin cơ bản của question, loại câu hỏi, ai là người tạo ra câu hỏi, câu trả lời là gì, ...
select q.content,tq.typename,q.CreatorID,q.createddate,a.questionid,a.IsCorrect
from question q
join answer a on a.QuestionID = q.questionid
join typequestion tq on tq.typeid = q.typeid;
-- câu 13 Lấy ra số lượng câu hỏi của mỗi loại tự luận hay trắc nghiệm-- 
select tq.typename,tq.typeid, count(q.typeid)
from question q
join  typequestion tq on tq.typeid = q.typeid
group by q.typeid;

-- câu 14 & 15:Lấy ra group không có account nào--

SELECT * FROM `group` g
LEFT JOIN groupaccount ga ON g.GroupID = ga.GroupID
WHERE GA.AccountID IS NULL;
-- câu 16 Lấy ra question không có answer nào--
SELECT *
FROM Question Q
LEFT JOIN Answer A
ON Q.QuestionID = A.QuestionID
WHERE A.QuestionID IS NULL;

-- câu 17 a) Lấy các account thuộc nhóm thứ 1
select a.fullname
from groupaccount ag
join `account` a on a.accountid = ag.accountid
where ag.groupid = 1;
	-- Lấy các account thuộc nhóm thứ 2
    SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;
	-- c) Ghép 2 kết quả từ câu a) và câu b) sao cho không có record nào trùng nhau
    select a.fullname
from groupaccount ag
join `account` a on a.accountid = ag.accountid
where ag.groupid = 1  
union
 SELECT A.FullName FROM `Account` A
JOIN GroupAccount GA ON A.AccountID = GA.AccountID
WHERE GA.GroupID = 2;

-- câu 18 a) Lấy các group có lớn hơn 5 thành viên
select ag.accountid, count(ag.accountid) as sl
from `account` a
join groupaccount ag on ag.accountid = a.accountid
group by a.accountid
having count(ag.accountid) >5;
	-- 	b) Lấy các group có nhỏ hơn 7 thành viên
    select ag.accountid, count(ag.accountid) as sla
from `account` a
join groupaccount ag on ag.accountid = a.accountid
group by a.accountid
having count(ag.accountid) <7;
		-- c) Ghép 2 kết quả từ câu a) và câu b)
  select ag.accountid, count(ag.accountid) as slb
from `account` a
join groupaccount ag on ag.accountid = a.accountid
group by a.accountid
having count(ag.accountid) >5
union
   select ag.accountid, count(ag.accountid) as sla
from `account` a
join groupaccount ag on ag.accountid = a.accountid
group by a.accountid
having count(ag.accountid) <7;

    
    
    
























