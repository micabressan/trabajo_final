IF OBJECT_ID('spCriaInsert') IS NOT NULL
	DROP PROCEDURE spCriaInsert


GO
CREATE PROCEDURE spCriaInsert(@tabela VARCHAR(50))
AS
	
	IF OBJECT_ID('sp_InsertProject') IS NOT NULL
		DROP PROCEDURE sp_InsertProject

	DECLARE @strFinal NVARCHAR(MAX);
	DECLARE @strCursor NVARCHAR(MAX) = '';
	DECLARE @strNoType NVARCHAR(MAX) = '';
	DECLARE @strRealColumn NVARCHAR(MAX) = '';
	DECLARE @cursor as CURSOR;

	SET @cursor = CURSOR FOR 
				SELECT COLUMN_NAME c, DATA_TYPE d, CHARACTER_MAXIMUM_LENGTH l
				FROM INFORMATION_SCHEMA.COLUMNS
				WHERE TABLE_NAME = @tabela;

	DECLARE @column NVARCHAR(MAX);
	DECLARE @realColumn NVARCHAR(MAX);
	DECLARE @data NVARCHAR(MAX);
	DECLARE @length NVARCHAR(MAX);
	DECLARE @primaryKey VARCHAR(MAX);
	DECLARE @restrictions NVARCHAR(MAX) = '';

	OPEN @cursor;

	FETCH NEXT FROM @cursor INTO @column, @data, @length;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		 IF (COLUMNPROPERTY(OBJECT_ID(@tabela),  @column , 'IsIdentity') = 1) 
					BEGIN
						FETCH NEXT FROM @cursor INTO @column, @data, @length;
					END;
			
			SET @restrictions = @restrictions + 
			'
				  IF (COLUMNPROPERTY(OBJECT_ID(''' + @tabela +''', ''U''), ''' + @column + ''', ''AllowsNull'') = 0) 
					BEGIN
						IF NULLIF(@'+ @column +', null) IS NULL
							BEGIN
								THROW 51000, ''O atributo nao pode ser null'', 1;
							END
						END;		
						'
		IF EXISTS (SELECT TABLE_NAME, COLUMN_NAME FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE WHERE CONSTRAINT_NAME LIKE 'FK%' AND (TABLE_NAME = @tabela) AND (COLUMN_NAME = @column))
			BEGIN
				SET @restrictions = @restrictions + 
				  '
				  IF (COLUMNPROPERTY(OBJECT_ID(''' + @tabela +''', ''U''), ''' + @column + ''', ''AllowsNull'') = 0)
				  BEGIN
					SELECT @referencedTable = (SELECT PK_Table FROM viewForeignKeyReferences WHERE FK_Column = ''' + @column + ''' and FK_Table = ''' + @tabela + ''');
					SELECT @referencedColumn = (SELECT PK_Column FROM viewForeignKeyReferences WHERE FK_Column = ''' + @column + ''' and FK_Table =  ''' + @tabela + ''');
	
					EXEC(''DECLARE @recordCount int;  
							  SELECT @recordCount = (SELECT COUNT(*) FROM ['' + @referencedTable + '']  WHERE ['' +  @referencedColumn + ''] = ''''''+ @'+ @column +' + '''''');
							  IF(@recordCount = 0)
								BEGIN
									THROW 51001, ''''O atributo não existe'''', 1;
								END
							  '');
				   END;
				  		
				  '
			END;
		SET @strNoType = @strNoType + ' @' + @column + ',';
		SET @strRealColumn = @strRealColumn + ' [' + @column + '],';
		IF(@length) IS NOT NULL
			SET @strCursor = @strCursor + ' @' + @column + ' ' + @data + ' (' + @length + '),';
		ELSE
			SET @strCursor = @strCursor + ' @' + @column + ' ' + @data + ',';
		FETCH NEXT FROM @cursor INTO @column, @data, @length;
	END
	CLOSE @cursor;
	DEALLOCATE @cursor;
	SET @strCursor = LEFT(@strCursor, LEN(@strCursor) - 1); 
	SET @strNoType = LEFT(@strNoType, LEN(@strNoType) - 1); 
	SET @strRealColumn = LEFT(@strRealColumn, LEN(@strRealColumn) - 1); 

	SET @strFinal = N' CREATE PROCEDURE sp_insert' + @tabela + ' (' + @strCursor + ')' + 
	' AS 
	BEGIN
		DECLARE @referencedTable NVARCHAR(128) = '''';
		DECLARE @referencedColumn NVARCHAR(128) = '''';
	' + @restrictions + '
	INSERT INTO [' + @tabela + '] (' + @strRealColumn + ') 
	VALUES (' + @strNoType + ')
	END';

	EXEC sp_executesql @strFinal;
GO