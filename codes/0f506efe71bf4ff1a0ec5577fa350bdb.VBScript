Option Explicit
' migrations script for the database

'======  nu ruller vi databasen op til nyeste migration ====

'Det forudsættes at der kan oprettes forbindelse til database

'Opret forbindelse til database


'Er migration tabellen oprettet
'  hvis nej - så opret denne tabel
'  
'Læs listen af alle migrations i databasen i sorteret rækkefølge, 
'  for at kunne finde den næste migration i filsystemet
'  noter navn_paa_seneste_db_migration
'  
'Læs alle migration filer ind i en sorteret liste

'løb listen af navn_paa_fil_migration igennem, 
'  hvis navn_paa_fil_migration er større end navn_paa_seneste_db_migration
'    så læs "up" noden i xml filen
'       eksekver indholdet af up noden op i mod databasen
'       skriv navnet på navn_paa_fil_migration til migration tabellen
'       sæt navn_paa_seneste_db_migration til navn_paa_fil_migration
'  gå til næste navn_paa_fil_migration

dim command, migration_id, level_source
dim m_logger: set m_logger = New Logger
m_logger.init "migration.txt"


if wscript.arguments.count = 2 then
    command = wscript.arguments(0)
    
    select case command
    case "up", "down"
		migration_id = wscript.arguments(1)
	case "level"
		level_source = wscript.arguments(1)
    case else
        ShowHelp
    end select
else
    ShowHelp
end if

stop

dim m_migrations: set m_migrations = New Migrations
m_migrations.OnLog.AddHandler "LogMessage"
m_migrations.OnError.AddHandler "LogError"
m_migrations.OnScript.AddHandler "LogScript"

m_migrations.Init


select case command
case "up"
    m_migrations.RollUp migration_id
case "down"
    m_migrations.RollDown migration_id
case "level"
	select case level_source
	case "database"
		wscript.echo "Database level: " & m_migrations.LevelDatabase
	case "file"
		wscript.echo "File level: " & m_migrations.LevelFile
	end select
end select

set m_migrations = nothing
set m_logger = nothing


Public sub ShowHelp()
    wscript.Echo "Doing migrations to the database"
    wscript.echo
    wscript.echo "Usage: migrate up <migration_id>"
	wscript.echo "Usage: migrate down <migration_id>"
	wscript.echo "Usage: migrate level database"
	wscript.echo "Usage: migrate level file"
	
    wscript.quit(1)
End sub

Public Sub LogScript(message)
	m_logger.LogEntry message
End Sub

Public Sub LogMessage(message)
	m_logger.LogEntry message
	wscript.echo message
End Sub

Public Sub LogError(message)
	m_logger.LogEntry message
	wscript.echo message
End Sub

