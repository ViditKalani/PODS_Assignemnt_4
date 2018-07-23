set echo on;

--Drop and Create Publisher table
DROP TABLE PUBLISHER CASCADE CONSTRAINTS;
CREATE TABLE PUBLISHER (
  Name  	varchar2(50),
  Address 	VARCHAR2(100),
  Phone 	VARCHAR2(15),
  primary key (Name)
);

--Drop and Create Book table.  Foreign key to publisher table.
DROP TABLE BOOK CASCADE CONSTRAINTS;
CREATE TABLE BOOK (
  BookId  	int,
  Title 	varchar2(100) NOT NULL,
  Publisher 	VARCHAR2(50),
  PRIMARY KEY (BookId),
  foreign key (Publisher) references PUBLISHER(Name) on delete cascade
);

--Drop and Create Book_Authors table.  Foreign key to Book table.
DROP TABLE BOOK_AUTHORS CASCADE CONSTRAINTS;
CREATE TABLE BOOK_AUTHORS (
  BookId  	int,
  AuthorName 	VARCHAR2(50),
  primary key (BookId, AuthorName),
  foreign key (BookId) references BOOK(BookId) on delete cascade
);

--Drop and Create Library_Branch table
DROP TABLE LIBRARY_BRANCH CASCADE CONSTRAINTS;
CREATE TABLE LIBRARY_BRANCH(
  BranchId  	INT,
  BranchName 	VARCHAR2(50) NOT NULL,
  Address	    varchar2(100),
  primary key (BranchId)
);

-- drop and create borrower sequence
DROP SEQUENCE borrower_seq;
CREATE SEQUENCE borrower_seq START with 12001 INCREMENT BY 1;

--Drop and Create Borrower table
DROP TABLE BORROWER CASCADE CONSTRAINTS;
CREATE TABLE BORROWER (
  CardNo 	VARCHAR2(20),
  NAME	 	VARCHAR2(50) NOT NULL,
  Address	varchar2(100),
  Phone 	VARCHAR2(15),
  Password VARCHAR2(15),
  primary key (CardNo)
);

--Drop and Create Book_Copies table. Foreign key to Book table.  
--Foreign key to Library_Branch table.
DROP TABLE BOOK_COPIES CASCADE CONSTRAINTS;
CREATE TABLE BOOK_COPIES (
  BookId  	INT,
  BranchId  	INT,
  No_Of_Copies 	INT CHECK(No_of_Copies > 0),
  PRIMARY KEY (BookId,BranchId),
  FOREIGN KEY (BookId) REFERENCES BOOK(BookId) ON DELETE CASCADE,
  foreign key (BranchId) references LIBRARY_BRANCH(BranchId) on delete cascade
);

--Drop and Create Book_Loans table. Foreign key to Book table. Foreign key to Library_Branch table.  
--Foreign key to Borrower table.
DROP TABLE BOOK_LOANS CASCADE CONSTRAINTS;
CREATE TABLE BOOK_LOANS (
  BookId  	INT,
  BranchId  	INT,
  CardNo 	VARCHAR2(20),
  DateOut 	DATE,
  DueDate 	DATE,
  DateIn 	DATE,
  rating INT CHECK(rating between 1 and 10),
  CONSTRAINT dt_check CHECK(DueDate = add_months(DateOut,1)),
  PRIMARY KEY (BookId,BranchId,CardNo),
  FOREIGN KEY (BookId) REFERENCES BOOK(BookId) ON DELETE CASCADE,
  FOREIGN KEY (BranchId) REFERENCES LIBRARY_BRANCH(BranchId) ON DELETE CASCADE,
  foreign key (CardNo) references BORROWER(CardNo) on delete cascade
);

commit;

