set echo on;

--1. List the names of authors who have authored more than 3 books

select BookId, AuthorName
from BOOK_AUTHORS
where AuthorName IN (select AuthorName from BOOK_AUTHORS GROUP BY AuthorName HAVING COUNT(distinct BookID) > 3);


--2. Print the names of borrowers whose phone number starts with area code “414”.
    
select Name, Phone
from   BORROWER
where  Phone  like '414%';

--3. Retrieve the names of borrowers who have never checked out any books.

select distinct B.Name, (l.BOOKID)
from BORROWER B,BOOK_LOANS l
where NOT EXISTS (select L.DateOut from BOOK_LOANS L where B.CardNo = L.CardNo );

--Another Method
select b.name
from BORROWER b
where not exists (select L.DateOut from BOOK_LOANS L where B.CardNo = L.CardNo );

--Another Method
select b.name 
from BORROWER b 
where b.CardNo not in(select l.CardNo from BOOK_LOANS l);

--4. List the titles of books written by “Ringer” author?

select Title, BookId, AuthorName
from (BOOK_AUTHORS NATURAL JOIN BOOK)
where AuthorName = 'Ringer';


--5. List the name(s) of borrowers, who have loaned books 
--ONLY published by “New Moon Books” publisher?

select b.Name
from BORROWER b, BOOK_LOANS l, BOOK k
where b.CardNo = l.CardNo and Publisher = 'New Moon Books'
GROUP BY b.CardNo, b.Name;


--6. How many copies of the book titled “But Is It User Friendly?” are owned by each library branch?

select BranchName, No_Of_Copies
from ((BOOK NATURAL JOIN BOOK_COPIES ) NATURAL JOIN LIBRARY_BRANCH )
where Title='But Is It User Friendly?';

--Another Method
select BranchName,sum(No_Of_Copies) 
from BOOK_COPIES a, LIBRARY_BRANCH lb,
(select BookId 
from BOOK 
where Title = 'But Is It User Friendly?') b
where a.BookId =b.BookId
and lb.BranchId = a.BranchId
group by BranchName;


--7. List the book titles co-authored by more than 2 people.


select Title
from BOOK b,
(select BookId,count(*) 
from BOOK_AUTHORS
group by BookId 
having count(*) > 2) ba
where b.BookId = ba.BookId;


--8. Print the names of borrowers who have borrowed the highest number of books.


select B.Name, MAX(c.No_of_Copies) as Highest_No_of_Copies
from BORROWER B, BOOK_LOANS L, BOOK_COPIES c
where B.CardNo = L.CardNo and l.BookId = c.BookId
GROUP BY B.CardNo, B.Name;

--Another Method
select B.Name, MAX(c.No_of_Copies) as Highest_No_of_Copies
from BORROWER B, BOOK_LOANS L, BOOK_COPIES c
where B.CardNo = L.CardNo
GROUP BY B.CardNo, B.Name;

--Another Method
select  name
from BORROWER b, 
(select CardNo, count(BookId) cnt 
from BOOK_LOANS 
group by CardNo) bl,
(select  max(count(BookId)) cnt 
from BOOK_LOANS
group by CArdNo) c
where b.CardNo=bl.CardNo
and bl.cnt = c.cnt;

--9. Print the names of borrowers who have not yet returned the books.

select b.Name
from BORROWER b
where not exists (select l.DateIn from BOOK_LOANS l where b.CardNo = l.CardNo);

--10.  Print the BookId, book title and average rating received for each book. 
-- Shows the results sorted in decreasing order of average rating received. 
--Do not show books below an average rating of 3.0

select k.BookId,k.Title, round(avg(l.Rating),2) 
from BOOK k, BOOK_LOANS l
where k.BookId = l.Bookid and l.Rating > 3
group by k.BookId, k.Title, l.Rating
order by l.Rating DESC;

--Another Method
select b.BookId, b.Title, br.rtg
from BOOK b,
(select BookId, avg(Rating) rtg
from BOOK_LOANS
group by BookId) br
where b.BookId = br.BookId
and br.rtg>=3 order by rtg desc;


--11. For each book that is loaned out from the "Sharpstown" branch and 
--which are not yet returned to the library, 
--retrieve the book title, the borrower's name, and the borrower's address.
--Question

select b.Title, br.Name, br.Address
from BOOK b, BORROWER br, BOOK_LOANS bl
where b.BookID = bl.BookID
and br.CardNo = bl.CardNO
and bl.BranchId in 
(select BranchId 
from LIBRARY_BRANCH where branchName = 'Sharpstown')
and bl.datein is null;

--Another Method
select b.Title, r.Name, r.Address
from BOOK b, BORROWER r, BOOK_LOANS l, LIBRARY_BRANCH lb
where lb.BranchName = 'Sharpstown' AND l.BranchId = lb.BranchId AND l.CardNo = r.CardNo AND l.BookId = b.BookId AND 
        l.DueDate = '22-JUN-2018';
        

--12.  Print the total number of borrowers in the database.

select sum(c.No_of_Copies), count(b.CardNo)
from BOOK_COPIES c, BORROWER b
Where b.CardNo = c.No_Of_Copies;

--ANOTHER METHOD
select count(CardNo) 
from BORROWER;


--13.  Print the names of tough reviewers. 
--Tough reviewers are the borrowers who have given the lowest overall recommendation value 
--that a book has for each of the books they have reviewed.
--Question

SELECT b.name, b.title, T.s
FROM BORROWER b, BOOK b, BOOK_LOANS bl
left Join BOOK_LOANS l, (
	SELECT l.Rating, l.BookID
	FROM BOOK_LOANS l
	WHERE l.Rating IN 
		(SELECT min(l.Rating) FROM BOOK_LOANS l)
	) T
ON T.Rating = b.Rating
AND T.BookId = l.BookId;

--14.  Print the names of borrowers and the count of number of books that they have reviewed.  
--Shows the results sorted in decreasing order of number of books reviewed. 
--Display the count as zero for the borrowers who have not reviewed any book.
--Question

select b.Name, count(l.Rating)
from  BORROWER b
LEFT JOIN  BOOK_LOANS l on l.Cardno = b.Name
where b.Name not in (select l.CardNo from BOOK_LOANS l where l.CardNo = b.Name)
group by l.Rating, b.Name;

--Another Method
select Name, nvl(Rating,0)
from BORROWER br left outer join BOOK_LOANS bl
on br.CardNO = bl.CardNO
order by nvl(Rating,0) desc;

--Another Method
select b.Name , Count(c.No_of_Copies)
from BORROWER b , BOOK_COPIES c, BOOK_LOANS l
where b.CardNo = l.CardNo and c.No_of_Copies = c.BookId and l.bookId = c.BookId
GROUP BY c.No_of_Copies, b.Name
ORDER BY No_of_Copies DESC;


--15.  Print the names and addresses of all publishers in the database.

select p.Name, p.Address
from PUBLISHER p
Where p.Name = p.Name and p.address = p.address;

--Another Method
select Name, Address 
from PUBLISHER;

set echo off;