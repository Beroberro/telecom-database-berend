CREATE DATABASE TelecomDB;
USE TelecomDB;

CREATE TABLE Customer (
  CustomerID INT PRIMARY KEY AUTO_INCREMENT,  
  FullName VARCHAR(100),
  Phone VARCHAR(20),
  Email VARCHAR(100),
  Address TEXT,
  JoinDate DATE,
  CustomerType ENUM('Individual', 'Corporate')  
);

CREATE TABLE Plan (
  PlanID INT PRIMARY KEY AUTO_INCREMENT,
  PlanName VARCHAR(100),
  PlanType ENUM('Prepaid', 'Postpaid'),
  MonthlyCost DECIMAL(10,2),  
  DataLimitMB INT,
  CallMinutes INT,
  SMSLimit INT,
  IsActive BOOLEAN
);

CREATE TABLE Subscription (
  SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  PlanID INT,
  StartDate DATE,
  EndDate DATE,
  Status ENUM('Active', 'Suspended', 'Cancelled'),
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (PlanID) REFERENCES Plan(PlanID)
);

CREATE TABLE CustomerUsage (
  UsageID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  UsageDate DATE,
  CallMinutes INT,
  SMSCount INT,
  DataUsedMB INT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Billing (
  BillID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  Month VARCHAR(20),
  TotalAmount DECIMAL(10,2),
  PaymentStatus ENUM('Paid', 'Unpaid', 'Overdue'),
  DueDate DATE,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE Payment (
  PaymentID INT PRIMARY KEY AUTO_INCREMENT,
  BillID INT,
  PaymentDate DATE,
  AmountPaid DECIMAL(10,2),
  PaymentMethod ENUM('Card', 'Transfer', 'Wallet'),
  FOREIGN KEY (BillID) REFERENCES Billing(BillID)
);

CREATE TABLE Network_Element (
  ElementID INT PRIMARY KEY AUTO_INCREMENT,
  Location VARCHAR(100),
  ElementType VARCHAR(50),
  Status ENUM('Active', 'Faulty', 'Maintenance'),
  LastCheckDate DATE
);

CREATE TABLE Support_Ticket (
  TicketID INT PRIMARY KEY AUTO_INCREMENT,
  CustomerID INT,
  NetworkElementID INT,
  OpenDate DATE,
  IssueType VARCHAR(100),
  Priority ENUM('Low', 'Medium', 'High'),
  Status ENUM('Open', 'In Progress', 'Closed'),
  ResolutionNote TEXT,
  FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID),
  FOREIGN KEY (NetworkElementID) REFERENCES Network_Element(ElementID)
);

CREATE TABLE Employee (
  EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
  FullName VARCHAR(100),
  Email VARCHAR(100),
  Phone VARCHAR(20),
  Position VARCHAR(50),
  Department VARCHAR(50),
  HireDate DATE
);

CREATE TABLE Assigned_Ticket (
  AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
  TicketID INT,
  EmployeeID INT,
  AssignedDate DATE,
  HandledStatus ENUM('Pending', 'In Progress', 'Resolved'),
  FOREIGN KEY (TicketID) REFERENCES Support_Ticket(TicketID),
  FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

INSERT INTO Customer (FullName, Phone, Email, Address, JoinDate, CustomerType)
VALUES
('Ahmet Yılmaz', '+905321112233', 'ahmet.yilmaz@example.com', 'İstanbul, Kadıköy', '2023-01-10', 'Individual'),
('Ayşe Demir', '+905426667788', 'ayse.demir@example.com', 'Ankara, Çankaya', '2023-03-15', 'Corporate'),
('Mehmet Kaya', '+905322224455', 'mehmet.kaya@example.com', 'İzmir, Bornova', '2023-05-22', 'Individual');

INSERT INTO Plan (PlanName, PlanType, MonthlyCost, DataLimitMB, CallMinutes, SMSLimit, IsActive)
VALUES
('Smart 10GB', 'Postpaid', 79.99, 10240, 500, 1000, TRUE),
('Mini 5GB', 'Prepaid', 49.90, 5120, 300, 500, TRUE),
('Max 50GB', 'Postpaid', 149.90, 51200, 2000, 2000, TRUE);

INSERT INTO Subscription (CustomerID, PlanID, StartDate, EndDate, Status)
VALUES
(1, 1, '2023-01-10', NULL, 'Active'),
(2, 3, '2023-04-01', NULL, 'Active'),
(3, 2, '2023-05-22', NULL, 'Suspended');

INSERT INTO CustomerUsage (CustomerID, UsageDate, CallMinutes, SMSCount, DataUsedMB)
VALUES
(1, '2023-06-01', 45, 20, 950),
(1, '2023-06-02', 30, 15, 800),
(2, '2023-06-01', 120, 100, 5000);

INSERT INTO Billing (CustomerID, Month, TotalAmount, PaymentStatus, DueDate)
VALUES
(1, 'June 2023', 79.99, 'Paid', '2023-06-15'),
(2, 'June 2023', 149.90, 'Unpaid', '2023-06-20');

INSERT INTO Payment (BillID, PaymentDate, AmountPaid, PaymentMethod)
VALUES
(1, '2023-06-10', 79.99, 'Card'),
(2, '2023-06-22', 149.90, 'Transfer');

INSERT INTO Network_Element (Location, ElementType, Status, LastCheckDate)
VALUES
('İstanbul - Üsküdar', 'Tower', 'Active', '2023-05-30'),
('Ankara - Sincan', 'Router', 'Maintenance', '2023-06-01');

INSERT INTO Support_Ticket (CustomerID, NetworkElementID, OpenDate, IssueType, Priority, Status, ResolutionNote)
VALUES
(1, 1, '2023-06-03', 'İnternet bağlantısı kesildi', 'High', 'Open', ''),
(2, 2, '2023-06-05', 'Yavaş bağlantı', 'Medium', 'In Progress', '');

INSERT INTO Employee (FullName, Email, Phone, Position, Department, HireDate)
VALUES
('Zeynep Koç', 'zeynep.koc@example.com', '+905555123456', 'Teknik Uzman', 'Destek', '2022-10-01'),
('Ali Vural', 'ali.vural@example.com', '+905555654321', 'Saha Ekibi', 'Teknik', '2021-03-15');

INSERT INTO Assigned_Ticket (TicketID, EmployeeID, AssignedDate, HandledStatus)
VALUES
(1, 1, '2023-06-03', 'In Progress'),
(2, 2, '2023-06-05', 'Pending');
