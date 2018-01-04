void CMyClass::Run()
{
    // Everything in here is run on its own thread
    try
    {
        mysqlpp::Connection conn( false );
        if( !conn.connect( SQL_DATABASE, SQL_SERVER, SQL_USERNAME, SQL_PASSWORD, SQL_PORT ) )
        {
            Error( "[SQL] Failed to connect to Listening Server, this game will not show up on the Online List!" );
            return;
        }

        // Get the NAT IP and add to Host info
        mysqlpp::Query query = conn.query();
        query << "SELECT USER();";
        mysqlpp::UseQueryResult res = query.use();
        mysqlpp::Row row = res.fetch_row();

        string sRawIP( row[0].c_str() );
        int nFirst = sRawIP.find_first_of( "@" );
        sRawIP.erase( 0, nFirst+1 );
               
        for( int i = 0, j = 0; true; i++ )
        {
            if( !strcmp( string( sRawIP[i] ), "-" ) )
                j++;

            if( j == 4 )
            {
                sRawIP.erase( i, sRawIP.size() );
                sRawIP.replace( "-", "." );
                string sFormatedIP( sRawIP.c_str() );
                Info( "[SQL] Formated IP: %s", sFormatedIP.c_str() );
                break;
            }
        }
       
        conn.disconnect();
    }
    catch( mysqlpp::BadQuery &e )
    {
        Error( "[SQL] Exception: %s", e.what() );
    }
}