Class Migrations
    private m_cnn, m_fso
    private m_dic_file_migrations, m_dic_database_migrations
	private m_ini_file
	public OnLog, OnError, OnScript

    Private sub Class_Initialize()
		set OnLog = New EventHandler
		set OnError = New EventHandler
		set OnScript = New EventHandler
		
		set m_ini_file = New IniFile
		m_ini_file.init "config.ini"
		
        dim connection_string: connection_string = m_ini_file.ConnectionString
		set m_cnn = CreateObject("ADODB.Connection")
        m_cnn.Open connection_string
        m_cnn.CommandTimeout = 600
        set m_fso = CreateObject("Scripting.FileSystemObject")
		
    end sub

    Public Sub Init()
        PrepareMigrationTable
        ReadDatabaseMigrations
        ReadFileMigrations(m_ini_file.MigrationFilePath)
    End Sub
    
    Public Property Get LevelDatabase()
		if m_dic_database_migrations.count = 0 then
			LevelDatabase = "N/A"
		else
			dim keys: keys = m_dic_database_migrations.Keys
			LevelDatabase = keys(ubound(keys))
		end if
	end property
	
	Public Property Get LevelFile()
		if m_dic_file_migrations.count = 0 then
			LevelFile = "N/A"
		else
			dim keys: keys = m_dic_file_migrations.Keys
			LevelFile = keys(ubound(keys))
		end if
	End Property
	
	
	
	
    Public Sub RollUp(end_migration_id)
		OnLog.Invoke Array("Executing RollUp " & end_migration_id)
		
        if not m_dic_file_migrations.Exists(CStr(end_migration_id)) then
            OnLog.Invoke Array("File migration " & end_migration_id & " does not exist")
            OnLog.Invoke Array("No migrations will be done")
            exit sub
        end if

        ' hvis de migrations som den har tænkt sig at rulle på
        dim file_keys: file_keys = m_dic_file_migrations.Keys
        dim file_key
        dim step_keys, step_key
        dim sql_up_script
        
        dim o_migration, do_rollback, i, result
        do_rollback = false
        
        
        for i = 0 to ubound(file_keys)
            file_key = file_keys(i)
            
            ' find ud af om denne file migration findes i database
            if not m_dic_database_migrations.Exists(file_key) then
                set o_migration = m_dic_file_migrations.Item(CStr(file_key))
                OnLog.Invoke Array("Migrate: " & o_migration.Id)
				
                step_keys = o_migration.UpSteps.keys
                
                m_cnn.BeginTrans 
                on error resume next
                for each step_key in step_keys
                    sql_up_script = o_migration.UpSteps.Item(CStr(step_key))
					OnScript.Invoke Array(sql_up_script)
					
                    m_cnn.Execute sql_up_script, result
					OnScript.Invoke Array("Result: " & Result)
					
                    if err.number <> 0 then exit for
                next
                m_cnn.Execute "insert into migrations(patch_level) select '" & file_key & "'"
                
                if err.number <> 0  then
                    OnLog.Invoke Array("ERR: failed at step (" & step_key & ")" & vbCrLf & err.Description)
                    m_cnn.RollbackTrans 
                    exit sub
				elseif m_cnn.errors.count > 0 then
					ShowDBErrors OnError, step_key, m_cnn.errors
					m_cnn.RollbackTrans
					exit sub
                end if
				on error goto 0
				m_cnn.CommitTrans 
				OnLog.Invoke Array("Migration " & file_key  & " are inserted")
            end if
            
            if file_key = end_migration_id then
                exit for
            end if
        next
    End Sub
    
	
	private sub ShowDBErrors(error_handler, step_key, Errors)
		dim o_error
		error_handler.Invoke Array("ERROR at step (" & step_key & ") while committing to database")
		error_handler.Invoke Array(string(40, "-"))
		for each o_error in errors
			error_handler.Invoke Array(o_error.description)
		next
		error_handler.Invoke Array(string(40, "-"))
	end sub 
    
    Public Sub RollDown(end_migration_id)
		if not m_dic_database_migrations.Exists(CStr(end_migration_id)) then
            OnLog.Invoke Array("The end migration " & end_migration_id & " do not exist in the database")
            OnLog.Invoke Array("No rolling back will be done")
            exit sub
        end if
        
        dim database_keys: database_keys = m_dic_database_migrations.Keys 
        dim database_key
        dim o_migration, sql_down_script, i, result
        dim step_keys, step_key
        
        for i = ubound(database_keys) to 0 step -1
            database_key = database_keys(i)
			set o_migration = m_dic_file_migrations.Item(CStr(database_key))
            OnLog.Invoke Array("Rolling back migration: " & o_migration.Id)
            step_keys = o_migration.DownSteps.keys

            m_cnn.BeginTrans 
            on error resume next
            for each step_key in step_keys
                sql_down_script = o_migration.DownSteps.Item(CStr(step_key))
				OnScript.Invoke Array(sql_down_script)
                m_cnn.Execute sql_down_script
				OnScript.Invoke Array("Result: " & result)
                if err.number <> 0 then exit for
            next
            m_cnn.Execute "delete from migrations where patch_level = '" & database_key & "'"
            
			if err.number <> 0  then
				OnError.Invoke Array("ERR: failed at step (" & step_key & ")" & vbCrLf & err.Description )
				m_cnn.RollbackTrans 
				exit sub
			elseif m_cnn.errors.count > 0 then
				ShowDBErrors OnError, step_key, m_cnn.errors
				m_cnn.RollbackTrans
				exit sub
			end if
			on error goto 0
			m_cnn.CommitTrans 
			OnLog.Invoke Array("Migration " & database_key  & " are rolled back")

            if database_key = end_migration_id then
                exit for
            end if
        next
    End Sub
    
    
    Public Sub PrepareMigrationTable()
        if m_cnn.Execute("select count(*) from sysobjects where name = 'migrations'")(0) = 0 then
            OnLog.Invoke Array("Creating table for migrations")
            m_cnn.Execute "create table migrations(patch_level varchar(13) not null)"
			m_cnn.execute "ALTER TABLE migrations ADD CONSTRAINT PK_name PRIMARY KEY CLUSTERED (patch_level	) ON [PRIMARY]"
        end if
    End Sub
    
    Public Sub ReadDatabaseMigrations()
        set m_dic_database_migrations = CreateObject("Scripting.Dictionary")
        dim rs: set rs = m_cnn.Execute("select * from migrations order by patch_level")
        OnLog.Invoke Array("Reading migrations from database")
        dim migration_id
        do while not rs.eof 
            migration_id = rs("patch_level").value
            m_dic_database_migrations.add migration_id, migration_id
            rs.movenext
        loop
        rs.close
        set rs = nothing
    End Sub
    
    
    Public sub ReadFileMigrations(path)
        dim dic: set dic = CreateObject("Scripting.Dictionary")
        dim file
        OnLog.Invoke Array("Reading migrations from files")
        
        for each file in m_fso.GetFolder(path).Files
            if m_fso.GetExtensionName(file.name) = "xml" then
                dic.Add m_fso.GetBaseName(file.name), file.name
            end if
        next
        
        dim file_name_array: file_name_array = dic.Keys 
        set dic = nothing
        
        Sort file_name_array
        
        set m_dic_file_migrations = CreateObject("Scripting.Dictionary")
        dim i, o_migration, migration_id
        for i = 0 to ubound(file_name_array)
            migration_id = file_name_array(i)
            set o_migration = New Migration
            o_migration.Init migration_id, path
            m_dic_file_migrations.Add migration_id, o_migration
        next
    End Sub

    
    Private sub Class_Teminate()
        m_cnn.Close        
        set m_cnn = nothing
        set m_fso = nothing
    End sub
    
    
    
