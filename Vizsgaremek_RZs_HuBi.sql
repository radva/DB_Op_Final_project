
-----------------------------------------------------------------------------
--								Táblák
-----------------------------------------------------------------------------
CREATE TABLE Customer (
    CustomerID int NOT NULL IDENTITY(1, 1),
    LastName varchar(40) NOT NULL,
    FirstName varchar(40) NOT NULL,
    PhoneNumber varchar(20) NOT NULL,
    Email varchar(80) NOT NULL,
    IDCardNumber varchar(20) NOT NULL,
    MothersName varchar(60) NOT NULL,
    PlaceOfBirth varchar(60) NOT NULL,   
    BirthDate date NOT NULL,
	City varchar(60),
    CountryCode char(2) NOT NULL,
    PostalCode varchar(10),    
    Address varchar(100) NOT NULL
)
ALTER TABLE Customer
ADD CONSTRAINT PK_Customer_CustomerID PRIMARY KEY CLUSTERED (CustomerID)
---------------------------------------------------------------------------------

CREATE TABLE Password (
    CustomerID int NOT NULL IDENTITY(1, 1),
    PasswordHash char(60) NOT NULL
)
ALTER TABLE Password
ADD CONSTRAINT PK_Password_CustomerID PRIMARY KEY CLUSTERED (CustomerID)
---------------------------------------------------------------------------------

CREATE TABLE IPAddress (
    IPAddressID int NOT NULL IDENTITY(1, 1),
    CustomerID int NOT NULL,
    IPAddress binary(4) NOT NULL,
    LoginDate datetime2(2) NOT NULL
)
ALTER TABLE IPAddress
ADD CONSTRAINT PK_IPAddress_IPAddressID PRIMARY KEY CLUSTERED (IPAddressID)
---------------------------------------------------------------------------------

CREATE TABLE InvalidIPRange (
    InvalidIPRangeID tinyint NOT NULL IDENTITY(1, 1),
	NetworkAddress varchar(15) NOT NULL,
    Prefix int NOT NULL,
	InvalidRangeName varchar(50)
)
ALTER TABLE InvalidIPRange
ADD CONSTRAINT PK_InvalidIPRange_InvalidIPRangeID PRIMARY KEY CLUSTERED (InvalidIPRangeID)
--------------------------------------------------------------------------------

CREATE TABLE Country (
    CountryCode char(2) NOT NULL,
    CountryNameHU varchar(100) NOT NULL,
    CountryNameEN varchar(100) NOT NULL,
    CountryNameLoc nvarchar(100),
    ContinentCode char(2),
    CountryISO3 char(3) NOT NULL,
    CountryNum smallint,
    Boundary geography
)
ALTER TABLE Country
ADD CONSTRAINT PK_Country_CountryCode PRIMARY KEY CLUSTERED (CountryCode)
---------------------------------------------------------------------------------

CREATE TABLE Continent (
    ContinentCode char(2) NOT NULL,
    ContinentNameHU varchar(30) NOT NULL,
    ContinentNameEN varchar(40) NOT NULL  
)
ALTER TABLE Continent
ADD CONSTRAINT PK_Continent_ContinentCode PRIMARY KEY CLUSTERED (ContinentCode)
---------------------------------------------------------------------------------

CREATE TABLE PostalCode (
    PostalCodeID int NOT NULL IDENTITY(1, 1),
    PostalCode varchar(10) NOT NULL,
    Children tinyint,
    CountyID smallint,
    CountryCode char(2) NOT NULL,
    Boundary geography
)
ALTER TABLE PostalCode
ADD CONSTRAINT PK_PostalCode_PostalCodeID PRIMARY KEY CLUSTERED (PostalCodeID)
---------------------------------------------------------------------------------

CREATE TABLE Settlement (
    SettlementID int NOT NULL IDENTITY(1, 1),
    SettlementName varchar(40) NOT NULL,
    SettlementTypeID tinyint NOT NULL,
    CountryCode char(2) NOT NULL,
    CountyID smallint,
    Territory int,
	Population int,
    Boundary geography
)
ALTER TABLE Settlement
ADD CONSTRAINT PK_Settlement_SettlementID PRIMARY KEY CLUSTERED (SettlementID)
---------------------------------------------------------------------------------

CREATE TABLE SettlementType (
    SettlementTypeID tinyint NOT NULL IDENTITY(1, 1),
    SettlementTypeName varchar(40) NOT NULL    
)
ALTER TABLE SettlementType
ADD CONSTRAINT PK_SettlementType_SettlementTypeID PRIMARY KEY CLUSTERED (SettlementTypeID)
---------------------------------------------------------------------------------

CREATE TABLE County (
    CountyID smallint NOT NULL IDENTITY(1, 1),
    CountyName varchar(40) NOT NULL,
    CountryCode char(2) NOT NULL,
    Boundary geography
)
ALTER TABLE County
ADD CONSTRAINT PK_County_CountyID PRIMARY KEY CLUSTERED (CountyID)
---------------------------------------------------------------------------------

CREATE TABLE District (
    DistrictID smallint NOT NULL IDENTITY(1, 1),
    DistrictName varchar(40) NOT NULL,
    AlterName varchar(40),
    SettlementID int NOT NULL,
    Territory int,
    Population int,
    Boundary geography
)
ALTER TABLE District
ADD CONSTRAINT PK_District_DistrictID PRIMARY KEY CLUSTERED (DistrictID)
---------------------------------------------------------------------------------

CREATE TABLE Suburb (
    SuburbID smallint NOT NULL IDENTITY(1, 1),
    SuburbName varchar(40),
    SettlementID int NOT NULL,
    DistrictID smallint,
    Boundary geography
)
ALTER TABLE Suburb
ADD CONSTRAINT PK_Suburb_SuburbID PRIMARY KEY CLUSTERED (SuburbID)
---------------------------------------------------------------------------------

