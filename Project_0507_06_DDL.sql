--use BUDT703_Project_0507_06
use BUDT703_Project_0507_06;


DROP TABLE IF EXISTS[Insight.Review];
DROP TABLE IF EXISTS[Insight.Register];
DROP TABLE IF EXISTS[Insight.Order];
DROP TABLE IF EXISTS[Insight.Customer];
DROP TABLE IF EXISTS[Insight.Platform];
DROP TABLE IF EXISTS[Insight.RestaurantSeriviceOption];
DROP TABLE IF EXISTS[Insight.RestaurantCategory];
DROP TABLE IF EXISTS[Insight.Restaurant];

CREATE TABLE [Insight.Restaurant] (
	resId CHAR (9) NOT NULL,
	resStreet VARCHAR (50),
	resCity VARCHAR (50),
	resState VARCHAR (50),
	resZipCode CHAR (9),
	resStarRate DECIMAL (2,1),
	resWebsite VARCHAR (256),
	resPhone CHAR (15),
	MondayOperatingHours varchar(50),
	TuesdayOperatingHours varchar(50),
	WednesdayOperatingHours varchar(50),
	ThursdayOperatingHours varchar(50),
	FirdayOperatingHours varchar(50),
	SaturdayOperatingHours varchar(50),
	SundayOperatingHours varchar(50),
	CONSTRAINT pk_Restaurant_resId PRIMARY KEY (resId) )



CREATE TABLE [Insight.RestaurantCategory] (
	resId CHAR (9) NOT NULL,
	recCategories VARCHAR (150),
	CONSTRAINT pk_RestaurantCategoryresId_recCategories PRIMARY KEY (resId, recCategories),
	CONSTRAINT fk_ResCat_resId FOREIGN KEY (resId)
		REFERENCES [Insight.Restaurant] (resId)
		ON DELETE CASCADE ON UPDATE CASCADE )

CREATE TABLE [Insight.RestaurantSeriviceOption] (
	resId CHAR (9) NOT NULL,
	rsoResServiceOptions VARCHAR (50),
	CONSTRAINT pk_RestaurantSeriviceOption_resId_rsoResServiceOptions PRIMARY KEY (resId, rsoResServiceOptions),
	CONSTRAINT fk_ResService_resId FOREIGN KEY (resId)
		REFERENCES [Insight.Restaurant] (resId)
		ON DELETE CASCADE ON UPDATE CASCADE )

CREATE TABLE [Insight.Platform] (
	pltId CHAR (3) NOT NULL,
	pltName VARCHAR (15),
	pltWeb VARCHAR (100),
	CONSTRAINT pk_Platform_pltId PRIMARY KEY (pltId) )


CREATE TABLE [Insight.Customer] (
	cusId CHAR (9) NOT NULL,
	cusName VARCHAR (40),
	cusReviewNumber VARCHAR (250),
	pltId CHAR (3),
	CONSTRAINT pk_Customer_cusId PRIMARY KEY (cusId),
	CONSTRAINT fk_Customer_pltId FOREIGN KEY (pltId)
		REFERENCES [Insight.Platform] (pltId)
		ON DELETE CASCADE ON UPDATE NO ACTION )

CREATE TABLE [Insight.Order] (
	resId CHAR (9) NOT NULL,
	cusId CHAR (9) NOT NULL,
	CONSTRAINT pk_Order_resId_cusId PRIMARY KEY (resId, cusId),
	CONSTRAINT fk_Order_resId FOREIGN KEY (resId)
		REFERENCES [Insight.Restaurant] (resId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Order_cusId FOREIGN KEY (cusId)
		REFERENCES [Insight.Customer] (cusId)
		ON DELETE NO ACTION ON UPDATE NO ACTION )

CREATE TABLE [Insight.Register] (
	resId CHAR (9) NOT NULL,
	pltId CHAR (3) NOT NULL,
	CONSTRAINT pk_Register_resId_pltId PRIMARY KEY (resId, pltId),
	CONSTRAINT fk_Register_resId FOREIGN KEY (resId)
		REFERENCES [Insight.Restaurant] (resId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Register_pltId FOREIGN KEY (pltId)
		REFERENCES [Insight.Platform] (pltId)
		ON DELETE NO ACTION ON UPDATE NO ACTION )

CREATE TABLE [Insight.Review](
	revId char(9) not null,
	cusId char(9),
	revSarRate DECIMAL (2,1),
	revContent NVARCHAR(500),
	resId CHAR (9),
	pltId CHAR (3),
	CONSTRAINT pk_Review_revId PRIMARY KEY (revId),
	CONSTRAINT fk_Review_resId FOREIGN KEY (resId)
		REFERENCES [Insight.Restaurant] (resId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Review_cusId FOREIGN KEY (cusId)
		REFERENCES [Insight.Customer] (cusId)
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	CONSTRAINT fk_Review_pltId FOREIGN KEY (pltId)
		REFERENCES [Insight.Platform] (pltId)
		ON DELETE NO ACTION ON UPDATE NO ACTION
		
		)