End Class


Class Migration
    private m_migration_id, m_migration_file_name
    private m_dic_up_steps, m_dic_down_steps
    
    Private sub Class_Initialize()
    End sub
    
    Public Sub Init(migration_id, path)
        m_migration_id = migration_id
        m_migration_file_name = path & "\" & m_migration_id & ".xml"
        
        dim xml_doc: set xml_doc = CreateObject("MSXML2.DOMDocument")
        if not xml_doc.load(m_migration_file_name) then
			wscript.echo "ERROR reading xml document " & m_migration_file_name
			wscript.quit(1)
			Exit sub
		end if
        
        dim xml_up_steps: set xml_up_steps = xml_doc.selectNodes("/migration/up/step")
        dim xml_down_steps: set xml_down_steps = xml_doc.selectNodes("/migration/down/step")
        
        dim step_node
        
        set m_dic_up_steps = CreateObject("Scripting.Dictionary")
        for each step_node in xml_up_steps
            m_dic_up_steps.add CStr(m_dic_up_steps.count), step_node.text
        next
        
        set m_dic_down_steps = CreateObject("Scripting.Dictionary")
        for each step_node in xml_down_steps
            m_dic_down_steps.add CStr(m_dic_down_steps.count), step_node.text
        next
        
        set xml_doc = nothing
    End sub
    
    Public Property Get FileName()
        FileName = m_migration_file_name
    End Property
    
    Public Property Get Id()
        Id = m_migration_id
    end Property
    
    Public Property get UpSteps()
        set UpSteps = m_dic_up_steps
    End Property
    
    Public Property Get DownSteps()
        set DownSteps = m_dic_down_steps
    End Property
    