CREATE TABLE Station (
    StationID smallint NOT NULL IDENTITY(1, 1),
    StationName varchar(50) NOT NULL,
    PostalCodeID int NOT NULL,    
    SettlementID int NOT NULL,
    DistrictID smallint,
    SuburbID smallint,
    Address varchar(100) NOT NULL,
    TotalRacks tinyint,
    FreeRacks tinyint,
    AvailableBikes tinyint,
    IsPublic bit NOT NULL,
    IsGarage bit NOT NULL,
    IsMeasuring bit NOT NULL,
    GPS geography
)
ALTER TABLE Station
ADD CONSTRAINT PK_Station_StationID PRIMARY KEY CLUSTERED (StationID)
---------------------------------------------------------------------------------

CREATE TABLE AirPollution (
	AirPollutionID int NOT NULL IDENTITY(1, 1),
	StationID smallint,
	Date smalldatetime NOT NULL,
	PM25 real,
	PM10 real,
	NO real,
	NO2 real,
	SO2 real
)

ALTER TABLE AirPollution
ADD CONSTRAINT PK_AirPollution_AirPollutionID PRIMARY KEY CLUSTERED (AirPollutionID)
---------------------------------------------------------------------------------

CREATE TABLE BikeModel (
    BikeModelID smallint NOT NULL IDENTITY(1, 1),
    BikeModelName varchar(20) NOT NULL,
    ManufacturingYear smallint NOT NULL,
    Weight real NOT NULL,
    AssembledLength tinyint NOT NULL,
    WheelSize decimal(3,1) NOT NULL
)
ALTER TABLE BikeModel
ADD CONSTRAINT PK_BikeModel_BikeModelID PRIMARY KEY CLUSTERED (BikeModelID)
---------------------------------------------------------------------------------

CREATE TABLE Bike (
    BikeID int NOT NULL IDENTITY(1, 1),
    StationID smallint,
    BikeModelID smallint NOT NULL,
    BikeStatusID tinyint NOT NULL
)
ALTER TABLE Bike
ADD CONSTRAINT PK_Bike_BikeID PRIMARY KEY CLUSTERED (BikeID)
---------------------------------------------------------------------------------

CREATE TABLE BikeStatus (
    BikeStatusID tinyint NOT NULL IDENTITY(1, 1),
    StatusNameHU varchar(30) NOT NULL,
    StatusNameEN varchar(30) NOT NULL
)
ALTER TABLE BikeStatus
ADD CONSTRAINT PK_BikeStatus_BikeStatusID PRIMARY KEY CLUSTERED (BikeStatusID)
---------------------------------------------------------------------------------

CREATE TABLE ServiceFee (
    ServiceFeeID smallint NOT NULL IDENTITY(1, 1),
    ServiceNameHU varchar(40) NOT NULL,
    ServiceNameEN varchar(40) NOT NULL,
    Fee money NOT NULL,
    StartDate date NOT NULL,
    EndDate date
)
ALTER TABLE ServiceFee
ADD CONSTRAINT PK_ServiceFee_ServiceFeeID PRIMARY KEY CLUSTERED (ServiceFeeID)
---------------------------------------------------------------------------------

CREATE TABLE Purchase (
    PurchaseID int NOT NULL IDENTITY(1, 1),
    CustomerID int NOT NULL,
    RentID int,
    PassID int,
    ServiceFeeID smallint NOT NULL,
    Quantity smallint NOT NULL,
    Fee money NOT NULL,
    TaxAmount money NOT NULL,
    LineTotal money NOT NULL,
    PurchaseDate datetime2(2) NOT NULL
)
ALTER TABLE Purchase
ADD CONSTRAINT PK_Purchase_PurchaseID PRIMARY KEY CLUSTERED (PurchaseID)
---------------------------------------------------------------------------------

CREATE TABLE Pass (
    PassID int NOT NULL IDENTITY(1, 1),
    CustomerID int NOT NULL,
    ServiceFeeID smallint NOT NULL,
    StartDate date NOT NULL,
    EndDate date NOT NULL,
    IsActive bit NOT NULL
)
ALTER TABLE Pass
ADD CONSTRAINT PK_Pass_PassID PRIMARY KEY CLUSTERED (PassID)
---------------------------------------------------------------------------------

CREATE TABLE Rent (
    RentID int NOT NULL IDENTITY(1, 1),
    CustomerID int NOT NULL,
    BikeID int NOT NULL,
    StartDate datetime2(0) NOT NULL,
    EndDate datetime2(0),
    Duration smallint,
    StartStation smallint NOT NULL,
    EndStation smallint
)
ALTER TABLE Rent
ADD CONSTRAINT PK_Rent_RentID PRIMARY KEY CLUSTERED (RentID)

-----------------------------------------------------------------------------
--								Feltöltés
-----------------------------------------------------------------------------

CREATE Table Global(
	GlobalID int NOT NULL IDENTITY(1,1),
	GlobalName varchar(30),
	FilePath varchar(200)
)

