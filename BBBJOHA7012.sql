
USE Master
GO
IF DB_ID('BBBJoha7012') IS NOT NULL
	BEGIN
		ALTER DATABASE BBBJoha7012 SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE BBBJoha7012
	END
GO
CREATE DATABASE BBBJoha7012
GO
USE BBBJoha7012
GO

CREATE TABLE Vaskeri (
VaskeriID INT  PRIMARY KEY IDENTITY(1,1)NOT NULL,
VaskeriNavn NVARCHAR(30),
Åbningstid TIME,
Lukningstid TIME

);

CREATE TABLE VaskeMaskine (
MaskineID INT PRIMARY KEY IDENTITY(1,1)NOT NULL,
MaskineNavn NVARCHAR(30),
PrisPr DECIMAL,
VaskeTid INT,
FK_VaskeriID INT NOT NULL,

CONSTRAINT CONSTRAINT_VaskeriID FOREIGN KEY (FK_VaskeriID) REFERENCES Vaskeri(VaskeriID)

);

CREATE TABLE Bruger (
BrugerID INT PRIMARY KEY IDENTITY(1,1)NOT NULL,
BrugerNavn NVARCHAR(20),
Email NVARCHAR (50) UNIQUE,
[Password] NVARCHAR (20),
Konto DECIMAL,
FK_BrugerID INT NOT NULL,
OprettetBruger DATE

CONSTRAINT CONSTRAINT_BrugerID FOREIGN KEY (FK_BrugerID) REFERENCES Vaskeri(VaskeriID),
CONSTRAINT Password_Length CHECK (LEN([Password]) >= 5)
);

CREATE TABLE Booking (
BookingID INT PRIMARY KEY IDENTITY (1,1)NOT NULL,
BookingTid DATETIME,
FK_BookingBrugerID INT NOT NULL,
FK_BookingMaskineID INT NOT NULL,

CONSTRAINT CONSTRAINT_BookingBruger FOREIGN KEY (FK_BookingBrugerID) REFERENCES Bruger(BrugerID),

CONSTRAINT CONSTRAINT_BookingMaskine FOREIGN KEY (FK_BookingMaskineID) REFERENCES VaskeMaskine(MaskineID)
);

INSERT INTO Vaskeri (VaskeriNavn,Åbningstid,Lukningstid)
VALUES ('Whitewash Inc.','08:00:00','20:00:00' )
INSERT INTO Vaskeri (VaskeriNavn,Åbningstid,Lukningstid)
VALUES ('Double Bubble.','02:00:00','22:00:00' )
INSERT INTO Vaskeri (VaskeriNavn,Åbningstid,Lukningstid)
VALUES ('Wash & COffee.','12:00:00','20:00:00' )

INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('Mielle 911 Turbo', 5.00, 60,2)
INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('Siemons IClean', 10000.00, 30,1)
INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('Electrolax FX-2', 15.00, 45,2)
INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('NASA Spacewasher 8000', 500.00, 5,1)
INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('The Lost Sock', 3.50, 90,3)
INSERT INTO VaskeMaskine(MaskineNavn,PrisPr,VaskeTid,FK_VaskeriID)
VALUES ('Yo Mama', 0.50, 120,3)

INSERT INTO Bruger(BrugerNavn,Email,[Password],Konto,FK_BrugerID,OprettetBruger)
VALUES ('John','john_doe66@gmail.com','password',100.00,2,'2021-02-15')
INSERT INTO Bruger(BrugerNavn,Email,[Password],Konto,FK_BrugerID,OprettetBruger)
VALUES ('Neil Armstrong','firstman@nasa.gov','eagleLander69',1000.00,1,'2021-02-10')
INSERT INTO Bruger(BrugerNavn,Email,[Password],Konto,FK_BrugerID,OprettetBruger)
VALUES ('Batman','noreply@thecave.com','Rob1n',500.00,3,'2021-03-10')
INSERT INTO Bruger(BrugerNavn,Email,[Password],Konto,FK_BrugerID,OprettetBruger)
VALUES ('Goldman Sachs','moneylaundering@gs.com','NotRecognized',100000.00,1,'2021-01-01')
INSERT INTO Bruger(BrugerNavn,Email,[Password],Konto,FK_BrugerID,OprettetBruger)
VALUES ('50 Cent','50cent@gmail.com','ItsMyBirthday',0.50,3,'2021-01-01')

INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 12:00:00',1,1)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 16:00:00',1,3)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 08:00:00',2,4)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 15:00:00',3,5)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 20:00:00',4,2)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 19:00:00',4,2)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 10:00:00',4,2)
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2021-02-26 16:00:00',4,2)

BEGIN TRANSACTION Goldmansachs_Tran
INSERT INTO Booking(BookingTid,FK_BookingBrugerID,FK_BookingMaskineID)
VALUES ('2022-09-15 12:00:00',4,2)
COMMIT 

GO
CREATE VIEW Booking_View AS
	SELECT BookingTid,BrugerNavn,MaskineNavn,PrisPr FROM Booking 
	
	JOIN Bruger ON BrugerID = FK_BookingBrugerID
	JOIN VaskeMaskine ON MaskineID = FK_BookingMaskineID		
GO

SELECT * FROM Booking_View

SELECT * FROM Bruger WHERE Email LIKE '%@gmail.com%';
GO
SELECT * FROM VaskeMaskine

JOIN Vaskeri ON VaskeMaskine.FK_VaskeriID = Vaskeri.VaskeriID
GO

GO
SELECT VaskeMaskine.MaskineNavn, COUNT(BookingID) FROM Booking
JOIN VaskeMaskine ON Booking.FK_BookingMaskineID = VaskeMaskine.MaskineID
GROUP BY MaskineNavn
ORDER BY COUNT(BookingID) DESC;
GO

GO
DELETE FROM Booking WHERE CAST(BookingTid AS time) BETWEEN '12:00' AND '13:00'
GO

GO
UPDATE Bruger
SET [Password] = 'SelinaKyle'
WHERE  BrugerNavn = 'Batman' AND Email = 'noreply@thecave.com'
GO