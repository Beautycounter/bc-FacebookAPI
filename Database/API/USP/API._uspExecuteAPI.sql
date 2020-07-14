
USE MailChimp

IF(SELECT TOP 1 1 FROM Sys.procedures p where name = '_uspExecuteAPI') IS NOT NULL
	DROP PROC API._uspExecuteAPI;
GO

CREATE PROC API._uspExecuteAPI
	@BQType VARCHAR(200)
AS BEGIN

	DECLARE 	
		 @LogID BIGINT = (SELECT ISNULL(MAX(LogID),0) + 1 FROM [API].[Logger])
		,@ProcName VARCHAR(500)= 'API._uspExecuteAPI ' + '''' + @BQType + ''''
	
	INSERT [API].[Logger] (LogID, [LogTimeStampUTC],[Process],[MessageStatusCode],[MessageText])
	SELECT @LogID, GETUTCDATE(), @ProcName, 0, 'Start'

	--create logging table variable 
	DECLARE @tbVar_Logger TABLE (
	     LogID BIGINT NOT NULL
		,LogTimeStampUTC DATETIMEOFFSET(3) DEFAULT GETUTCDATE()
		,Process VARCHAR(500) NOT NULL
		,MessageStatusCode INT NOT NULL
		,MessageText VARCHAR(MAX) NOT NULL
	);

	BEGIN TRANSACTION 

		--DROP TABLE #output_ 
		CREATE TABLE #output_ 
		(
			 row_ INT IDENTITY(1,1)
			,output_ VARCHAR(MAX)
		)
		--DECLARE @BQType VARCHAR(MAX) = 'Locations'
		DECLARE @Path_ VARCHAR(8000) = (SELECT Path_ FROM API.CmdshellExecutions WHERE BQTYPE = @BQType)
		DECLARE @Args_ VARCHAR(8000) = (SELECT Args_ FROM API.CmdshellExecutions WHERE BQTYPE = @BQType)

		--Print @Path_
		--Print @Args_
		--EXEC xp_cmdshell 'D:\SSIS\SquareAPI\SquareAPI.exe "Locations" "SERVER=localhost;Database=Square;UID=dataworker;PWD=dataworker1" "Locations.uspGetLocationsParameters"'
		DECLARE @Execution VARCHAR(8000) = 'EXEC xp_cmdshell ' + '''' + @path_ + ' ' + @Args_ + ''''
		PRINT @Execution
		INSERT #output_
		EXEC (@Execution)

		DECLARE 
			 @output VARCHAR(4000) = ''
			,@i INT = 1
		
		WHILE(@i < (Select MAX(row_) FROM #output_))
		BEGIN
		
			SET @output = @output + (SELECT ISNULL(output_,'') FROM #output_ WHERE row_ = @i) + CHAR(13)+CHAR(10)

		SET @i = @i + 1
		END 
		PRINT @output

		IF(@output not like '%Error%')
		BEGIN
			INSERT @tbVar_Logger
			SELECT @LogID, GETUTCDATE(), @ProcName, 0, 'API Call Successful|' + @output
		END

	COMMIT TRANSACTION
		
	--If Transaction failed
	IF(SELECT TOP 1 1 FROM @tbVar_Logger WHERE MessageText like '%Error%') IS NOT NULL
	BEGIN
		INSERT @tbVar_Logger
		SELECT @LogID, GETUTCDATE(), @ProcName, 1, 'ERROR|API Execution Error'
	END
		
	INSERT [API].[Logger] (LogID, [LogTimeStampUTC],[Process],[MessageStatusCode],[MessageText])
	SELECT * FROM @tbVar_Logger

	--complete log succesfully
	INSERT [API].[Logger] (LogID, [LogTimeStampUTC],[Process],[MessageStatusCode],[MessageText])
	SELECT @LogID, GETUTCDATE(), @ProcName, 0, 'Done'
END


--EXEC API._uspExecuteAPI 'Locations'
--SELECT * FROM [API].[Logger]
--