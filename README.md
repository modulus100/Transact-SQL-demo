# Transact-SQL-Demo

These scripts have illustrative purpose of my basic T-SQL skills. Here I made User Defined Procedure that searhes for the rows within a table that have all provided paramaters. Demo_Search has 3 inputs, the first is a string with search parameters, the second is a string with table name and the third is a seporator for the first input string.

### Instructions

Open SQL Server Management Studio at first and execute scripts in a following order:

- GuitarShopP_Init.sql -> Creates the databse with table and fills it.

- Demo_Search.sql      -> Executes the User Defined Procedure.

- Demo.sql             -> Applies the procedure for GuitarShop database and shows the result.