INSERT INTO Global(GlobalName, FilePath) 
SELECT *
FROM (VALUES
		('AirPollution', 'C:\vremek\adatok\tablak\vegleges\2\AirPollution.csv'),
		('Bike', 'C:\vremek\adatok\tablak\vegleges\2\Bike.csv'),
		('BikeModel', 'C:\vremek\adatok\tablak\vegleges\2\BikeModel.csv'),
		('BikeStatus', 'C:\vremek\adatok\tablak\vegleges\2\BikeStatus.csv'),
		('Continent', 'C:\vremek\adatok\tablak\vegleges\2\Continent.csv'),
		('Country', 'C:\vremek\adatok\tablak\vegleges\2\Country.csv'),
		('County', 'C:\vremek\adatok\tablak\vegleges\2\County.csv'),
		('Customer', 'C:\vremek\adatok\tablak\vegleges\2\Customer.csv'),
		('District', 'C:\vremek\adatok\tablak\vegleges\2\District.csv'),
		('InvalidIPRange', 'C:\vremek\adatok\tablak\vegleges\2\InvalidIPRange.csv'),
		('IPAddress', 'C:\vremek\adatok\tablak\vegleges\2\IPAddress.csv'),
		('Pass', 'C:\vremek\adatok\tablak\vegleges\2\Pass.csv'),
		('Password', 'C:\vremek\adatok\tablak\vegleges\2\Password.csv'),
		('PostalCode', 'C:\vremek\adatok\tablak\vegleges\2\PostalCode.csv'),
		('Purchase', 'C:\vremek\adatok\tablak\vegleges\2\Purchase.csv'),
		('Rent', 'C:\vremek\adatok\tablak\vegleges\2\Rent.csv'),
		('ServiceFee', 'C:\vremek\adatok\tablak\vegleges\2\ServiceFee.csv'),
		('Settlement', 'C:\vremek\adatok\tablak\vegleges\2\Settlement.csv'),
		('SettlementType', 'C:\vremek\adatok\tablak\vegleges\2\SettlementType.csv'),
		('Station', 'C:\vremek\adatok\tablak\vegleges\2\Station.csv'),
		('Suburb', 'C:\vremek\adatok\tablak\vegleges\2\Suburb.csv')
	) T(GlobalName, FilePath)