--PUBLISHER
INSERT INTO PUBLISHER VALUES ('New Moon Books','Boston','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('BinnetHardley','Washington','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('Algodata Infosystems','Berkeley','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('Five Lakes Publishing','Chicago','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('Ramona Publishers','Dallas','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('GGGG','M?nchen','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('Scootney Books','New York','(206) 555-9857');
INSERT INTO PUBLISHER VALUES ('Lucerne Publishing','Paris','(206) 555-9857');

--BOOK
INSERT INTO BOOK VALUES ('1032','The Busy Executives Database Guide','Algodata Infosystems');
INSERT INTO BOOK VALUES ('1111','Cooking with Computers: Surreptitious Balance Sheets','Algodata Infosystems');
INSERT INTO BOOK VALUES ('2075','You Can Combat Computer Stress!','New Moon Books');
INSERT INTO BOOK VALUES ('7832','Straight Talk About Computers','Algodata Infosystems');
INSERT INTO BOOK VALUES ('2222','Silicon Valley Gastronomic Treats','BinnetHardley');
INSERT INTO BOOK VALUES ('3021','The Gourmet Microwave','BinnetHardley');
INSERT INTO BOOK VALUES ('3026','The Psychology of Computer Cooking','BinnetHardley');
INSERT INTO BOOK VALUES ('1035','But Is It User Friendly?','New Moon Books');
INSERT INTO BOOK VALUES ('8888','Secrets of Silicon Valley','Algodata Infosystems');
INSERT INTO BOOK VALUES ('9999','Net Etiquette','Algodata Infosystems');
INSERT INTO BOOK VALUES ('1372','Computer Phobic AND Non-Phobic Individuals: Behavior Variations','BinnetHardley');
INSERT INTO BOOK VALUES ('2091','Is Anger the Enemy?','New Moon Books');
INSERT INTO BOOK VALUES ('2106','Life Without Fear','New Moon Books');
INSERT INTO BOOK VALUES ('3333','Prolonged Data Deprivation: Four Case Studies','New Moon Books');
INSERT INTO BOOK VALUES ('7777','Emotional Security: A New Algorithm','New Moon Books');
INSERT INTO BOOK VALUES ('3218','Onions, Leeks, and Garlic: Cooking Secrets of the Mediterranean','BinnetHardley');
INSERT INTO BOOK VALUES ('4203','Fifty Years in Buckingham Palace Kitchens','BinnetHardley');
INSERT INTO BOOK VALUES ('7778','Sushi, Anyone?','BinnetHardley');

--BOOK_AUTHORS
INSERT INTO BOOK_AUTHORS VALUES ('1032','Bennet');
INSERT INTO BOOK_AUTHORS VALUES ('1111','MacFeather');
INSERT INTO BOOK_AUTHORS VALUES ('2075','Green');
INSERT INTO BOOK_AUTHORS VALUES ('7832','Straight');
INSERT INTO BOOK_AUTHORS VALUES ('2222','Ringer');
INSERT INTO BOOK_AUTHORS VALUES ('3021','DeFrance');
INSERT INTO BOOK_AUTHORS VALUES ('1035','Carson');
INSERT INTO BOOK_AUTHORS VALUES ('8888','Ringer');
INSERT INTO BOOK_AUTHORS VALUES ('9999','Locksley');
INSERT INTO BOOK_AUTHORS VALUES ('1372','Karsen');
INSERT INTO BOOK_AUTHORS VALUES ('2091','Ringer');
INSERT INTO BOOK_AUTHORS VALUES ('2106','Ringer');
INSERT INTO BOOK_AUTHORS VALUES ('3333','White');
INSERT INTO BOOK_AUTHORS VALUES ('3333','Williams');
INSERT INTO BOOK_AUTHORS VALUES ('7777','Locksley');
INSERT INTO BOOK_AUTHORS VALUES ('7777','Parsley');
INSERT INTO BOOK_AUTHORS VALUES ('7777','Ginger');
INSERT INTO BOOK_AUTHORS VALUES ('3218','Panteley');
INSERT INTO BOOK_AUTHORS VALUES ('4203','Blotchet-Halls');
INSERT INTO BOOK_AUTHORS VALUES ('4203','Smith');
INSERT INTO BOOK_AUTHORS VALUES ('4203','Johnson');
INSERT INTO BOOK_AUTHORS VALUES ('7778','Gringlesby');

--LIBRARY_BRANCH
INSERT INTO LIBRARY_BRANCH VALUES ('6380','Sharpstown','788 Catamaugus Ave.');
INSERT INTO LIBRARY_BRANCH VALUES ('7066','South','567 Pasadena Ave.');
INSERT INTO LIBRARY_BRANCH VALUES ('7067','Carnegie','577 First St.');
INSERT INTO LIBRARY_BRANCH VALUES ('7131','Bemis','24-A Avogadro Way');
INSERT INTO LIBRARY_BRANCH VALUES ('7896','Downtown','89 Madison St.');
INSERT INTO LIBRARY_BRANCH VALUES ('8042','Nothwest','679 Carson St.');

--Borrower
-- use borrower_seq.currval to get the current value of the sequence column
-- see sample usage of borrower_seq.nextval
INSERT INTO BORROWER VALUES (borrower_seq.nextval,'Greg','111 10th Ave, Milwaukee, WI','414-555-9857','pass123');
INSERT INTO BORROWER VALUES ('1','Davolio','507 - 20th Ave. E.  Apt. 2A','206-555-9857','pass234');
INSERT INTO BORROWER VALUES ('2','Fuller','908 W. Capital Way','206-555-9482','pass345');
INSERT INTO BORROWER VALUES ('3','Leverling','722 Moss Bay Blvd.','206-555-3412','pass234');
INSERT INTO BORROWER VALUES ('4','Peacock','4110 Old Redmond Rd.','414-555-8122','pass234');
INSERT INTO BORROWER VALUES ('5','Buchanan','14 Garrett Hill','414-000-1234','pass456');
INSERT INTO BORROWER VALUES ('6','Suyama','Coventry House  Miner Rd.','712-414-7773','pass111');
INSERT INTO BORROWER VALUES ('7','King','Edgeham Hollow  Winchester Way','712-555-5598','pass112');
INSERT INTO BORROWER VALUES ('8','Callahan','4726 - 11th Ave. N.E.','206-555-1189','pass234');
INSERT INTO BORROWER VALUES ('9','Dodsworth','7 Houndstooth Rd.','712-555-4414','pass113');
INSERT INTO BORROWER VALUES ('10','Simpson','742 Evergreen Terrace','847-991-4147','pass114');
INSERT INTO BORROWER VALUES ('11','Miller','9764 Jeapordy Ln','312-555-1212','pass115');
INSERT INTO BORROWER VALUES ('12','Davis','9364 Milwaukee Ave','262-565-1212','pass116');
INSERT INTO BORROWER VALUES ('13','Garcia','9334 Wisconsin Ave','678-577-1212','pass117');
INSERT INTO BORROWER VALUES ('14','Ram','1234 Muskego Ave','912-414-1212','pass118');

--Book Copies
INSERT INTO BOOK_COPIES VALUES ('1035','6380','2');
INSERT INTO BOOK_COPIES VALUES ('1372','7066','1');
INSERT INTO BOOK_COPIES VALUES ('1111','7067','3');
INSERT INTO BOOK_COPIES VALUES ('7777','7131','4');
INSERT INTO BOOK_COPIES VALUES ('1035','7896','5');
INSERT INTO BOOK_COPIES VALUES ('2091','8042','1');
INSERT INTO BOOK_COPIES VALUES ('2106','6380','2');
INSERT INTO BOOK_COPIES VALUES ('9999','7066','2');
INSERT INTO BOOK_COPIES VALUES ('3218','7067','2');
INSERT INTO BOOK_COPIES VALUES ('3333','7131','2');
INSERT INTO BOOK_COPIES VALUES ('8888','7896','2');
INSERT INTO BOOK_COPIES VALUES ('2222','8042','1');
INSERT INTO BOOK_COPIES VALUES ('7832','6380','7');
INSERT INTO BOOK_COPIES VALUES ('7777','7066','1');
INSERT INTO BOOK_COPIES VALUES ('1032','7067','1');
INSERT INTO BOOK_COPIES VALUES ('1035','7131','4');
INSERT INTO BOOK_COPIES VALUES ('3026','7896','2');
INSERT INTO BOOK_COPIES VALUES ('2075','8042','3');

--Book Loans

INSERT INTO BOOK_LOANS VALUES ('1035','7067','12',sysdate,add_months(sysdate,1),null, 8);
INSERT INTO BOOK_LOANS VALUES ('1035','6380','1',sysdate,add_months(sysdate,1),null, 5);
INSERT INTO BOOK_LOANS VALUES ('2075','7066','2',sysdate-3,add_months(sysdate-3,1),null, 5);
INSERT INTO BOOK_LOANS VALUES ('1111','7067','3',sysdate-7,add_months(sysdate-7,1),null, 3);
INSERT INTO BOOK_LOANS VALUES ('7777','7131','4',sysdate-10,add_months(sysdate-10,1),null, 7);
INSERT INTO BOOK_LOANS VALUES ('4203','7896','5',sysdate,add_months(sysdate,1),null, 10);
INSERT INTO BOOK_LOANS VALUES ('2075','8042','1',sysdate-4,add_months(sysdate-4,1),null, 1);
INSERT INTO BOOK_LOANS VALUES ('2106','6380','7',sysdate-24,add_months(sysdate-24,1),null, 9);
INSERT INTO BOOK_LOANS VALUES ('9999','7066','2',sysdate-40,add_months(sysdate-40,1),null, 8);
INSERT INTO BOOK_LOANS VALUES ('3218','7067','9','29-Oct-2015','29-Nov-2015',null, 3);
INSERT INTO BOOK_LOANS VALUES ('3333','7131','10','25-Dec-2015','25-Jan-2016',null, 2);
INSERT INTO BOOK_LOANS VALUES ('1035','7896','11',SYSDATE,add_months(SYSDATE,1),null, 8);
INSERT INTO BOOK_LOANS VALUES ('4203','7896','12','3-Sep-2016','3-Oct-2016',null, 7);


commit;



set echo off;