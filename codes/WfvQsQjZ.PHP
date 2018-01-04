
/** @cond file_level_code */
// Implicit group for all visitors
$wgGroupPermissions['*']['createaccount']    = true;
$wgGroupPermissions['*']['read']             = true;
$wgGroupPermissions['*']['edit']             = false;
$wgGroupPermissions['*']['createpage']       = false;
$wgGroupPermissions['*']['createtalk']       = true;
$wgGroupPermissions['*']['writeapi']         = true;
//$wgGroupPermissions['*']['patrolmarks']      = false; // let anons see what was patrolled

// Implicit group for all logged-in accounts
$wgGroupPermissions['user']['move']             = false;
$wgGroupPermissions['user']['move-subpages']    = false;
$wgGroupPermissions['user']['move-rootuserpages'] = false; // can move root userpages
//$wgGroupPermissions['user']['movefile']         = true;	// Disabled for now due to possible bugs and security concerns
$wgGroupPermissions['user']['read']             = true;
$wgGroupPermissions['user']['edit']             = false;
$wgGroupPermissions['user']['createpage']       = false;
$wgGroupPermissions['user']['createtalk']       = true;
$wgGroupPermissions['user']['writeapi']         = true;
$wgGroupPermissions['user']['upload']           = false;
$wgGroupPermissions['user']['reupload']         = false;
$wgGroupPermissions['user']['reupload-shared']  = false;
$wgGroupPermissions['user']['minoredit']        = false;
$wgGroupPermissions['user']['purge']            = false; // can use ?action=purge without clicking "ok"
$wgGroupPermissions['user']['sendemail']        = false;

// Implicit group for accounts that pass $wgAutoConfirmAge
$wgGroupPermissions['autoconfirmed']['autoconfirmed'] = true;

// Users with bot privilege can have their edits hidden
// from various log pages by default
$wgGroupPermissions['bot']['bot']              = true;
$wgGroupPermissions['bot']['autoconfirmed']    = true;
$wgGroupPermissions['bot']['nominornewtalk']   = true;
$wgGroupPermissions['bot']['autopatrol']       = true;
$wgGroupPermissions['bot']['suppressredirect'] = true;
$wgGroupPermissions['bot']['apihighlimits']    = true;
$wgGroupPermissions['bot']['writeapi']         = true;
#$wgGroupPermissions['bot']['editprotected']    = true; // can edit all protected pages without cascade protection enabled

// Most extra permission abilities go to this group
$wgGroupPermissions['sysop']['block']            = true;
$wgGroupPermissions['sysop']['createaccount']    = true;
$wgGroupPermissions['sysop']['delete']           = true;
$wgGroupPermissions['sysop']['bigdelete']        = true; // can be separately configured for pages with > $wgDeleteRevisionsLimit revs
$wgGroupPermissions['sysop']['deletedhistory']   = true; // can view deleted history entries, but not see or restore the text
$wgGroupPermissions['sysop']['deletedtext']      = true; // can view deleted revision text
$wgGroupPermissions['sysop']['undelete']         = true;
$wgGroupPermissions['sysop']['editinterface']    = true;
$wgGroupPermissions['sysop']['editusercss']      = true;
$wgGroupPermissions['sysop']['edituserjs']       = true;
$wgGroupPermissions['sysop']['import']           = true;
$wgGroupPermissions['sysop']['importupload']     = true;
$wgGroupPermissions['sysop']['move']             = true;
$wgGroupPermissions['sysop']['move-subpages']    = true;
$wgGroupPermissions['sysop']['move-rootuserpages'] = true;
$wgGroupPermissions['sysop']['patrol']           = true;
$wgGroupPermissions['sysop']['autopatrol']       = true;
$wgGroupPermissions['sysop']['protect']          = true;
$wgGroupPermissions['sysop']['proxyunbannable']  = true;
$wgGroupPermissions['sysop']['rollback']         = true;
$wgGroupPermissions['sysop']['trackback']        = true;
$wgGroupPermissions['sysop']['upload']           = true;
$wgGroupPermissions['sysop']['reupload']         = true;
$wgGroupPermissions['sysop']['reupload-shared']  = true;
$wgGroupPermissions['sysop']['unwatchedpages']   = true;
$wgGroupPermissions['sysop']['autoconfirmed']    = true;
$wgGroupPermissions['sysop']['upload_by_url']    = true;
$wgGroupPermissions['sysop']['ipblock-exempt']   = true;
$wgGroupPermissions['sysop']['blockemail']       = true;
$wgGroupPermissions['sysop']['markbotedits']     = true;
$wgGroupPermissions['sysop']['apihighlimits']    = true;
$wgGroupPermissions['sysop']['browsearchive']    = true;
$wgGroupPermissions['sysop']['noratelimit']      = true;
$wgGroupPermissions['sysop']['movefile']         = true;
$wgGroupPermissions['sysop']['unblockself']      = true;
$wgGroupPermissions['sysop']['suppressredirect'] = true;
$wgGroupPermissions['sysop']['writeapi']         = true;
$wgGroupPermissions['sysop']['edit']             = true;
$wgGroupPermissions['sysop']['createpage']       = true;
#$wgGroupPermissions['sysop']['mergehistory']     = true;
$wgGroupPermissions['sysop']['move']             = true;
$wgGroupPermissions['sysop']['move-subpages']    = true;
$wgGroupPermissions['sysop']['move-rootuserpages'] = true; // can move root userpages

$wgGroupPermissions['editor']['delete']           = true;
$wgGroupPermissions['editor']['edit']             = true;
$wgGroupPermissions['editor']['createpage']       = true;
$wgGroupPermissions['editor']['move']             = true;
$wgGroupPermissions['editor']['move-subpages']    = true;
$wgGroupPermissions['editor']['move-rootuserpages'] = true; // can move root userpages
$wgGroupPermissions['editor']['bigdelete']        = true; // can be separately configured for pages with > $wgDeleteRevisionsLimit revs
$wgGroupPermissions['editor']['deletedhistory']   = true; // can view deleted history entries, but not see or restore the text
$wgGroupPermissions['editor']['deletedtext']      = true; // can view deleted revision text
$wgGroupPermissions['editor']['undelete']         = true;
$wgGroupPermissions['editor']['move']             = true;
$wgGroupPermissions['editor']['move-subpages']    = true;
$wgGroupPermissions['editor']['move-rootuserpages'] = true;
$wgGroupPermissions['editor']['protect']          = true;
$wgGroupPermissions['editor']['rollback']         = true;
$wgGroupPermissions['editor']['trackback']        = true;
$wgGroupPermissions['editor']['upload']           = true;
$wgGroupPermissions['editor']['reupload']         = true;
$wgGroupPermissions['editor']['reupload-shared']  = true;
$wgGroupPermissions['editor']['unwatchedpages']   = true;
$wgGroupPermissions['editor']['autoconfirmed']    = true;
$wgGroupPermissions['editor']['upload_by_url']    = true;
$wgGroupPermissions['editor']['markbotedits']     = true;
$wgGroupPermissions['editor']['browsearchive']    = true;
$wgGroupPermissions['editor']['movefile']         = true;
$wgGroupPermissions['editor']['suppressredirect'] = true;
$wgGroupPermissions['editor']['writeapi']         = true;
#$wgGroupPermissions['sysop']['mergehistory']     = true;

// Permission to change users' group assignments
$wgGroupPermissions['bureaucrat']['userrights']  = true;
$wgGroupPermissions['bureaucrat']['noratelimit'] = true;