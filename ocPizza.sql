-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: fdb31.biz.nf
-- Generation Time: Oct 27, 2022 at 01:07 PM
-- Server version: 5.7.20-log
-- PHP Version: 8.1.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oc_pizza`
--

-- --------------------------------------------------------

--
-- Table structure for table `Account`
--

CREATE TABLE `Account` (
  `idAccount` int(11) NOT NULL,
  `userName` varchar(20) NOT NULL,
  `passWord` varchar(100) NOT NULL,
  `login` bit(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Address`
--

CREATE TABLE `Address` (
  `idAddress` int(11) NOT NULL,
  `address1` varchar(100) NOT NULL,
  `address2` varchar(100) NOT NULL,
  `address3` varchar(100) NOT NULL,
  `city` varchar(100) NOT NULL,
  `postalCode` varchar(5) NOT NULL,
  `additionAddress` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Categories`
--

CREATE TABLE `Categories` (
  `idCategories` int(11) NOT NULL,
  `idPizza` int(11) DEFAULT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `categories` varchar(100) DEFAULT NULL,
  `productName` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Client`
--

CREATE TABLE `Client` (
  `idClient` int(11) NOT NULL,
  `idAccount` int(11) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `DetailOrder`
--

CREATE TABLE `DetailOrder` (
  `idDetail` int(11) NOT NULL,
  `idSalesOrder` int(11) DEFAULT NULL,
  `idProduct` int(11) DEFAULT NULL,
  `idPizza` int(11) DEFAULT NULL,
  `idPayment` int(11) DEFAULT NULL,
  `quantity` int(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Employee`
--

CREATE TABLE `Employee` (
  `idEmployee` int(11) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `idAccount` int(11) NOT NULL,
  `firstName` varchar(100) NOT NULL,
  `lastName` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `typeProfil` enum('Delivery man','Chef','Manager','ResponsablePointofSale') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `idPayment` int(11) NOT NULL,
  `amount` float NOT NULL,
  `paymentType` enum('Cash','Online','Credit Card','Apps') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Pizza`
--

CREATE TABLE `Pizza` (
  `idPizza` int(11) NOT NULL,
  `receipts` varchar(500) DEFAULT NULL,
  `idRawMaterial` int(11) DEFAULT NULL,
  `idCategories` int(11) NOT NULL,
  `urlPicture` varbinary(100) NOT NULL,
  `sellingPrice` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `PointOfSale`
--

CREATE TABLE `PointOfSale` (
  `idPointOfSale` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `idResponsable` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Product`
--

CREATE TABLE `Product` (
  `idProduct` int(11) NOT NULL,
  `idCategories` int(11) NOT NULL,
  `productName` varchar(100) NOT NULL,
  `purchasingPrice` float NOT NULL,
  `sellingPrice` float NOT NULL,
  `stockIn` int(100) NOT NULL,
  `stockOut` int(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `RawMaterial`
--

CREATE TABLE `RawMaterial` (
  `idRawMaterial` int(11) NOT NULL,
  `idSupplier` int(11) DEFAULT NULL,
  `idStock` int(11) DEFAULT NULL,
  `idPizza` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `stockIn` int(100) DEFAULT NULL,
  `stockOut` int(100) DEFAULT NULL,
  `unitPrice` float DEFAULT NULL,
  `Unit` enum('Kg','U','L') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `SalesOrder`
--

CREATE TABLE `SalesOrder` (
  `idSalesOrder` int(11) NOT NULL,
  `idClient` int(11) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `idDetailOrder` int(11) NOT NULL,
  `dateSales` datetime NOT NULL,
  `deliveryTime` time NOT NULL,
  `status` enum('Confirmmed','In preparation','Out for delivry','Delivred') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Stock`
--

CREATE TABLE `Stock` (
  `idStock` int(11) NOT NULL,
  `idRawMaterial` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `reelQuantityStock` int(11) NOT NULL,
  `safetyStock` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Supplier`
--

CREATE TABLE `Supplier` (
  `idSupplier` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `email` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Account`
--
ALTER TABLE `Account`
  ADD PRIMARY KEY (`idAccount`);

--
-- Indexes for table `Address`
--
ALTER TABLE `Address`
  ADD PRIMARY KEY (`idAddress`);

--
-- Indexes for table `Categories`
--
ALTER TABLE `Categories`
  ADD PRIMARY KEY (`idCategories`),
  ADD KEY `FK_CategoriesPizza` (`idPizza`),
  ADD KEY `FK_CategoriesProduct` (`idProduct`);

--
-- Indexes for table `Client`
--
ALTER TABLE `Client`
  ADD PRIMARY KEY (`idClient`),
  ADD KEY `FK_ClientAccount` (`idAccount`) USING BTREE,
  ADD KEY `FK_ClientAddress` (`idAddress`) USING BTREE;

--
-- Indexes for table `DetailOrder`
--
ALTER TABLE `DetailOrder`
  ADD PRIMARY KEY (`idDetail`),
  ADD KEY `FK_DetailOrderSalesOrder` (`idSalesOrder`),
  ADD KEY `FK_DetailOrderPizza` (`idPizza`),
  ADD KEY `FK_DetailOrderProduct` (`idProduct`),
  ADD KEY `FK_DetailOrderPayment` (`idPayment`);

--
-- Indexes for table `Employee`
--
ALTER TABLE `Employee`
  ADD PRIMARY KEY (`idEmployee`),
  ADD KEY `FK_EmployeeAddress` (`idAddress`),
  ADD KEY `FK_EmployeeAccount` (`idAccount`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`idPayment`);

--
-- Indexes for table `Pizza`
--
ALTER TABLE `Pizza`
  ADD PRIMARY KEY (`idPizza`),
  ADD KEY `FK_PizzaRawMaterial` (`idRawMaterial`) USING BTREE,
  ADD KEY `FK_PizzaCategories` (`idCategories`);

--
-- Indexes for table `PointOfSale`
--
ALTER TABLE `PointOfSale`
  ADD PRIMARY KEY (`idPointOfSale`),
  ADD KEY `FK_PointOfSaleEmployee` (`idResponsable`);

--
-- Indexes for table `Product`
--
ALTER TABLE `Product`
  ADD PRIMARY KEY (`idProduct`),
  ADD KEY `FK_ProductCategories` (`idCategories`);

--
-- Indexes for table `RawMaterial`
--
ALTER TABLE `RawMaterial`
  ADD PRIMARY KEY (`idRawMaterial`),
  ADD KEY `FK_RawMaterialSupplier` (`idSupplier`),
  ADD KEY `FK_RawMaterialStock` (`idStock`),
  ADD KEY `FK_RawMaterialPizza` (`idPizza`);

--
-- Indexes for table `SalesOrder`
--
ALTER TABLE `SalesOrder`
  ADD PRIMARY KEY (`idSalesOrder`),
  ADD KEY `FK_SalesOrderDetailOrder` (`idDetailOrder`),
  ADD KEY `FK_SalesOrderAddress` (`idAddress`),
  ADD KEY `FK_SalesOrderClient` (`idClient`);

--
-- Indexes for table `Stock`
--
ALTER TABLE `Stock`
  ADD PRIMARY KEY (`idStock`),
  ADD KEY `FK_StockProduct` (`idProduct`),
  ADD KEY `FK_StockRawMaterial` (`idRawMaterial`);

--
-- Indexes for table `Supplier`
--
ALTER TABLE `Supplier`
  ADD PRIMARY KEY (`idSupplier`),
  ADD KEY `FK_SupplierAddress` (`idAddress`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Account`
--
ALTER TABLE `Account`
  MODIFY `idAccount` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Address`
--
ALTER TABLE `Address`
  MODIFY `idAddress` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Categories`
--
ALTER TABLE `Categories`
  MODIFY `idCategories` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Client`
--
ALTER TABLE `Client`
  MODIFY `idClient` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `DetailOrder`
--
ALTER TABLE `DetailOrder`
  MODIFY `idDetail` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Employee`
--
ALTER TABLE `Employee`
  MODIFY `idEmployee` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `idPayment` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Pizza`
--
ALTER TABLE `Pizza`
  MODIFY `idPizza` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `PointOfSale`
--
ALTER TABLE `PointOfSale`
  MODIFY `idPointOfSale` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Product`
--
ALTER TABLE `Product`
  MODIFY `idProduct` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `RawMaterial`
--
ALTER TABLE `RawMaterial`
  MODIFY `idRawMaterial` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `SalesOrder`
--
ALTER TABLE `SalesOrder`
  MODIFY `idSalesOrder` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Stock`
--
ALTER TABLE `Stock`
  MODIFY `idStock` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `Supplier`
--
ALTER TABLE `Supplier`
  MODIFY `idSupplier` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Categories`
--
ALTER TABLE `Categories`
  ADD CONSTRAINT `FK_CategoriesPizza` FOREIGN KEY (`idPizza`) REFERENCES `Pizza` (`idPizza`),
  ADD CONSTRAINT `FK_CategoriesProduct` FOREIGN KEY (`idProduct`) REFERENCES `Product` (`idProduct`);

--
-- Constraints for table `Client`
--
ALTER TABLE `Client`
  ADD CONSTRAINT `FK_ClientAddress` FOREIGN KEY (`idAddress`) REFERENCES `Address` (`idAddress`),
  ADD CONSTRAINT `FK_ClientCompte` FOREIGN KEY (`idAccount`) REFERENCES `Account` (`idAccount`);

--
-- Constraints for table `DetailOrder`
--
ALTER TABLE `DetailOrder`
  ADD CONSTRAINT `FK_DetailOrderPayment` FOREIGN KEY (`idPayment`) REFERENCES `Payment` (`idPayment`),
  ADD CONSTRAINT `FK_DetailOrderPizza` FOREIGN KEY (`idPizza`) REFERENCES `Pizza` (`idPizza`),
  ADD CONSTRAINT `FK_DetailOrderProduct` FOREIGN KEY (`idProduct`) REFERENCES `Product` (`idProduct`),
  ADD CONSTRAINT `FK_DetailOrderSalesOrder` FOREIGN KEY (`idSalesOrder`) REFERENCES `SalesOrder` (`idSalesOrder`);

--
-- Constraints for table `Employee`
--
ALTER TABLE `Employee`
  ADD CONSTRAINT `FK_EmployeeAccount` FOREIGN KEY (`idAccount`) REFERENCES `Account` (`idAccount`),
  ADD CONSTRAINT `FK_EmployeeAddress` FOREIGN KEY (`idAddress`) REFERENCES `Address` (`idAddress`);

--
-- Constraints for table `Pizza`
--
ALTER TABLE `Pizza`
  ADD CONSTRAINT `FK_PizzaCategories` FOREIGN KEY (`idCategories`) REFERENCES `Categories` (`idCategories`),
  ADD CONSTRAINT `FK_PizzaProduct` FOREIGN KEY (`idRawMaterial`) REFERENCES `Product` (`idProduct`);

--
-- Constraints for table `PointOfSale`
--
ALTER TABLE `PointOfSale`
  ADD CONSTRAINT `FK_PointOfSaleEmployee` FOREIGN KEY (`idResponsable`) REFERENCES `Employee` (`idEmployee`);

--
-- Constraints for table `Product`
--
ALTER TABLE `Product`
  ADD CONSTRAINT `FK_ProductCategories` FOREIGN KEY (`idCategories`) REFERENCES `Categories` (`idCategories`);

--
-- Constraints for table `RawMaterial`
--
ALTER TABLE `RawMaterial`
  ADD CONSTRAINT `FK_RawMaterialPizza` FOREIGN KEY (`idPizza`) REFERENCES `Pizza` (`idPizza`),
  ADD CONSTRAINT `FK_RawMaterialStock` FOREIGN KEY (`idStock`) REFERENCES `Stock` (`idStock`),
  ADD CONSTRAINT `FK_RawMaterialSupplier` FOREIGN KEY (`idSupplier`) REFERENCES `Supplier` (`idSupplier`);

--
-- Constraints for table `SalesOrder`
--
ALTER TABLE `SalesOrder`
  ADD CONSTRAINT `FK_SalesOrderAddress` FOREIGN KEY (`idAddress`) REFERENCES `Address` (`idAddress`),
  ADD CONSTRAINT `FK_SalesOrderClient` FOREIGN KEY (`idClient`) REFERENCES `Client` (`idClient`),
  ADD CONSTRAINT `FK_SalesOrderDetailOrder` FOREIGN KEY (`idDetailOrder`) REFERENCES `DetailOrder` (`idDetail`);

--
-- Constraints for table `Stock`
--
ALTER TABLE `Stock`
  ADD CONSTRAINT `FK_StockProduct` FOREIGN KEY (`idProduct`) REFERENCES `Product` (`idProduct`),
  ADD CONSTRAINT `FK_StockRawMaterial` FOREIGN KEY (`idRawMaterial`) REFERENCES `RawMaterial` (`idRawMaterial`);

--
-- Constraints for table `Supplier`
--
ALTER TABLE `Supplier`
  ADD CONSTRAINT `FK_SupplierAddress` FOREIGN KEY (`idAddress`) REFERENCES `Address` (`idAddress`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
