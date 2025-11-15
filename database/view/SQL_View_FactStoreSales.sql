DROP VIEW IF EXISTS dbo.vw_FactStoreSales;
GO

CREATE VIEW dbo.vw_FactStoreSales
AS
SELECT 
    CAST(soh.OrderDate AS DATE) AS OrderDate,    
    CAST(soh.DueDate   AS DATE) AS DueDate,     
    CAST(soh.ShipDate  AS DATE) AS ShipDate,  
    CAST(soh.RevisionNumber AS INT) AS RevisionNumber,
    soh.Freight,
    soh.PurchaseOrderNumber,
    soh.SalesOrderNumber,
    soh.SalesPersonID,
    soh.SubTotal,
    soh.TaxAmt,
    soh.TerritoryID,
    scr.CurrencyRateDate,
    scr.AverageRate,
    scr.EndOfDayRate,
    scr.ToCurrencyCode,
    sod.CarrierTrackingNumber,
    sod.OrderQty,
    sod.SalesOrderDetailID,
    sod.UnitPriceDiscount,
    sod.ProductID,
    sod.SpecialOfferID,
    soh.CustomerID,
    sc.StoreID As StoreAK  
FROM [Sales].[SalesOrderHeader] AS soh
INNER JOIN [Sales].[SalesOrderDetail] AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN [Sales].[CurrencyRate] AS scr
    ON soh.CurrencyRateID = scr.CurrencyRateID
LEFT JOIN Sales.Customer sc
ON soh.CustomerID = sc.CustomerID 
WHERE soh.OnlineOrderFlag = 0;
GO