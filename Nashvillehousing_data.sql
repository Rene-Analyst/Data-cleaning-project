
Select *
FROM protofolio_project.nashvillehousing

-- Standardize Date Format

SELECT DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m-%d-%Y') AS formatted_date;
FROM protofolio_project.nashvillehousing

UPDATE nashvillehousingdata
SET SaleDate = DATE_FORMAT(STR_TO_DATE(SaleDate, '%M %d, %Y'), '%m-%d-%Y');

-- Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
From protofolio_project.nashvillehousing

SELECT
  SUBSTRING_INDEX(PropertyAddress, ',', 1) as Address,
  SUBSTRING_INDEX(PropertyAddress, ',', -1) as Address
FROM protofolio_project.NashvilleHousing;

ALTER TABLE nashvilleHousing
ADD COLUMN PropertySplitAddress CHAR(255);

UPDATE nashvilleHousing
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', 1)

ALTER TABLE nashvilleHousing
ADD COLUMN PropertySplitCity_Address CHAR(255);

UPDATE nashvilleHousing
SET PropertySplitAddress = SUBSTRING_INDEX(PropertyAddress, ',', -1)

Select *
From protofolio_project.nashvilleHousing

Select OwnerAddress
FROM protofolio_project.nashvilleHousing

SELECT
  SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 1), ',', -1) as Street,
  SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1) as City,
  SUBSTRING_INDEX(OwnerAddress, ',', -1) as State
FROM protofolio_project.NashvilleHousing;

ALTER TABLE nashvillehousing
ADD COLUMN Street CHAR(255)

UPDATE nashvillehousing
SET Street = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 1), ',', -1)

ALTER TABLER nashvillehousing
ADD COLUMN City CHAR(255)

UPDATE nashvillehousing
SET City = SUBSTRING_INDEX(SUBSTRING_INDEX(OwnerAddress, ',', 2), ',', -1)

ALTER TABLER nashvillehousing
ADD COLUMN State CHAR(255)
.
UPDATE nashvillehousing
SET State = SUBSTRING_INDEX(OwnerAddress, ',', -1)

-- Change Y and N to Yes and No in "Sold as Vacant" field
Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From protofolio_project.nashvilleHousing
Group by SoldAsVacant
order by 2

SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
	   WHEN SoldAsVacant = 'N' THEN 'No' 
	   ELSE SoldAsVacant
	   END
       FROM protofolio_project.nashvillehousing
       
       SELECT SoldAsVacant,
       CASE 
           WHEN SoldAsVacant = 'Y' THEN 'Yes' 
           WHEN SoldAsVacant = 'N' THEN 'No' 
           ELSE SoldAsVacant
       END AS SoldAsVacantDescription
FROM protofolio_project.nashvillehousing;

Update NashvilleHousing
SET SoldAsVacant = CASE 
           WHEN SoldAsVacant = 'Y' THEN 'Yes' 
           WHEN SoldAsVacant = 'N' THEN 'No' 
           ELSE SoldAsVacant
       END
-- Remove Duplicates

WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

From PortfolioProject.dbo.NashvilleHousing
--order by ParcelID
)
Select */ DELETE
From RowNumCTE
Where row_num > 1
Order by PropertyAddress

-- Delete Unused Columns

SELECT *
FROM protofolio_project.nashvillehousing

ALTER TABLE protofolio_project.nashvillehousing
  DROP COLUMN OwnerAddress,
      DROP COLUMN TaxDistrict,
          DROP COLUMN PropertyAddress;