End Class


Sub Sort( ByRef myArray )
    Dim i, j, strHolder

    For i = ( UBound( myArray ) - 1 ) to 0 Step -1
        For j= 0 to i
            If UCase( myArray( j ) ) > UCase( myArray( j + 1 ) ) Then
                strHolder        = myArray( j + 1 )
                myArray( j + 1 ) = myArray( j )
                myArray( j )     = strHolder
            End If
        Next
    Next 
End Sub


Class IniFile
	private m_fso, m_ini_file_path, m_dic_values
	
	private sub Class_Initialize()
		set m_fso = CreateObject("Scripting.FileSystemObject")
		set m_dic_values = CreateObject("Scripting.Dictionary")
	end sub
	
	private sub Class_Teminate()
		set m_fso = nothing
		set m_dic_values = nothing
	End sub 
	
	Public Sub Init(ini_file_path)
		m_ini_file_path = ini_file_path
		
		dim line, pl_equal_sign, name, value
		dim stream: set stream = m_fso.OpenTextFile(m_ini_file_path)
		do while not stream.AtEndOfStream
			line = stream.readline
			if left(line, 1) <> "#" then
				pl_equal_sign = instr(line, "=")
				name = trim(left(line, pl_equal_sign-1))
				value = trim(mid(line, pl_equal_sign+1))
				m_dic_values(name) = value
			end if
		loop
	end Sub
	
	Public Property Get ConnectionString()
		ConnectionString = m_dic_values("ConnectionString")
	End Property 
	
	Public Property Get MigrationFilePath()
		MigrationFilePath = m_dic_values("MigrationFilePath")
	End Property 
	
End Class



Class Logger
    private m_fso, m_log_file
    
    private sub Class_Initialize()
        set m_fso = CreateObject("Scripting.FileSystemObject")
    end sub

    private sub Class_Terminate()
		LogEntry "Logger ended"
		m_log_file.close
        set m_log_file = nothing
    end sub
    
    '@file_path: The full path to the file with logs
    Public sub init(file_path)
		if m_fso.FileExists(file_path) then
			m_fso.deletefile file_path, true
		end if
        const ForAppending = 8
        set m_log_file = m_fso.OpenTextFile(file_path, ForAppending, true)
        LogEntry "Logger started"
    end sub
    
    Public Sub LogEntry(message)
        m_log_file.writeline now & vbTab & message
    End sub
    
End Class


Class EventHandler
    Private m_dic_handlers
    
    Private Sub Class_Initialize()
        set m_dic_handlers = CreateObject("Scripting.Dictionary")
    End Sub
    
    Public Sub AddHandler(HandlerName)
        m_dic_handlers.Add HandlerName, HandlerName
    End Sub 
    
    Public Sub RemoveHandler(HandlerName)
        m_dic_handlers.Remove HandlerName
    End Sub
    
    Public Sub Invoke(param_array)
        dim handler, parameters, command, i

        if ubound(param_array) = -1 then
            parameters = ""
        else
            for i = 0 to ubound(param_array)
                 if i > 0 then
                    parameters = parameters & """, """
                 end if

                 ' replace double quotes with two double quotes
                 ' to provent execute command to fail.
                 parameters = parameters & replace(param_array(i), """", """""")
            next
            parameters = """" & parameters & """"
        end if        
        
        for each handler in m_dic_handlers
            command = handler & " " & parameters
			
			' Remove all line breaks
			command = replace(command, vbCrLf, "")
			command = replace(command, vbLf, "")
            Execute command
        next
    End Sub
    
    Private Sub Class_Teminate()
        Set m_dic_handler = nothing
    End Sub 
End Class
