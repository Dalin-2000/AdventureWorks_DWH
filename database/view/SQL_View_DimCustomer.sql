CREATE VIEW [dbo].[vw_DimCustomer]
AS
SELECT 
    c.CustomerID,
    c.StoreID,
    c.TerritoryID,
    pp.PhoneNumber AS Phone,
    p.Title,
    p.Suffix,
    p.NameStyle,
    p.FirstName,
    p.MiddleName,
    p.LastName,
    eam.EmailAddress,
    pd.BirthDate,
    pd.DateFirstPurchase,
    pd.Education,
    pd.Gender,
    pd.HomeOwnerFlag,
    pd.MaritalStatus,
    pd.NumberCarsOwned,
    pd.NumberChildrenAtHome,
    pd.Occupation,
    pd.TotalChildren,
    pd.YearlyIncome,
    pd.TotalPurchaseYTD
FROM Sales.Customer AS c
LEFT JOIN Person.Person AS p
    ON c.PersonID = p.BusinessEntityID
LEFT JOIN Person.PersonPhone AS pp
    ON p.BusinessEntityID = pp.BusinessEntityID
LEFT JOIN Person.EmailAddress AS eam
    ON p.BusinessEntityID = eam.BusinessEntityID
LEFT JOIN Sales.vPersonDemographics AS pd
    ON p.BusinessEntityID = pd.BusinessEntityID;
GO
