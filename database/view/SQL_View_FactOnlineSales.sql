
CREATE VIEW [dbo].[vw_FactOnlineSales]
AS
SELECT 
    soh.OrderDate,
    soh.DueDate,
    soh.Freight,
    soh.PurchaseOrderNumber,
    soh.RevisionNumber,
    soh.SalesOrderNumber,
    soh.ShipDate,
    soh.SubTotal,
    soh.TaxAmt,
  soh.TerritoryID,
  soh.CustomerID,
    scr.CurrencyRateDate,
    scr.AverageRate,
    scr.EndOfDayRate,
  scr.ToCurrencyCode,
    sod.CarrierTrackingNumber,
    sod.OrderQty,
    sod.SalesOrderDetailID,
    sod.UnitPriceDiscount,
  sod.ProductID,
  sod.SpecialOfferID
FROM [Sales].[SalesOrderHeader] AS soh
INNER JOIN [Sales].[SalesOrderDetail] AS sod
    ON soh.SalesOrderID = sod.SalesOrderID
LEFT JOIN [Sales].[CurrencyRate] AS scr
    ON soh.CurrencyRateID = scr.CurrencyRateID
WHERE soh.OnlineOrderFlag = 1;
GO


