SELECT *
FROM Nashvile_Data


/* THIS QUERY IS FOR DATA CLEANING WITH SQL */ 


--Standardize date format


SELECT SaleDate, CONVERT(date, SaleDate) SaleDateConverted
FROM Nashvile_Data

--alter the table, so I can add a new column

ALTER TABLE Nashvile_Data
ADD SaleDateConverted date;


--this is to insert data into the new column
UPDATE Nashvile_Data
SET  SaleDateConverted = CONVERT(date, SaleDate)



--populating property address

SELECT PropertyAddress
FROM Nashvile_Data
Where PropertyAddress IS NULL--property address is not supposed to change, so to populate this, we would need a reference point.



SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Nashvile_Data a
JOIN Nashvile_Data b
    ON a.ParcelID=b.ParcelID
	AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress IS NULL
/* this query populated the null in the property
address by using the parcel ID as the reference */



/*this is to update a so that it can be populated with 
b.property address if null, using ISNULL*/

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM Nashvile_Data a
JOIN Nashvile_Data b
    ON a.ParcelID=b.ParcelID
	AND a.UniqueID<>b.UniqueID
WHERE a.PropertyAddress IS NULL

--for recheck
SELECT PropertyAddress
FROM Nashvile_Data
Where PropertyAddress IS NULL-- this is empty due to the initial update query




/*Breaking address into columns of which (Address, City, State),
using substring, character index and len function.*/


SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM Nashvile_Data



--alter the table, so I can add a new column for the address

ALTER TABLE Nashvile_Data
ADD PropertySplitAddress nvarchar(255)


--this is to insert data into the new column
UPDATE Nashvile_Data
SET  PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) 



--alter the table, so I can add a new column for the city

ALTER TABLE Nashvile_Data
ADD PropertySplitCity nvarchar(255)


--this is to insert data into the new column
UPDATE Nashvile_Data
SET  PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))




--for recheck

SELECT *
FROM Nashvile_Data


--Doing the same thing but using a different function


SELECT OwnerAddress
FROM Nashvile_Data

--USING THE PARSENAME FUNCTION TO SPLIT THE OWNER ADDRESS
SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
FROM Nashvile_Data


--alter the table, so I can add a new column for the city


ALTER TABLE Nashvile_Data
ADD OwnerSplitAddress nvarchar(255)



--this is to insert data into the new column
UPDATE Nashvile_Data
SET  OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)



ALTER TABLE Nashvile_Data
ADD OwnerSplitCity nvarchar(255)


--this is to insert data into the new column
UPDATE Nashvile_Data
SET  OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)




ALTER TABLE Nashvile_Data
ADD OwnerSplitHousing nvarchar(255)


--this is to insert data into the new column
UPDATE Nashvile_Data
SET  OwnerSplitHousing = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)



--for recheck

SELECT *
FROM Nashvile_Data


--changing Y and N to YES and NO in sold of which is the sold as vacant field

SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Nashvile_Data
GROUP BY SoldAsVacant
ORDER BY 2

-- Using the case statement to change Y and N to YES and NO

SELECT SoldAsVacant,
CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
     WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END
FROM Nashvile_Data


--UPDATING THE SOLD AS VACANT COLUMN

UPDATE Nashvile_Data
SET  SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
     WHEN SoldAsVacant = 'N' THEN 'NO'
	 ELSE SoldAsVacant
	 END


--for recheck
 SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM Nashvile_Data
GROUP BY SoldAsVacant
ORDER BY 2


--removing duplicates

--for recheck

SELECT *
FROM Nashvile_Data


SELECT *,
ROW_NUMBER()OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY 
			 UniqueID
			 ) row_num
FROM Nashvile_Data
ORDER BY ParcelID

--Using this with a CTE to select the duplicate rows
WITH RowNumCTE AS (
SELECT *,
ROW_NUMBER()OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY 
			 UniqueID
			 ) row_num
FROM Nashvile_Data
--ORDER BY ParcelID
)

--to delete the duplicate rows
DELETE
FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress



/*to delete unused column, this is not doene to rwaw data that comes
into a company's database except authorized to do so*/


SELECT *
FROM Nashvile_Data

ALTER TABLE Nashvile_Data
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate