create database Inventory_Managment_system;
use inventory_managment_system;


CREATE TABLE `Product` (
    `ProductID` int  primary key ,
    `ProductCode` varchar(100),
    `Barcode` varchar(100) ,
    `ProductName` varchar(100) ,
    `ProductDescription` varchar(2000) ,
    `ProductCategory` varchar(100),
    `ReorderQuantity` int ,
    `PackedWeight` DECIMAL(10,2),
    `PackedHeight` DECIMAL(10,2),
    `PackedWidth` DECIMAL(10,2) ,
    `Refrigerated` BOOLEAN
);

CREATE TABLE `Location` (
    `LocationID` int primary key,
    `LocationName` varchar(20) ,
    `LocationAddress` varchar(200) );

CREATE TABLE `Warehouse`(
    `WarehouseID` int  Primary key ,
    `WarehouseName` varchar(100) ,
    `IsRefrigerated` BOOLEAN
);

CREATE TABLE `Inventry` (
    `InventoryID` int  Primary key,
    `QantityAvailable` int  NOT NULL ,
    `MinimumStockLevel` int  NOT NULL ,
    `MaximumStockLevel` int  NOT NULL ,
    `ReorderPoint` int  NOT NULL
);

CREATE TABLE `Provider` (
    `ProviderID` int  Primary Key,
    `ProviderName` varchar(100)  NOT NULL ,
    `ProviderAddress` varchar(200)  NOT NULL
);

CREATE TABLE `Order` (
    `OrderID` int Primary Key ,
    `OrderDate` Date  NOT NULL
);

CREATE TABLE `OrderDetail` (
    `OrderDetailID` int  Primary key ,
    `orderQuantity` int  NOT NULL ,
    `ExpectedDate` Date  NOT NULL ,
    `ActualDate` Date  NOT NULL
);

CREATE TABLE `Customer` (
    `CustomerID` int Primary key ,
    `CustomerName` varchar(100)  NOT NULL ,
    `CustomerAddress` varchar(200)  NOT NULL
);

CREATE TABLE `Delivery` (
    `DeliveryID` int  Primary key,
    `salesDate` Date  NOT NULL
);

CREATE TABLE `DeliveryDetail` (
    `DeliveryDetailID` int  Primary key,
    `DeliveryQuantity` int  NOT NULL ,
    `ExpectedDate` date  NOT NULL ,
    `ActualDate` date  NOT NULL 
);

create table `Transfer`(
TransferID int primary key,
TransferQuantity int,
SentDate date,
ReceivedDate date
);
