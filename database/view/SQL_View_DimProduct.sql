CREATE VIEW dbo.vw_DimProduct
AS
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.Color AS ProductColor,
    p.Class AS ProductClass,
    p.Style AS ProductStyle,
    p.ProductLine,
    p.Size AS ProductSize,
    p.SizeUnitMeasureCode,
    p.Weight,
    p.WeightUnitMeasureCode,
    p.StandardCost,
    p.ListPrice,
    p.DaysToManufacture,
    p.ReorderPoint,
    p.SafetyStockLevel,
    p.MakeFlag,
    p.FinishedGoodsFlag,
    p.SellStartDate,
    p.SellEndDate,
    p.DiscontinuedDate,
    ps.ProductSubcategoryID,
    ps.Name AS ProductSubcategoryName,
    pc.ProductCategoryID,
    pc.Name AS ProductCategoryName,
    pm.ProductModelID,
    pm.Name AS ModelName

FROM Production.Product p
LEFT JOIN Production.ProductSubcategory ps
    ON p.ProductSubcategoryID = ps.ProductSubcategoryID
LEFT JOIN Production.ProductCategory pc
    ON ps.ProductCategoryID = pc.ProductCategoryID
LEFT JOIN Production.ProductModel pm
    ON p.ProductModelID = pm.ProductModelID;
