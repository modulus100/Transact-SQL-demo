USE [GuitarShop]
GO
/****** Object:  StoredProcedure [dbo].[Demo_Search]    Script Date: 6/25/2017 8:40:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

IF NOT EXISTS (
	SELECT * FROM sys.objects
	WHERE type = 'P' AND OBJECT_ID = OBJECT_ID('dbo.Demo_Search'))
	EXEC('CREATE PROCEDURE [dbo].[Demo_Search] AS BEGIN SET NOCOUNT ON; END')
GO

ALTER PROCEDURE [dbo].[Demo_Search]
	@search_text AS VARCHAR(1000),
	@table_name AS VARCHAR(1000) = 'Warehouse',
	@separator AS VARCHAR(1) = ' '
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    	-- Insert statements for procedure here
	DECLARE @words_count INT
	SET @words_count = ( SELECT COUNT(VALUE) FROM string_split(@search_text, @separator) );
	

	DECLARE @columns_names NVARCHAR(MAX)
	SET @columns_names = ( SELECT LEFT(column_name, LEN(column_name) - 1) FROM ( SELECT column_name + ', ' FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = @table_name FOR XML PATH ('')) c (column_name))

	DECLARE @global_condition nvarchar(MAX)
	SET @global_condition = (
		SELECT LEFT(condition, LEN(condition) - 1)
		FROM (
			SELECT 'OR ' + VALUE + ' LIKE ' + '''%''' + '+ temp.value +' + '''%''' + ' ' 
			FROM string_split(@columns_names, ',') temp
			 FOR XML PATH ('')
		) c (condition)
	)

	SET @global_condition = SUBSTRING(@global_condition, 3, LEN(@global_condition) + 3) 

	
	DECLARE @SQL NVARCHAR(MAX)
	SET @SQL = N'SELECT ' + @columns_names + ' FROM ( SELECT count(id) item_count,' + @columns_names + '
		FROM ' + @table_name + ', (
			SELECT VALUE
			FROM string_split(''' + @search_text + ''',''' + @separator + ''')
		) temp
		WHERE '+@global_condition+''' GROUP BY ' + @columns_names + ') rows WHERE item_count = ' + CONVERT(VARCHAR, @words_count)

	PRINT @sql
	EXECUTE sp_executesql @SQL

END
