

CREATE OR ALTER PROCEDURE dbo.usp_PopulateDimDateAuto
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @StartDate DATE,
        @EndDate DATE,
        @CurrentDate DATE;

    --  Get min and max dates from AdventureWorks2019
    SELECT 
        @StartDate = MIN(OrderDate),
        @EndDate = MAX(DueDate)
    FROM AdventureWorks2022.Sales.SalesOrderHeader;

    -- Safety check if dates are null
    IF @StartDate IS NULL OR @EndDate IS NULL
    BEGIN
        RAISERROR('No date range found in SalesOrderHeader.', 16, 1);
        RETURN;
    END

    SET @CurrentDate = @StartDate;

    PRINT 'Populating DimDate from ' + CONVERT(VARCHAR(10), @StartDate, 120) + 
          ' to ' + CONVERT(VARCHAR(10), @EndDate, 120);

    -- Optional: Clear existing data
    TRUNCATE TABLE dbo.DimDate;

    -- Loop through each date
    WHILE @CurrentDate <= @EndDate
    BEGIN
        INSERT INTO dbo.DimDate (
            DateKey,
            FullDate,
            DayNumberOfWeek,
            DayNameOfWeek,
            DayNameOfWeekAbbr,
            DayNumberOfMonth,
            DayNumberOfYear,
            WeekNumberOfYear,
            MonthName,
            MonthNameAbbr,
            MonthNumberOfYear,
            CalendarQuarter,
            CalendarYear,
            CreationDate,
            ModificationDate
        )
        SELECT
            CONVERT(INT, FORMAT(@CurrentDate, 'yyyyMMdd')) AS DateKey,
            @CurrentDate AS FullDate,
            DATEPART(WEEKDAY, @CurrentDate) AS DayNumberOfWeek,
            DATENAME(WEEKDAY, @CurrentDate) AS DayNameOfWeek,
            LEFT(DATENAME(WEEKDAY, @CurrentDate), 3) AS DayNameOfWeekAbbr,
            DAY(@CurrentDate) AS DayNumberOfMonth,
            DATEPART(DAYOFYEAR, @CurrentDate) AS DayNumberOfYear,
            DATEPART(WEEK, @CurrentDate) AS WeekNumberOfYear,
            DATENAME(MONTH, @CurrentDate) AS MonthName,
            LEFT(DATENAME(MONTH, @CurrentDate), 3) AS MonthNameAbbr,
            MONTH(@CurrentDate) AS MonthNumberOfYear,
            DATEPART(QUARTER, @CurrentDate) AS CalendarQuarter,
            YEAR(@CurrentDate) AS CalendarYear,
            GETDATE() AS CreationDate,
            GETDATE() AS ModificationDate;

        --  Move to next day
        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END

    PRINT ' DimDate populated successfully!';
END;
GO