DECLARE @path varchar(100)
DECLARE @day int
DECLARE @date varchar(30)
DECLARE @cmd varchar(250)
DECLARE @DeleteDate datetime
 
---- PARAMETRE TANIMLAMALARI ----
 
SET @path = 'D:\LOGO YEDEK'  -- Backuplarýn saklanacaðý klasör yolu.
SET @day = 30     -- Verilen gün sayýsýndan eski backuplarý siler.
 
---- PARAMETRE TANIMLAMALARI ----
 
SET @date = CONVERT(varchar(16),GETDATE(), 120)
print @date + ' Backup Log'
print ''
SELECT @date = REPLACE(@date,':','')
SELECT @date = REPLACE(@date,' ','')
SELECT @date = REPLACE(@date,'-','')
 
SET @cmd = 'IF DB_ID(''?'')<>2 BACKUP DATABASE [?] TO DISK = ''' + @path + '\?_backup_' +@date+ '.bak'' WITH INIT'
EXEC sp_msforeachdb @cmd
 
SET @DeleteDate = DateAdd(day, -@day, GetDate())
EXECUTE master.sys.xp_delete_file 0, @path, N'bak', @DeleteDate, 0
GO