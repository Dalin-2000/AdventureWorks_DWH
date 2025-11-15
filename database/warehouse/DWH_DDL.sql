
DROP TABLE IF EXISTS FactOnlineSales
GO
CREATE TABLE FactOnlineSales(
 Load_Date          DATETIME
, CarrierTrackingNumber    NVARCHAR(25)
, OrderQuantity        SMALLINT
, ProductSK            INT
, CustomerSK          INT
, SalesOrderLineNumber      INT
, PromotionSK          INT
, DiscountAmount        MONEY
, CurrencySK          INT
, DueDate            DATETIME
, Freight            MONEY
, OrderDate            DATETIME
, PurchaseOrderNumber    NVARCHAR(25)
,RevisionNumber        NVARCHAR(25)
, SalesOrderNumber      NVARCHAR(25)
, ShipDate            DATETIME
, SalesAmount          MONEY
, TaxAmt              MONEY
, ProductID              INT NOT NULL
,PromotionID           INT NOT NULL
, CustomerID      INT NOT NULL
,SalesTerritoryID        INT NOT NULL
,CurrencyCode      NCHAR(3)    
,CurrencyRateDate     DATETIME          -- or DATETIME if time is needed
,AverageRate          DECIMAL(18, 6) -- precise decimal for currency rates
,EndOfDayRate         DECIMAL(18, 6)  -- same precision for consistency
, SalesTerritorySK      INT
 -- Date surrogate keys (new columns)
   , OrderDateKey            INT       -- e.g. 20250101
   , ShipDateKey             INT
   , DueDateKey              INT
);


DROP TABLE IF EXISTS FactStoreSales
GO
CREATE TABLE FactStoreSales
(
 Load_Date          DATETIME
, ProductSK						INT
, StoreSK						INT
, CustomerSK						INT
, CurrencySK					INT
, PromotionSK					INT
, SalesTerritorySK			INT
, CarrierTrackingNumber		NVARCHAR(25)
, OrderQuantity				SMALLINT
, SalesOrderLineID			INT
, DiscountAmount				MONEY
, DueDate						DATETIME
, Freight						MONEY
, OrderDate						DATETIME
, PurchaseOrderNumber		NVARCHAR(25)
, SalesOrderNumber			NVARCHAR(25)
, SalesPersonID				INT
, CustomerID				INT
, ProductID              INT NOT NULL
,PromotionID           INT NOT NULL
,SalesTerritoryID        INT NOT NULL
,CurrencyCode      NCHAR(3)  
, ShipDate						DATETIME
, SalesAmount					MONEY
, TaxAmt							MONEY
 -- Date surrogate keys (new columns)
   , OrderDateKey            INT       -- e.g. 20250101
   , ShipDateKey             INT
   , DueDateKey              INT
);


DROP TABLE IF EXISTS DimStore;
GO

CREATE TABLE DimStore
(
    StoreSK             INT IDENTITY(1,1) PRIMARY KEY,
    StoreAK             INT NOT NULL,                   
    AnnualRevenue       DECIMAL(19,4),
    AnnualSales         DECIMAL(19,4),
    BankName            NVARCHAR(50),
    Brands              NVARCHAR(30),
    BusinessType        NVARCHAR(5),
    Internet            NVARCHAR(30),
    BusinessName        NVARCHAR(50),
    NumberEmployees     INT,
    SalesPersonID       INT,
    Specialty           NVARCHAR(50),
    SquareFeet          INT,
    YearOpened          INT,
    EFT_START_DATE      DATE,
    EFT_END_DATE        DATE,
    IS_CURRENT          CHAR(1)
);



DROP TABLE IF EXISTS DimSalesTerritory
GO
CREATE TABLE DimSalesTerritory
(
  SalesTerritorySK			INT				IDENTITY(1,1) PRIMARY KEY
, CountryRegionCode		    NVARCHAR(3)
, SalesTerritoryGroup	    NVARCHAR(50)
, SalesTerritoryName		NVARCHAR(50)
, SalesTerritoryID		    INT
, SalesYTD					MONEY
, SalesLastYear			    MONEY
, CostYTD					MONEY
, CostLastYear				MONEY
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)