GO
DECLARE @S varchar(max) = ''
SELECT @S += 'BULK INSERT ' + G.GlobalName
+ CHAR(13) + CHAR(10)
+ 'FROM ''' + G.FilePath + ''' '
+ CHAR(13) + CHAR(10)
+ 'WITH(FIELDTERMINATOR = '';'', ROWTERMINATOR =''\n'', CODEPAGE = ''65001'', FIRSTROW=2) '
+ CHAR(13) + CHAR(10) + CHAR(13) + CHAR(10)
FROM dbo.Global G

--PRINT @S
EXEC (@S)

-----------------------------------------------------------------------------
--								Idegen kulcsok
-----------------------------------------------------------------------------

GO
ALTER TABLE Customer DROP CONSTRAINT FK_Customer_Country_CountryCode
ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Country_CountryCode 
FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON UPDATE CASCADE

ALTER TABLE Customer
ADD CONSTRAINT FK_Customer_Password_CustomerID 
FOREIGN KEY (CustomerID) REFERENCES Password(CustomerID)

ALTER TABLE IPAddress
ADD CONSTRAINT FK_IPAddress_Customer_CustomerID 
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

ALTER TABLE Country DROP CONSTRAINT FK_Country_Continent_ContinentCode
ALTER TABLE Country
ADD CONSTRAINT FK_Country_Continent_ContinentCode 
FOREIGN KEY (ContinentCode) REFERENCES Continent(ContinentCode) ON UPDATE CASCADE

ALTER TABLE PostalCode
ADD CONSTRAINT FK_PostalCode_County_CountyID 
FOREIGN KEY (CountyID) REFERENCES County(CountyID)

ALTER TABLE PostalCode DROP CONSTRAINT FK_PostalCode_Country_CountryCode
ALTER TABLE PostalCode
ADD CONSTRAINT FK_PostalCode_Country_CountryCode
FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON UPDATE CASCADE

ALTER TABLE Settlement DROP CONSTRAINT FK_Settlement_SettlementType_SettlementTypeID
ALTER TABLE Settlement
ADD CONSTRAINT FK_Settlement_SettlementType_SettlementTypeID 
FOREIGN KEY (SettlementTypeID) REFERENCES SettlementType(SettlementTypeID) ON UPDATE CASCADE

ALTER TABLE Settlement DROP CONSTRAINT FK_Settlement_Country_CountryCode
ALTER TABLE Settlement
ADD CONSTRAINT FK_Settlement_Country_CountryCode 
FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON UPDATE CASCADE

ALTER TABLE Settlement
ADD CONSTRAINT FK_Settlement_County_CountyID 
FOREIGN KEY (CountyID) REFERENCES County(CountyID)

ALTER TABLE County
ADD CONSTRAINT FK_County_Country_CountryCode 
FOREIGN KEY (CountryCode) REFERENCES Country(CountryCode) ON UPDATE CASCADE

ALTER TABLE District
ADD CONSTRAINT FK_District_Settlement_SettlementID
FOREIGN KEY (SettlementID) REFERENCES Settlement(SettlementID)

ALTER TABLE Suburb
ADD CONSTRAINT FK_Suburb_Settlement_SettlementID
FOREIGN KEY (SettlementID) REFERENCES Settlement(SettlementID)

ALTER TABLE Suburb
ADD CONSTRAINT FK_Suburb_District_DistrictID
FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)

ALTER TABLE Station
ADD CONSTRAINT FK_Station_PostalCode_PostalCodeID
FOREIGN KEY (PostalCodeID) REFERENCES PostalCode(PostalCodeID)

ALTER TABLE Station
ADD CONSTRAINT FK_Station_Settlement_SettlementID
FOREIGN KEY (SettlementID) REFERENCES Settlement(SettlementID)

ALTER TABLE Station
ADD CONSTRAINT FK_Station_District_DistrictID
FOREIGN KEY (DistrictID) REFERENCES District(DistrictID)

ALTER TABLE Station
ADD CONSTRAINT FK_Station_Suburb_SuburbID
FOREIGN KEY (SuburbID) REFERENCES Suburb(SuburbID)

ALTER TABLE AirPollution
ADD CONSTRAINT FK_AirPollution_Station_StationID
FOREIGN KEY (StationID) REFERENCES Station(StationID)

ALTER TABLE Bike
ADD CONSTRAINT FK_Bike_Station_StationID
FOREIGN KEY (StationID) REFERENCES Station(StationID)

ALTER TABLE Bike
ADD CONSTRAINT FK_Bike_BikeModel_BikeModelID
FOREIGN KEY (BikeModelID) REFERENCES BikeModel(BikeModelID)

ALTER TABLE Bike
ADD CONSTRAINT FK_Bike_BikeStatus_BikeStatusID
FOREIGN KEY (BikeStatusID) REFERENCES BikeStatus(BikeStatusID)

ALTER TABLE Purchase
ADD CONSTRAINT FK_Purchase_Customer_CustomerID
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

ALTER TABLE Purchase
ADD CONSTRAINT FK_Purchase_Rent_RentID
FOREIGN KEY (RentID) REFERENCES Rent(RentID)

ALTER TABLE Purchase
ADD CONSTRAINT FK_Purchase_Pass_PassID
FOREIGN KEY (PassID) REFERENCES Pass(PassID)

ALTER TABLE Purchase
ADD CONSTRAINT FK_Purchase_ServiceFee_ServiceFeeID
FOREIGN KEY (ServiceFeeID) REFERENCES ServiceFee(ServiceFeeID)

ALTER TABLE Pass
ADD CONSTRAINT FK_Pass_Customer_CustomerID
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

ALTER TABLE Pass
ADD CONSTRAINT FK_Pass_ServiceFee_ServiceFeeID
FOREIGN KEY (ServiceFeeID) REFERENCES ServiceFee(ServiceFeeID)

ALTER TABLE Rent
ADD CONSTRAINT FK_Rent_Customer_CustomerID
FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)

ALTER TABLE Rent
ADD CONSTRAINT FK_Rent_Bike_BikeID
FOREIGN KEY (BikeID) REFERENCES Bike(BikeID)

ALTER TABLE Rent
ADD CONSTRAINT FK_Rent_StartStation_StationID
FOREIGN KEY (StartStation) REFERENCES Station(StationID)

ALTER TABLE Rent
ADD CONSTRAINT FK_Rent_EndStation_StationID
FOREIGN KEY (EndStation) REFERENCES Station(StationID)

------------------------------------------------------------------------
--								Indexek
------------------------------------------------------------------------
CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_Email ON Customer (Email ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_Customer_PhoneNumber ON Customer (PhoneNumber ASC)

CREATE UNIQUE NONCLUSTERED INDEX AK_Country_CountryNameHU ON Country (CountryNameHU ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_Country_CountryNameEN ON Country (CountryNameEN ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_Country_CountryISO3 ON Country (CountryISO3 ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_Country_CountryNum ON Country (CountryNum ASC) WHERE CountryNum IS NOT NULL

CREATE UNIQUE NONCLUSTERED INDEX AK_Settlement_SettlementName ON Settlement (SettlementName ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_County_CountyName ON County (CountyName ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_Suburb_SuburbName ON Suburb (SuburbName ASC)
CREATE UNIQUE NONCLUSTERED INDEX AK_District_DistrictName ON District (DistrictName ASC)

CREATE NONCLUSTERED INDEX IX_Pass_CustomerID ON Pass (CustomerID)
CREATE NONCLUSTERED INDEX IX_Rent_CustomerID ON Rent (CustomerID)


-----------------------------------------------------------------------------
--								Függvények
-----------------------------------------------------------------------------
GO
CREATE VIEW dbo.vRandom
AS
SELECT ABS(CHECKSUM(NEWID())) RandomNum
-----------------------------------------------------------------------------
/************************************************************
	SELECT dbo.GetRandomNumber(5000)
************************************************************/
GO
CREATE OR ALTER FUNCTION dbo.GetRandomNumber(@num int)
RETURNS int 
AS
	BEGIN		
		RETURN (SELECT (RandomNum % @num)+1 Random FROM dbo.vRandom)
	END
GO

-----------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION dbo.IPv4VarcharToBinary(@IP varchar(15)) 
RETURNS binary(4)
AS
/************************************************************
	SELECT dbo.IPv4VarcharToBinary('192.168.1.1')
************************************************************/
BEGIN
    DECLARE @Result binary(4)
    SELECT @Result = (
		CAST(CAST(PARSENAME(@IP, 4) AS int) AS binary(1)) +
		CAST(CAST(PARSENAME(@IP, 3) AS int) AS binary(1)) +
        CAST(CAST(PARSENAME(@IP, 2) AS int) AS binary(1)) +
        CAST(CAST(PARSENAME(@IP, 1) AS int) AS binary(1))
		)
    RETURN @Result
END

-----------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION dbo.IPv4BinaryToVarchar(@ip AS binary(4)) RETURNS varchar(15)
AS
/********************************************************
	SELECT dbo.IPv4BinaryToVarchar(0xC0A80101)
********************************************************/
BEGIN
    DECLARE @str AS VARCHAR(15)
    SELECT @str = CAST(CAST(SUBSTRING(@ip, 1, 1) AS int) AS varchar(3)) + '.'
                + CAST(CAST(SUBSTRING(@ip, 2, 1) AS int) AS varchar(3)) + '.'
                + CAST(CAST(SUBSTRING(@ip, 3, 1) AS int) AS varchar(3)) + '.'
                + CAST(CAST(SUBSTRING(@ip, 4, 1) AS int) AS varchar(3))
    RETURN @str
END

-----------------------------------------------------------------------------
GO
CREATE OR ALTER FUNCTION dbo.IPv4Checker(@IP binary(4))
RETURNS bit
AS
/***********************************************************************
	SELECT dbo.IPv4Checker(dbo.IPv4VarcharToBinary('192.168.1.1'))
	SELECT dbo.IPv4Checker(dbo.IPv4VarcharToBinary('200.168.1.1'))
***********************************************************************/
BEGIN
	-- igeiglenes tábla, ami a bináris határokat tárolja
	DECLARE @BinaryInvalidRange Table(
		LowerBound binary(4),
		UpperBound binary(4)
	)

	INSERT INTO @BinaryInvalidRange (LowerBound, UpperBound)
	SELECT 
		dbo.IPv4VarcharToBinary(IR.NetworkAddress) LowerBound,
		dbo.IPv4VarcharToBinary(IR.NetworkAddress) + POWER(CAST(2 AS bigint), (32-IR.Prefix))-1
	FROM dbo.InvalidIPRange IR

	IF EXISTS (
		SELECT 1 
		FROM @BinaryInvalidRange BIR
		WHERE @IP BETWEEN BIR.LowerBound AND BIR.UpperBound
	)
	BEGIN
		RETURN 0
	END
	ELSE
		RETURN 1
	
	RETURN 0
END

GO

-----------------------------------------------------------------------------

GO
CREATE OR ALTER FUNCTION dbo.EmailChecker(@email varchar(80))
RETURNS BIT
AS
/************************************************************
	SELECT dbo.EmailChecker('hello@vilag.hu')
	SELECT dbo.EmailChecker('mieza@cim')
	SELECT dbo.EmailChecker('no@citromail.hu')
*************************************************************/
BEGIN
    IF	PATINDEX('%_@__%.__%', @email) > 0 AND
		PATINDEX('%@citromail.hu',  @email) = 0
    BEGIN
        RETURN 1
    END

    RETURN 0
END

-----------------------------------------------------------------------------
GO

CREATE OR ALTER FUNCTION dbo.ColumnDocumentation(@TableName varchar(30)) RETURNS TABLE
AS
/****************************************************
	SELECT * 
	FROM dbo.ColumnDocumentation('Customer')
*****************************************************/
RETURN
	WITH X AS (    
		SELECT
			C.TABLE_SCHEMA, C.TABLE_NAME, C.ORDINAL_POSITION, C.COLUMN_NAME, C.DATA_TYPE,
			-- Adattípus
			CASE
				WHEN C.DATA_TYPE IN ('binary','varbinary') THEN (CASE C.CHARACTER_OCTET_LENGTH WHEN -1 THEN '(max)' ELSE CONCAT('(', C.CHARACTER_OCTET_LENGTH, ')') END)
				WHEN C.DATA_TYPE IN ('char','varchar','nchar','nvarchar') THEN (CASE C.CHARACTER_MAXIMUM_LENGTH WHEN -1 THEN '(max)' ELSE CONCAT('(', c.CHARACTER_MAXIMUM_LENGTH, ')') END)
				WHEN C.DATA_TYPE IN ('datetime2','datetimeoffset') THEN CONCAT('(', C.DATETIME_PRECISION, ')')
				WHEN C.DATA_TYPE IN ('decimal','numeric') THEN CONCAT('(', C.NUMERIC_PRECISION ,',', C.NUMERIC_SCALE, ')')
			END DATA_TYPE_PARAMETER,
			-- Kötelező
			CASE C.IS_NULLABLE 
				WHEN 'NO' THEN 'NOT NULL'
				WHEN 'YES' THEN 'NULL'
			END NULLABILITY,
			C.COLUMN_DEFAULT,		
			-- Default
			CASE COLUMNPROPERTY(OBJECT_ID(C.TABLE_SCHEMA + '.' + C.TABLE_NAME), C.COLUMN_NAME, 'IsIdentity')
				WHEN '1' THEN 'IDENTITY'
				WHEN '0' THEN C.COLUMN_DEFAULT
			END DEFAULT_SETTING,
			-- Értelmezés
			(SELECT EP.value
				FROM sys.columns SC
				INNER JOIN sys.objects SO ON SO.object_id = SC.object_id
				LEFT JOIN sys.extended_properties EP ON EP.major_id = SC.object_id AND EP.minor_id = SC.column_id AND EP.name = 'MS_Description'
				WHERE EP.major_id = OBJECT_ID(C.TABLE_SCHEMA + '.' + C.TABLE_NAME) AND SC.name = C.COLUMN_NAME AND EP.class = 1
			) DESCRIPTION,
			-- Ellenőrzés
			(SELECT COUNT(1)
				FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CCU
				WHERE CCU.TABLE_NAME = C.TABLE_NAME AND CCU.COLUMN_NAME = C.COLUMN_NAME AND CCU.CONSTRAINT_NAME LIKE 'PK_%') PK,
			(SELECT COUNT(1)
				FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CCU
				WHERE CCU.TABLE_NAME = C.TABLE_NAME AND CCU.COLUMN_NAME = C.COLUMN_NAME AND CCU.CONSTRAINT_NAME LIKE 'FK_%') FK,
			(SELECT COUNT(1)
				FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CCU
				WHERE CCU.TABLE_NAME = C.TABLE_NAME AND CCU.COLUMN_NAME = C.COLUMN_NAME AND CCU.CONSTRAINT_NAME LIKE 'CK_%') CK,
			(SELECT COUNT(1)
				FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE CCU
				WHERE CCU.TABLE_NAME = C.TABLE_NAME AND CCU.COLUMN_NAME = C.COLUMN_NAME AND CCU.CONSTRAINT_NAME LIKE 'AK_%') AK
		FROM INFORMATION_SCHEMA.COLUMNS C
	)
	SELECT TOP 100
		--X.TABLE_NAME,
		X.COLUMN_NAME 'Oszlop neve',
		CONCAT(X.DATA_TYPE, COALESCE(X.DATA_TYPE_PARAMETER, '')) 'Adattípus',
		X.NULLABILITY 'Kötelező',
		COALESCE(X.DEFAULT_SETTING, '') 'Default',
		COALESCE(X.DESCRIPTION,'') 'Értelmezés',
		--CONCAT(IIF(X.PK>0, 'PK, ', ''), IIF(X.FK>0, 'FK, ', ''), IIF(X.CK>0, 'CK, ', ''), IIF(X.AK>0, 'AK, ', '')) 'Ellenőrzés',
		IIF(RIGHT(CONCAT(IIF(X.PK>0, 'PK, ', ''), IIF(X.FK>0, 'FK, ', ''), IIF(X.CK>0, 'CK, ', ''), IIF(X.AK>0, 'AK, ', '')),2)=', ',
		LEFT(CONCAT(IIF(X.PK>0, 'PK, ', ''), IIF(X.FK>0, 'FK, ', ''), IIF(X.CK>0, 'CK, ', ''), IIF(X.AK>0, 'AK, ', '')), LEN(CONCAT(IIF(X.PK>0, 'PK, ', ''), IIF(X.FK>0, 'FK, ', ''), IIF(X.CK>0, 'CK, ', ''), IIF(X.AK>0, 'AK, ', '')))-1),
		'') 'Ellenőrzés'
	FROM X
	WHERE X.TABLE_NAME = @TableName
	ORDER BY X.TABLE_NAME, X.ORDINAL_POSITION


-----------------------------------------------------------------------------
--								Check constaintek
-----------------------------------------------------------------------------

ALTER TABLE Customer 
ADD CONSTRAINT CK_Customer_BirthDate CHECK (DATEADD(YEAR, -14, CAST(SYSDATETIME() AS date)) >= BirthDate)

ALTER TABLE Customer 
ADD CONSTRAINT CK_Customer_Email CHECK (dbo.EmailChecker(Email) = 1)

ALTER TABLE Pass 
ADD CONSTRAINT CK_Pass_StartDate_EndDate CHECK (StartDate<EndDate)

-- lassú, elég nagy táblát ellenőríz és két függvény is van a függvény belsejében
ALTER TABLE IPAddress 
ADD CONSTRAINT CK_IPAddress_IPAddress CHECK (dbo.IPv4Checker(IPAddress) = 1)

-----------------------------------------------------------------------------
--								Tárolt eljárások
-----------------------------------------------------------------------------

GO
CREATE OR ALTER PROC dbo.GetRandomCoordinate
	@Polygon geography,
	@GPSPoint geography OUTPUT
AS

/********************************************************************************
GO
DECLARE @Polygon geography, @Result geography
SET @Polygon = (SELECT S.Boundary FROM Settlement S WHERE S.SettlementName = 'Szeged')
EXEC dbo.GetRandomCoordinate @Polygon = @Polygon, @GPSPoint = @Result OUTPUT

SELECT 
	REPLACE(CAST(@Result.Lat AS varchar), ',', '.') Latitude, 
	REPLACE(CAST(@Result.Long AS varchar), ',', '.') Logitude, 
	@Result.ToString() WKT, @Result Geography
*********************************************************************************/

BEGIN
	SET NOCOUNT ON
	-- deklarációk
	DECLARE @i int = 1, @RandomLati varchar(20), @RandomLongi varchar(20), @Point varchar(40)

	DECLARE @SampleCoordinates Table(
		Latitude float,
		Longitude float
	)

	DECLARE @RandomCoordinates Table(
		Latitude float,
		Longitude float
	)

	-- random határ koordináták kiválasztása a határ koordinátákból
	WHILE @i <= 50
	BEGIN
		INSERT INTO @SampleCoordinates
		SELECT 
			@Polygon.STPointN(dbo.GetRandomNumber(@Polygon.STNumPoints())).Lat Latitude,
			@Polygon.STPointN(dbo.GetRandomNumber(@Polygon.STNumPoints())).Long Longitude
		SET @i = @i + 1
	END


	-- MIN és MAX értékek megtalálása a mintában, majd ezen értékek közé eső random koordináták generálása
	INSERT INTO @RandomCoordinates
	SELECT
		(MAX(SC.Latitude)*10000 - (dbo.GetRandomNumber(CAST((MAX(SC.Latitude) - MIN(SC.Latitude))*10000 AS INT))))/10000 Lati,
		(MAX(SC.Longitude)*10000 - (dbo.GetRandomNumber(CAST((MAX(SC.Longitude) - MIN(SC.Longitude))*10000 AS INT))))/10000 Longi
	FROM @SampleCoordinates SC


	-- előkészítés a geography típushoz
	SELECT @RandomLati = REPLACE(CAST(R.Latitude AS varchar), ',', '.' ) FROM @RandomCoordinates R
	SELECT @RandomLongi = REPLACE(CAST(R.Longitude AS varchar), ',', '.' ) FROM @RandomCoordinates R

	SET @Point = 'POINT (' +@RandomLongi + ' ' + @RandomLati + ')'
	SET @GPSPoint = geography::STPointFromText(@Point, 4326)


	-- ha a generált koordináta kívül esik a területen, akkor újra próbálkozik
	WHILE @Polygon.STContains(@GPSPoint) <> 1
	BEGIN
		DELETE FROM @RandomCoordinates
		INSERT INTO @RandomCoordinates
		SELECT
			(MAX(SC.Latitude)*10000 - (dbo.GetRandomNumber(CAST((MAX(SC.Latitude) - MIN(SC.Latitude))*10000 AS INT))))/10000 Lati,
			(MAX(SC.Longitude)*10000 - (dbo.GetRandomNumber(CAST((MAX(SC.Longitude) - MIN(SC.Longitude))*10000 AS INT))))/10000 Longi
		FROM @SampleCoordinates SC

		SELECT @RandomLati = REPLACE(CAST(R.Latitude AS varchar), ',', '.' ) FROM @RandomCoordinates R
		SELECT @RandomLongi = REPLACE(CAST(R.Longitude AS varchar), ',', '.' ) FROM @RandomCoordinates R
	
		SET @Point = 'POINT (' +@RandomLongi + ' ' + @RandomLati + ')'
		SET @GPSPoint = geography::STPointFromText(@Point, 4326)
	END
END

-----------------------------------------------------------------------------

GO
CREATE OR ALTER PROC dbo.ExportTableToCSV	
	@DB varchar(30),
	@Scheme varchar(30),
	@TableName varchar(30),
	@Path varchar(300)
AS
/*****************************************************************
	EXEC dbo.ExportTableToCSV 'HuBi', 'dbo', 'Customer', 'C:\temp'
******************************************************************/
BEGIN
	SET NOCOUNT ON
	-- cmd engedélyezése, vagy eredeti érték megtartása
	DECLARE @cmdStatus bit
	SET @cmdStatus = (SELECT CAST(value AS bit) FROM sys.configurations WHERE name = 'xp_cmdshell')
	IF @cmdStatus = 0
		BEGIN
		EXEC sp_configure 'xp_cmdshell', '1'
		RECONFIGURE
		END
	ELSE
		BEGIN
		SET @cmdStatus = @cmdStatus
		END

	--- header csv generálása
	DECLARE @BcpCmd varchar(300) = ''
	SET @BcpCmd += 'bcp "SELECT STRING_AGG(C.COLUMN_NAME, '';'')'
	+ 'FROM '+ @DB +'.INFORMATION_SCHEMA.COLUMNS C'
	+ ' WHERE C.TABLE_NAME = ''' + @TableName + ''''
	+ '" queryout "' + @Path + '\' + @TableName + '_header.csv" -c -C 65001 -t; -T'
	EXEC xp_cmdshell @BcpCmd, NO_OUTPUT

	-- data csv generálása
	SET @BcpCmd = 'bcp "SELECT * FROM ' + @DB + '.' + @Scheme + '.' + @TableName +' ORDER BY 1" queryout "' + @Path + '\' + @TableName + '_data.csv" -c -C UTF8 -t; -T'
	EXEC xp_cmdshell @BcpCmd, NO_OUTPUT

	-- összefűzés
	SET @BcpCmd = 'copy /b ' + @Path + '\' + @TableName +'_header.csv + ' + @Path + '\' + @TableName +'_data.csv ' + @Path + '\' + @TableName +'.csv'
	EXEC xp_cmdshell @BcpCmd, NO_OUTPUT
	-- segéd csv-k törlése
	SET @BcpCmd = 'del ' + @Path + '\' + @TableName +'_header.csv ' + @Path + '\' + @TableName + '_data.csv '
	EXEC xp_cmdshell @BcpCmd, NO_OUTPUT

	-- eredeti sp_configure visszaállítás
	IF @cmdStatus = 0
		BEGIN
			EXEC sp_configure 'xp_cmdshell', '0'
		RECONFIGURE
		END
	ELSE
		BEGIN
			SET @cmdStatus = @cmdStatus
		END
	PRINT @TableName + ' - ' + CAST(SYSDATETIME() AS varchar(30))
END


-----------------------------------------------------------------------------

GO
CREATE OR ALTER PROC dbo.ExportAllTablesToCSV	
	@DB varchar(30),
	@Scheme varchar(30),
	@Path varchar(300)
AS
/*************************************************************
	EXEC dbo.ExportAllTablesToCSV 'HuBi', 'dbo', 'c:\temp'
**************************************************************/
BEGIN
	SET NOCOUNT ON
	-- cmd engedélyezése, vagy eredeti érték megtartása
	DECLARE @cmdStatus bit
	SET @cmdStatus = (SELECT CAST(value AS bit) FROM sys.configurations WHERE name = 'xp_cmdshell')
	IF @cmdStatus = 0
		BEGIN
		EXEC sp_configure 'xp_cmdshell', '1'
		RECONFIGURE
		END
	ELSE
		BEGIN
		SET @cmdStatus = @cmdStatus
		END

	DECLARE @TableName varchar(30)
	DECLARE TableCursor CURSOR FOR
	SELECT T.TABLE_NAME
	FROM INFORMATION_SCHEMA.TABLES T
	WHERE T.TABLE_TYPE = 'BASE TABLE'

	OPEN TableCursor

	FETCH NEXT FROM TableCursor INTO @TableName

	WHILE @@FETCH_STATUS = 0
	BEGIN	
		--- header csv generálása
		DECLARE @BcpCmd varchar(300) = ''
		SET @BcpCmd += 'bcp "SELECT STRING_AGG(C.COLUMN_NAME, '';'')'
		+ 'FROM '+ @DB +'.INFORMATION_SCHEMA.COLUMNS C'
		+ ' WHERE C.TABLE_NAME = ''' + @TableName + ''''
		+ '" queryout "' + @Path + '\' + @TableName + '_header.csv" -c -C 65001 -t; -T'
		EXEC xp_cmdshell @BcpCmd, NO_OUTPUT

		-- data csv generálása
		SET @BcpCmd = 'bcp "SELECT * FROM ' + @DB + '.' + @Scheme + '.' + @TableName +' ORDER BY 1" queryout "' + @Path + '\' + @TableName + '_data.csv" -c -C UTF8 -t; -T'
		EXEC xp_cmdshell @BcpCmd, NO_OUTPUT

		-- összefűzés
		SET @BcpCmd = 'copy /b ' + @Path + '\' + @TableName +'_header.csv + ' + @Path + '\' + @TableName +'_data.csv ' + @Path + '\' + @TableName +'.csv'
		EXEC xp_cmdshell @BcpCmd, NO_OUTPUT
		-- segéd csv-k törlése
		SET @BcpCmd = 'del ' + @Path + '\' + @TableName +'_header.csv ' + @Path + '\' + @TableName + '_data.csv '
		EXEC xp_cmdshell @BcpCmd, NO_OUTPUT
				
		PRINT @TableName + ' - ' + CAST(SYSDATETIME() AS varchar(30))
	
		FETCH NEXT FROM TableCursor INTO @TableName
	END

	CLOSE TableCursor
	DEALLOCATE TableCursor

	-- eredeti sp_configure visszaállítás
	IF @cmdStatus = 0
		BEGIN
		EXEC sp_configure 'xp_cmdshell', '0'
		RECONFIGURE
		END
	ELSE
		BEGIN
		SET @cmdStatus = @cmdStatus
		END
END

-----------------------------------------------------------------------------
GO
CREATE OR ALTER PROC dbo.DropColumnDescriptions
	@TableName varchar(30)
AS
/*************************************************************
	EXEC dbo.DropColumnDescriptions 'Bike'
*************************************************************/
BEGIN
	DECLARE @S varchar(MAX) = ''
	SELECT @S += 'EXEC sp_dropextendedproperty '
		+ CHAR(13) + CHAR(10) + CHAR(9)
		+ '@name = ''MS_Description'', '
		+ CHAR(13) + CHAR(10) + CHAR(9)
		+ '@level0type = ''SCHEMA'', '
		+ '@level0name = ''dbo'', '
		+ CHAR(13) + CHAR(10) + CHAR(9)
		+ '@level1type = ''TABLE'', '
		+ '@level1name = ''' + @TableName + ''', '
		+ CHAR(13) + CHAR(10) + CHAR(9)
		+ '@level2type = ''COLUMN'', '
		+ '@level2name = ''' + C.name + ''' '
		+ CHAR(13) + CHAR(10)
	FROM sys.columns C
	WHERE object_id = OBJECT_ID(@TableName)
	EXEC (@S)
END

-----------------------------------------------------------------------------
GO
CREATE OR ALTER PROC dbo.GenBlankScriptForColDesc
AS

/*************************************************************
	EXEC dbo.GenBlankScriptForColDesc
*************************************************************/
BEGIN
	DECLARE @TableName varchar(30)
	DECLARE @S varchar(MAX) = ''

	DECLARE TableCursor CURSOR FOR
	SELECT T.TABLE_NAME
	FROM INFORMATION_SCHEMA.TABLES T
	WHERE T.TABLE_TYPE = 'BASE TABLE'

	OPEN TableCursor

	FETCH NEXT FROM TableCursor INTO @TableName

	WHILE @@FETCH_STATUS = 0
	BEGIN	
		SET @S = ''
		SELECT @S += '------------------------------ ' + UPPER(@TableName) + ' ------------------------------'
		+ CHAR(13) + CHAR(10)
		SELECT @S += 'EXEC sp_addextendedproperty '
			+ CHAR(13) + CHAR(10) + CHAR(9)
			+ '@name = ''MS_Description'', '
			+ CHAR(13) + CHAR(10) + CHAR(9)
			+ '@value = '''','
			+ CHAR(13) + CHAR(10) + CHAR(9)
			+ '@level0type = ''SCHEMA'', '
			+ '@level0name = ''dbo'', '
			+ CHAR(13) + CHAR(10) + CHAR(9)
			+ '@level1type = ''TABLE'', '
			+ '@level1name = ''' + @TableName + ''', '
			+ CHAR(13) + CHAR(10) + CHAR(9)
			+ '@level2type = ''COLUMN'', '
			+ '@level2name = ''' + C.name + ''' '
			+ CHAR(13) + CHAR(10)
		FROM sys.columns C
		WHERE object_id = OBJECT_ID(@TableName)
		SELECT @S += CHAR(13) + CHAR(10)
		PRINT @S
		
		FETCH NEXT FROM TableCursor INTO @TableName
	END

	CLOSE TableCursor
	DEALLOCATE TableCursor
END

-----------------------------------------------------------------------------
GO
CREATE OR ALTER PROC dbo.AllIndexRebuild
AS
/****************************************************
	EXEC dbo.AllIndexRebuild
****************************************************/
DECLARE curTable CURSOR FOR 
SELECT name FROM sys.tables

DECLARE @name varchar(200), @S varchar(1000)

OPEN curTable
FETCH NEXT FROM curTable INTO @name

WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @S = 'ALTER INDEX ALL ON ' + @name + ' REBUILD'
		EXEC (@S)
		FETCH NEXT FROM curTable INTO @name
	END

CLOSE curTable
DEALLOCATE curTable

-----------------------------------------------------------------------------
--								View-ek
-----------------------------------------------------------------------------
GO
CREATE OR ALTER VIEW vDistrictTerritoryDiff
AS
SELECT TOP 100
	D.DistrictName 'Kerület', D.AlterName 'Név', S.SettlementName 'Település',
	REPLACE(FORMAT(D.Population, 'N0'), ',',' ') Népesség, 
	REPLACE(FORMAT(D.Territory, 'N0'), ',', ' ') 'Terület (KSH) [ha]', 
	REPLACE(FORMAT(ROUND(D.Boundary.STArea()/10000, 0), 'N0'), ',',' ') 'Számított [ha]',
	ROUND(ABS(100-ROUND(D.Boundary.STArea()/10000, 0)/D.Territory*100),2) 'Különbség [%]'
FROM District D
LEFT JOIN Settlement S ON S.SettlementID = D.SettlementID
ORDER BY 'Különbség [%]' DESC

-----------------------------------------------------------------------------
GO
CREATE OR ALTER VIEW vStationPerInhabitants
AS
WITH X AS (
	SELECT S.DistrictID, COUNT(1) DB
	FROM Station S
	GROUP BY S.DistrictID
	)
SELECT 
	D.DistrictName, X.DB 'Állomások száma [db]', 
	REPLACE(FORMAT(D.Population, 'N0'), ',',' ') 'Népesség [fő]',
	REPLACE(FORMAT(D.Territory, 'N0'),',',' ') 'Terület [ha]', 
	REPLACE(FORMAT(CAST(D.Population AS money)/(CAST(D.Territory AS money))*100, 'N0'),',', ' ') 'Népsűrűség [fő/km2]',
	ROUND((CAST(X.DB*100000 AS money)/D.Population),2) '100 ezer főre jutó állomások száma [db]'
FROM X
LEFT JOIN District D ON D.DistrictID = X.DistrictID

-----------------------------------------------------------------------------

GO
CREATE OR ALTER VIEW vMostActiveCustomers
AS
SELECT TOP 250 R.CustomerID, 
	SUM(Duration) Duration,
	MAX(C.LastName) + ' ' + MAX(C.FirstName) Name,
	MAX(C.Email) Email,
	MAX(C.BirthDate) BirthDay,
	MAX(C.CountryCode) CountryCode
FROM Rent R
LEFT JOIN Customer C ON C.CustomerID = R.CustomerID
WHERE StartDate >= '2023-01-01' AND C.BirthDate > DATEADD(YEAR, -25, SYSDATETIME())
GROUP BY R.CustomerID
ORDER BY SUM(Duration) DESC

