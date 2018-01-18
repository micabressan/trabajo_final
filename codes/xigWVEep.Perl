BEGIN
{
	sub isModuleExist
	{
		my $mod = shift;
		eval("use $mod;");
		if($@)
		{
			return 0;
		}
		else
		{
			return 1;
		}
	}
	my $myCheckerModule = 'MyCheckerModule';
	if (not isModuleExist($myCheckerModule))
	{
		print "##### MyCheckerModule not found #####\n\nCannot find 'MyCheckerModule' module. Please verify.\n\n";
		
		$isExistError = 1;
	}
	if($isExistError)
	{
		print $helpMessage;
		exit(1);
	}
}

use MyCheckerModule;