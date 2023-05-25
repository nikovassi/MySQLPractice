CREATE FUNCTION udf_Pow(@Base int, @Exp int)
RETURNS bigint
AS
BEGIN
	DECLARE @result bigint = 1;

	WHILE (@Exp > 0)
	BEGIN
		SET @result = @result * @Base
		SET @Exp = @Exp - 1;
	END

	RETURN @result;

END;

SELECT [dbo].[udf_Pow](2,10), POWER(2,10);


