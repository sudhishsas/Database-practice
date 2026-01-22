#Sudhish Sepaul 620136630
DROP DATABASE CustomerData;
CREATE DATABASE CustomerData;

USE CustomerData;

CREATE TABLE `customer` (
    `cid` VARCHAR(4) NOT NULL,
    `cname` VARCHAR(255) NOT NULL ,
    `street` VARCHAR(255) NOT NULL ,
    `city` VARCHAR(50) NOT NULL ,
    `country` VARCHAR(50) NOT NULL ,
    `phone` VARCHAR(50) NOT NULL ,
    PRIMARY KEY  (`cid`)
);
INSERT INTO `customer` (cid, cname, street, city, country, phone) VALUES 
('C223', 'COMPAQ', '3 Barbados Ave', 'Bridgetown', 'Barbados', '809-956-2345'),
('C224', 'IBM', '14 Ruthven Rd', 'Kingston', 'Jamaica', '876-927-2654'),
('C225', 'IBM', '24 Hart St', 'Port-au-Prince', 'Trinidad', '309-913-2345'),
('C226', 'GATEWAY', '30 Austin Ave', 'Kingston', 'Jamaica', '876-956-2458'),
('C227', 'IBM', '5 Seville Rd', 'Bridgetown', 'Barbados', '809-756-1345'),
('C228', 'GATEWAY', '3 Kings Way', 'Port-au-Prince', 'Trinidad', '309-756-2375');

SELECT * FROM `customer`;

CREATE TABLE `custorder` (
	`oid` VARCHAR(4) NOT NULL, 
    `cid` VARCHAR(4) NOT NULL,
    `orderdate` DATE ,
    `shippingdate` DATE ,
    PRIMARY KEY (oid)) ;

INSERT INTO `custorder` (oid, cid, orderdate, shippingdate) VALUES
('O010', 'C223', DATE('2020-09-24'), DATE('2020-09-26')),
('O011', 'C227', DATE('2020-09-15'), DATE('2020-09-20')),
('O012', 'C224', DATE('2021-01-16'), NULL),
('O013', 'C225', DATE('2020-07-15'), DATE('2020-07-20')),
('O014', 'C224', DATE('2021-02-16'), NULL);     
    
SELECT * FROM `custorder`;

CREATE TABLE `itemorder` (
	`oid` VARCHAR(4), 
    `iid` VARCHAR(4),
    `quantity` CHAR(6) ,
    `totalprice` VARCHAR(18),
    PRIMARY KEY(oid,iid));

INSERT INTO `itemorder` (oid, iid, quantity, totalprice) VALUES  
('O010', 'i110', '10', '600000.00'),
('O010', 'i111', '5', '300000.00'),
('O011', 'i110', '8', '540000.00'),
('O012', 'i113', '20', '1000000.00'),
('O012', 'i111', '6', '360000.00'),
('O012', 'i114', '6', '600000.00'),
('O013', 'i114', '9', '800000.00');
  
SELECT * FROM `itemorder`;

#a
SELECT * FROM `customer` WHERE (cid) NOT IN (SELECT cid FROM `custorder`) ;

#b
SELECT * FROM `customer` WHERE customer.country = 'Trinidad' OR customer.country = 'Barbados';

#c
CREATE VIEW Tot_Per_Order AS SELECT itemorder.oid, itemorder.totalprice FROM `itemorder` GROUP BY itemorder.oid;

#d 
SELECT customer.cname, customer.street, customer.city, customer.country FROM `customer` NATURAL JOIN `custorder` WHERE YEAR(custorder.orderdate)='2020' ORDER BY customer.cname ASC;

#e
CREATE VIEW ordercheck AS SELECT itemorder.oid FROM `itemorder` WHERE itemorder.iid='i110';
CREATE VIEW findcid AS SELECT custorder.cid FROM `ordercheck` NATURAL JOIN `custorder` WHERE custorder.oid = ordercheck.oid;
SELECT customer.cname FROM `customer` NATURAL JOIN `findcid` WHERE customer.cid = findcid.cid;

#f
SELECT itemorder.iid, itemorder.quantity, itemorder.totalprice, (itemorder.totalprice/itemorder.quantity) AS priceperunit FROM `itemorder` ORDER BY priceperunit ASC;

#g
SELECT itemorder.oid, SUM(totalprice) AS totalorderprice FROM `itemorder` INNER JOIN `custorder` USING (oid) GROUP BY itemorder.oid ORDER BY totalorderprice DESC LIMIT 0,1 ;

#h
SELECT itemorder.oid, itemorder.totalprice FROM `itemorder` WHERE itemorder.totalprice > (SELECT AVG(itemorder.totalprice) FROM `itemorder`);

#i
UPDATE `itemorder` SET itemorder.quantity = (itemorder.quantity*2) , itemorder.totalprice = ROUND((SELECT (itemorder.totalprice/itemorder.quantity) AS priceperunit WHERE iid = 'i111' AND oid = 'O012' ORDER BY priceperunit )*(itemorder.quantity*2),2) WHERE iid = 'i111' AND oid = 'O012';
SELECT * FROM `itemorder`;

#j
CREATE VIEW barbcid AS SELECT customer.cid FROM `customer` WHERE customer.country = 'Barbados';
UPDATE `custorder` NATURAL JOIN `barbcid` SET custorder.shippingdate = DATE_ADD(custorder.shippingdate, INTERVAL 5 DAY) WHERE custorder.shippingdate = (SELECT custorder.shippingdate WHERE barbcid.cid =  custorder.cid);
SELECT * FROM `custorder`;