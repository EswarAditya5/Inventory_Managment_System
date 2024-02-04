-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema inventory_managment_system
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema inventory_managment_system
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `inventory_managment_system` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `inventory_managment_system` ;

-- -----------------------------------------------------
-- Table `inventory_managment_system`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`customer` (
  `CustomerID` INT NOT NULL,
  `CustomerName` VARCHAR(100) NOT NULL,
  `CustomerAddress` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`delivery` (
  `DeliveryID` INT NOT NULL,
  `salesDate` DATE NOT NULL,
  `customer_CustomerID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`, `customer_CustomerID`),
  INDEX `fk_delivery_customer1_idx` (`customer_CustomerID` ASC) VISIBLE,
  CONSTRAINT `fk_delivery_customer1`
    FOREIGN KEY (`customer_CustomerID`)
    REFERENCES `inventory_managment_system`.`customer` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`product` (
  `ProductID` INT NOT NULL,
  `ProductCode` VARCHAR(100) NULL DEFAULT NULL,
  `Barcode` VARCHAR(100) NULL DEFAULT NULL,
  `ProductName` VARCHAR(100) NULL DEFAULT NULL,
  `ProductDescription` VARCHAR(2000) NULL DEFAULT NULL,
  `ProductCategory` VARCHAR(100) NULL DEFAULT NULL,
  `ReorderQuantity` INT NULL DEFAULT NULL,
  `PackedWeight` DECIMAL(10,2) NULL DEFAULT NULL,
  `PackedHeight` DECIMAL(10,2) NULL DEFAULT NULL,
  `PackedWidth` DECIMAL(10,2) NULL DEFAULT NULL,
  `Refrigerated` TINYINT(1) NULL DEFAULT NULL,
  PRIMARY KEY (`ProductID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`location`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`location` (
  `LocationID` INT NOT NULL,
  `LocationName` VARCHAR(20) NULL DEFAULT NULL,
  `LocationAddress` VARCHAR(200) NULL DEFAULT NULL,
  PRIMARY KEY (`LocationID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`warehouse`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`warehouse` (
  `WarehouseID` INT NOT NULL,
  `WarehouseName` VARCHAR(100) NULL DEFAULT NULL,
  `IsRefrigerated` TINYINT(1) NULL DEFAULT NULL,
  `location_LocationID` INT NOT NULL,
  PRIMARY KEY (`WarehouseID`, `location_LocationID`),
  INDEX `fk_warehouse_location1_idx` (`location_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_warehouse_location1`
    FOREIGN KEY (`location_LocationID`)
    REFERENCES `inventory_managment_system`.`location` (`LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`deliverydetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`deliverydetail` (
  `DeliveryDetailID` INT NOT NULL,
  `DeliveryQuantity` INT NOT NULL,
  `ExpectedDate` DATE NOT NULL,
  `ActualDate` DATE NOT NULL,
  `delivery_DeliveryID` INT NOT NULL,
  `delivery_customer_CustomerID` INT NOT NULL,
  `product_ProductID` INT NOT NULL,
  `warehouse_WarehouseID` INT NOT NULL,
  `warehouse_location_LocationID` INT NOT NULL,
  PRIMARY KEY (`DeliveryDetailID`, `delivery_DeliveryID`, `delivery_customer_CustomerID`, `product_ProductID`, `warehouse_WarehouseID`, `warehouse_location_LocationID`),
  INDEX `fk_deliverydetail_delivery1_idx` (`delivery_DeliveryID` ASC, `delivery_customer_CustomerID` ASC) VISIBLE,
  INDEX `fk_deliverydetail_product1_idx` (`product_ProductID` ASC) VISIBLE,
  INDEX `fk_deliverydetail_warehouse1_idx` (`warehouse_WarehouseID` ASC, `warehouse_location_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_deliverydetail_delivery1`
    FOREIGN KEY (`delivery_DeliveryID` , `delivery_customer_CustomerID`)
    REFERENCES `inventory_managment_system`.`delivery` (`DeliveryID` , `customer_CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliverydetail_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_managment_system`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_deliverydetail_warehouse1`
    FOREIGN KEY (`warehouse_WarehouseID` , `warehouse_location_LocationID`)
    REFERENCES `inventory_managment_system`.`warehouse` (`WarehouseID` , `location_LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`inventry`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`inventry` (
  `InventoryID` INT NOT NULL,
  `QantityAvailable` INT NOT NULL,
  `MinimumStockLevel` INT NOT NULL,
  `MaximumStockLevel` INT NOT NULL,
  `ReorderPoint` INT NOT NULL,
  `product_ProductID` INT NOT NULL,
  `warehouse_WarehouseID` INT NOT NULL,
  `warehouse_location_LocationID` INT NOT NULL,
  PRIMARY KEY (`InventoryID`, `product_ProductID`, `warehouse_WarehouseID`, `warehouse_location_LocationID`),
  INDEX `fk_inventry_product1_idx` (`product_ProductID` ASC) VISIBLE,
  INDEX `fk_inventry_warehouse1_idx` (`warehouse_WarehouseID` ASC, `warehouse_location_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_inventry_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_managment_system`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_inventry_warehouse1`
    FOREIGN KEY (`warehouse_WarehouseID` , `warehouse_location_LocationID`)
    REFERENCES `inventory_managment_system`.`warehouse` (`WarehouseID` , `location_LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`provider`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`provider` (
  `ProviderID` INT NOT NULL,
  `ProviderName` VARCHAR(100) NOT NULL,
  `ProviderAddress` VARCHAR(200) NOT NULL,
  PRIMARY KEY (`ProviderID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`order` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `provider_ProviderID` INT NOT NULL,
  PRIMARY KEY (`OrderID`, `provider_ProviderID`),
  INDEX `fk_order_provider_idx` (`provider_ProviderID` ASC) VISIBLE,
  CONSTRAINT `fk_order_provider`
    FOREIGN KEY (`provider_ProviderID`)
    REFERENCES `inventory_managment_system`.`provider` (`ProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`orderdetail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`orderdetail` (
  `OrderDetailID` INT NOT NULL,
  `orderQuantity` INT NOT NULL,
  `ExpectedDate` DATE NOT NULL,
  `ActualDate` DATE NOT NULL,
  `order_OrderID` INT NOT NULL,
  `order_provider_ProviderID` INT NOT NULL,
  `product_ProductID` INT NOT NULL,
  `warehouse_WarehouseID` INT NOT NULL,
  `warehouse_location_LocationID` INT NOT NULL,
  PRIMARY KEY (`OrderDetailID`, `order_OrderID`, `order_provider_ProviderID`, `product_ProductID`, `warehouse_WarehouseID`, `warehouse_location_LocationID`),
  INDEX `fk_orderdetail_order1_idx` (`order_OrderID` ASC, `order_provider_ProviderID` ASC) VISIBLE,
  INDEX `fk_orderdetail_product1_idx` (`product_ProductID` ASC) VISIBLE,
  INDEX `fk_orderdetail_warehouse1_idx` (`warehouse_WarehouseID` ASC, `warehouse_location_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_orderdetail_order1`
    FOREIGN KEY (`order_OrderID` , `order_provider_ProviderID`)
    REFERENCES `inventory_managment_system`.`order` (`OrderID` , `provider_ProviderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderdetail_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_managment_system`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_orderdetail_warehouse1`
    FOREIGN KEY (`warehouse_WarehouseID` , `warehouse_location_LocationID`)
    REFERENCES `inventory_managment_system`.`warehouse` (`WarehouseID` , `location_LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `inventory_managment_system`.`transfer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `inventory_managment_system`.`transfer` (
  `TransferID` INT NOT NULL,
  `TransferQuantity` INT NULL DEFAULT NULL,
  `SentDate` DATE NULL DEFAULT NULL,
  `ReceivedDate` DATE NULL DEFAULT NULL,
  `product_ProductID` INT NOT NULL,
  `warehouse_WarehouseID` INT NOT NULL,
  `warehouse_location_LocationID` INT NOT NULL,
  PRIMARY KEY (`TransferID`, `product_ProductID`, `warehouse_WarehouseID`, `warehouse_location_LocationID`),
  INDEX `fk_transfer_product1_idx` (`product_ProductID` ASC) VISIBLE,
  INDEX `fk_transfer_warehouse1_idx` (`warehouse_WarehouseID` ASC, `warehouse_location_LocationID` ASC) VISIBLE,
  CONSTRAINT `fk_transfer_product1`
    FOREIGN KEY (`product_ProductID`)
    REFERENCES `inventory_managment_system`.`product` (`ProductID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_transfer_warehouse1`
    FOREIGN KEY (`warehouse_WarehouseID` , `warehouse_location_LocationID`)
    REFERENCES `inventory_managment_system`.`warehouse` (`WarehouseID` , `location_LocationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
