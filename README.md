# PODS_Assignemnt_4

Principle of Database System

Due date: June.24th
 
Consider the library (click the link for the sql file) database system, which keeps track of books, borrowers and book loans.
The description of the database is given to you in your previous Assignment. We are adding two more columns to BOOK_LOANS 
table, DateIn and rating. We have also added borrower_seq to generate unique sequence card no values for new borrowers. The 
DateIn column tracks the date the book is checked in and rating tracks the book rating given by a borrower. A book that has 
not been returned will have a ‘null’ value for DateIn. Rating is a value between 1 to 10, where 10 represents that the borrower
has given the highest rating for a book.
 
Answer the following as SQL queries for the oracle 10g/11i/12c database system. You are not allowed to create any additional 
tables or views to answer the queries.
 
1.   List the names of authors who have authored more than 3 books
2.   Print the names of borrowers whose phone number starts with area code “414”.
3.   Retrieve the names of borrowers who have never checked out any books.
4.   List the titles of books written by “Ringer” author?
5.   List the name(s) of borrowers, who have loaned books ONLY published by “New Moon Books” publisher?
6.   How many copies of the book titled “But Is It User Friendly?” are owned by each library branch?
7.   List the book titles co-authored by more than 2 people.
8.   Print the names of borrowers who have borrowed the highest number of books.
9.   Print the names of borrowers who have not yet returned the books.
10.  Print the BookId, book title and average rating received for each book. Shows the results sorted in decreasing order of 
     average rating received. Do not show books below an average rating of 3.0
11.  For each book that is loaned out from the "Sharpstown" branch and which are not yet returned to the library, retrieve the
     book title, the borrower's name, and the borrower's address.
12.  Print the total number of borrowers in the database.
13.  Print the names of tough reviewers. Tough reviewers are the borrowers who have given the lowest overall recommendation 
     value that a book has for each of the books they have reviewed.
14.  Print the names of borrowers and the count of number of books that they have reviewed.  Shows the results sorted in
     decreasing order of number of books reviewed. Display the count as zero for the borrowers who have not reviewed any book.
15.  Print the names and addresses of all publishers in the database.

Submission: Submit queries-library.sql electronically using http://d2l.mu.edu. Also, submit sample execution screen 
shots/script output of running your queries against the library database.

