use Win32::TieRegistry;
$Registry->Delimiter("/");
$perlKey = $Registry->{"HKEY_CLASSES_ROOT/Perl/"};
$perlKey->{"shellex/"} = {
	"DropHandler/" => {
		"/"=>"{86C86720-42A0-1069-A2E8-08002B30309D}"
	}};