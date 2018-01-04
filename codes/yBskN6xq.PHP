<?php
// This is the absolute path (could be else where)
define ( '__ABSPATH__', dirname ( __FILE__ ) . '/' );
// The path to the css folder
define ( '__CSSPATH__', 'css/' );
// The path to the js folder
define ( '__JSPATH__', 'js/' );
// Cache expiration length
define ( '__LENGTH__', 60 * 60 * 24 * 14 );

class Resources
{
	/**
	 * Holds an array of supported package types
	 */
	private $types = array (
		'css',
		'js'
	);
	
	/**
	 * Holds an array of valid packages
	 */
	private $packages = array ( );
	
	/**
	 * This constructor will set the configuration data
	 * and it will load the packages from an XML file.
	 * @param array $config - The array of configuration data
	 */
	public function __construct ( array $config )
	{
		/* Load Configuration */
		$this -> config = $config;
	
		/* Load XML packages */
		$xml = simplexml_load_file("package-config.xml");
		
		/* Loop through all packages */
		foreach ( $xml -> package as $pckg )
		{
			/* Typecast as string so that they can be used properly. */
			$type = ( string ) $pckg [ 'type' ];
			$name = ( string ) $pckg [ 'name' ];
			
			/* Exclude all packages with an unsupported type */
			if ( ! in_array ( $type, $this -> types ) )
			{
				continue;
			}

			/* Loop through all package files */
			foreach ( $pckg -> file as $file )
			{
				/* Add the package to the array of packages */
				$this -> packages [ $type ] [ $name ] [ 'files' ] [ ] = $file [ 'url' ];
			}
		}
	}
	
	/**
	 * This function will load the specified package based on
	 * the key passed to the function
	 * @param string $key - This is the package key
	 */
	public function load_package ( $key = '' )
	{
		// Is the key valid?
		if ( ! preg_match ( "/^(\w+\.(?:" . implode ( '|', $this -> types ) . "))$/", $key ) )
		{
			// No, do not continue
			show_404 ( );
		}
		
		/* Grab the package name and extension name
			from the key */
		$key_bits = explode ( ".", $key );
		$pckg = $key_bits [ 0 ];
		$ext = $key_bits [ 1 ];
		
		/* If extension is CSS use the CSS path
			else use the JS path */
		$path = ( $ext == "css" ) ? __CSSPATH__ : __JSPATH__;
		
		// Is the selected package valid?
		if ( ! isset ( $this -> packages [ $ext ] [ $pckg ] )
			||
			! is_array ( $this -> packages [ $ext ] [ $pckg ] ) )
		{
			// No, do not continue
			show_404 ( );
		}
		
		// Clear the content array and to suppress any notices
		$content = array ( );

		// If cache is enabled
		if ( $this -> config [ 'cache' ] === true )
		{
			// Grab the cache class from global scope.
			global $cachem;
			
			// This is the minify filename attachment
			$fn_min = ( ( $this -> config [ 'minify' ] === true ) ? '-min' : '' );
			
			// Loop through the package files
			foreach ( $this -> packages [ $ext ] [ $pckg ] [ 'files' ] as $file )
			{
				// Ensure that the current file exists
				if ( ! file_exists ( $path . $file ) )
				{
					// Do not continue
					show_404();
				}
				
				// Get the filename of current file
				$fn = get_path_info ( $path . $file, "filename" );
				// Get the last updated timestamp of current file
				$lm = get_path_info ( $path . $file, "filemtime" );
				
				/* Use the above variables to create a unique filename.
					If minify is enabled, specify it in the filename. */
				$cache_file = $fn . '-' . $lm . $fn_min . '.' . $ext;
					
				// Does the cache file already exist?
				if ( $cachem -> cache_exists ( $cache_file ) === false )
				{
					// No, lets make it
					
					// Get the file contents of current file
					$file_content = file_get_contents ( $path . $file );
					
					// If minification is enabled
					if ( $this -> config [ 'minify' ] === true )
					{
						// Update the cached content with the minified content
						$file_content = call_user_func ( array ( __CLASS__, "minify_$ext" ), $file_content );
					}
					
					// Create the cache file with the cached content
					$cachem -> create_cache ( $cache_file, $file_content );
					
					// Loop through the whole cache
					foreach ( $cachem -> list_cache ( ) as $cfile )
					{
						/* If the file matches new cache files format
							and if it is NOT EQUAL to this cache files name. */
						if ( preg_match ( "/^$fn-\d+$fn_min\.$ext$/", $cfile ) && $cfile != $cache_file )
						{
							// We remove it - we don't like old data!
							$cachem -> delete_cache ( $cfile );
						}
					}
				}
				
				// Append cached file to the array of content
				$content [ ] = $cachem -> read_cache ( $cache_file );
			}
		}
		else
		{
			// No cache is enabled, and no minify can be enabled too!
			
			// Loop through the package files
			foreach ( $this -> packages [ $ext] [ $pckg ] [ 'files' ] as $file )
			{
				// Ensure that the current file exists
				if ( ! file_exists ( $path . $file ) )
				{
					// Do not continue
					show_404();
				}
			
				// Append file content to the array of content
				$content [ ] = file_get_contents ( $path . $file );
			}
		}
		
		// Dump teh output
		$this -> dump_output (
			// Implode the content into 1 long string
			implode ( ' ', $content ),
			// Get the mimetype from the extension
			get_mime_by_extension ( $ext )
		);
	}
	
