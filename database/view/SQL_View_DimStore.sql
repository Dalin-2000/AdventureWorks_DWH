CREATE VIEW dbo.vw_DimStore AS
SELECT 
    s.BusinessEntityID AS StoreAK,
    s.Name AS BusinessName,
    s.SalesPersonID,
    d.AnnualRevenue,
    d.AnnualSales,
    d.BankName,
    d.Brands,
    d.BusinessType,
    d.Internet,
    d.NumberEmployees,
    d.Specialty,
    d.SquareFeet,
    d.YearOpened
FROM Sales.Store s
LEFT JOIN Sales.vStoreWithDemographics d
    ON s.BusinessEntityID = d.BusinessEntityID;
GO