DROP TABLE IF EXISTS DimPromotion
GO
CREATE TABLE DimPromotion
(PromotionSK				INT	 IDENTITY(1,1)			PRIMARY KEY
, PromotionCategory		NVARCHAR(50)
, PromotionName			NVARCHAR(255)
, PromotionDiscountPct	SMALLMONEY
, PromotionEndDate		DATETIME
, PromotionMaxQty			INT
, PromotionMinQty			INT
, PromotionStartDate		DATETIME
, PromotionType			NVARCHAR(50)
, PromotionID				INT 
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)


DROP TABLE IF EXISTS DimCurrency
GO
CREATE TABLE DimCurrency
(
CurrencySK				INT IDENTITY(1,1) PRIMARY KEY
,CurrencyCode			NCHAR(3)		NOT NULL
,CurrencyName			NVARCHAR(100)		NOT NULL
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
) 

DROP TABLE IF EXISTS DimProduct;
GO

CREATE TABLE DimProduct
(
    ProductSK               INT IDENTITY(1,1) PRIMARY KEY, 
    ProductID               INT,    
    ProductName             NVARCHAR(50),
    ProductNumber           NVARCHAR(25),
    ProductColor            NVARCHAR(15),
    ProductClass            NCHAR(2),
    ProductLine             NCHAR(2),
    ProductStyle            NCHAR(2),
    ProductSize             NVARCHAR(5),
    SizeUnitMeasureCode     NCHAR(3),
    WeightUnitMeasureCode   NCHAR(3),
    ProductWeight           DECIMAL(8,2),
    ProductModelID          INT,
    ModelName               NVARCHAR(50),
    ProductSubcategoryID    INT,
    ProductSubcategoryName  NVARCHAR(50),
    ProductCategoryID       INT,
    ProductCategoryName     NVARCHAR(50),
    DaysToManufacture       INT,
    MakeFlag                BIT,
    FinishedGoodsFlag       BIT,
    SafetyStockLevel        SMALLINT,
    ReorderPoint            SMALLINT,
    StandardCost            MONEY,
    ListPrice               MONEY,
    SellStartDate           DATETIME,
    SellEndDate             DATETIME,
    DiscontinuedDate        DATETIME,
    CreationDate            DATETIME,
    ModificationDate        DATETIME,
    EFT_START_DATE		    DATE,
    EFT_END_DATE			DATE,
    IS_CURRENT			CHAR(1)
);



DROP TABLE IF EXISTS DimDate
GO
CREATE TABLE DimDate (
    DateKey              INT          NOT NULL PRIMARY KEY, 
    FullDate             DATE         NOT NULL,
    DayNumberOfWeek      INT          NOT NULL,            
    DayNameOfWeek        NVARCHAR(10) NOT NULL,           
    DayNameOfWeekAbbr    NCHAR(3)     NOT NULL,              
    DayNumberOfMonth     INT          NOT NULL,              
    DayNumberOfYear      INT          NOT NULL,              
    WeekNumberOfYear     INT          NOT NULL,               
    MonthName            NVARCHAR(10) NOT NULL,              
    MonthNameAbbr        NCHAR(3)     NOT NULL,         
    MonthNumberOfYear    INT          NOT NULL,             
    CalendarQuarter      INT          NOT NULL,         
    CalendarYear         INT          NOT NULL,
    EFT_START_DATE		 DATE,
    EFT_END_DATE		 DATE,
    IS_CURRENT			CHAR(1)
);
GO

DROP TABLE IF EXISTS DimCustomer
GO
CREATE TABLE DimCustomer
(
 BirthDate					DATE
, DateFirstPurchase		DATE
, Education					NVARCHAR(30)
, Gender						NVARCHAR(1)
, HomeOwnerFlag			INT
, MaritalStatus			NVARCHAR(1)
, NumberCarsOwned			INT
, NumberChildrenAtHome	INT
, Occupation				NVARCHAR(30)
, TotalChildren			INT
, YearlyIncome				NVARCHAR(30)
, TotalPurchaseYTD		MONEY
, EmailAddress				NVARCHAR(50)
, CustomerSK				INT					IDENTITY(1,1) PRIMARY KEY
, FirstName					NVARCHAR(50)
, LastName					NVARCHAR(50)
, MiddleName				NVARCHAR(50)
, NameStyle					BIT
, Suffix						NVARCHAR(10)
, Title						NVARCHAR(8)
, Phone						NVARCHAR(25)
, TerritoryID				INT
, StoreID					INT
, CustomerID				INT
, EFT_START_DATE		DATE
, EFT_END_DATE			DATE
, IS_CURRENT			CHAR(1)
)