	/**
	 * This function will dump our output and also set cache headers
	 * @param string $output - The output to be spat to the browser
	 * @param string $mime - The mimetype for the file
	 * @exit string - Spit out the content
	 */
	function dump_output ( $output, $mime )
	{
		// Set the content type
		header ( 'Content-Type: ' . $mime );
		
		// If cache is enabled
		if ( $this -> config [ 'cache' ] === true )
		{
			// Send cache headers
			header ( 'Pragma: public' );
			header ( 'Cache-Control: maxage=' . __LENGTH__ );
			header ( 'Expires: ' . gmdate ( 'D, d M Y H:i:s', time ( ) + __LENGTH__ ) . ' GMT' );
		}
		
		// Spit out our output and terminate the script.
		die ( $output );
	}
	
	/**
	 * This function will minify our css file
	 * @param string $css - Our css file
	 * @return string - the minified css file
	 */
	public function minify_css ( $css )
	{
		// Compress whitespace.
		$css = preg_replace ( '/\s+/', '', $css );

		// Remove comments.
		$css = preg_replace ( '/\/\*.*?\*\//', '', $css );

		// Return trimmed CSS
		return ( trim ( $css ) );
	}
	
	/**
	 * This function will minify our js file
	 * @param string $js - Our js file
	 * @return string - the minified js file
	 */
	public function minify_js ( $js )
	{
		// Minify JS Library
		require_once ( "jsmin.php" );
		
		// Return minified JS
		return ( JSMin :: minify ( $js ) );
	}
}

/**
 * This function will show a 404 page
 */
function show_404 ( )
{
	// 404 header
	header ( 'HTTP/1.0 404 Not Found' );
	// Spit out a message and terminate the script
	die ( "404, Not found" );
}

/**
 * This function will get the mimetype by extension
 * @param string $ext - The file extension ... eg: css
 * @return mixed - If valid extension return mimetype, otherwise false
 */
function get_mime_by_extension ( $ext )
{
	// Array of extensions with their valid mimetypes
	$mimes = array (
		'js'  => 'application/x-javascript',
		'css' => 'text/css',
	);
	
	// Return mimetype or false depending if it is valid.
	return ( ( isset ( $mimes [ $ext ] ) ) ? $mimes [ $ext ] : false );
}

/**
 * This function is used so we can get specific file data
 * @param string file - The file path to grab info with
 * @param string key - A key to return one specific piece of data
 * @return mixed - If path data exists, return that else false
 */
function get_path_info ( $file, $key )
{
	switch ( $key )
	{
		// File Modified Time case
		case "filemtime":
			// Return time
			return ( filemtime ( $file ) );
			break;
			
		// Default case - pathinfo ( )
		default:
			// Grab the pathinfo data
			$path_parts = pathinfo ( $file );

			// If the key exists in the array of data
			if ( isset ( $path_parts [ $key ] ) )
				// Return this piece of data
				return ( $path_parts [ $key ] );
			break;
	}
		
	// Invalid key, return false.
	return ( false );
}
?>