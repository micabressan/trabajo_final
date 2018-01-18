use strict;
use warnings;
use HexChat qw(:all); 
use utf8;

my $Bleu = "\00302";
my $Norm = "\017";
my $Vert = "\00303";
my $Rouge = "\00304";


register( "Repondeur", "0.1","Repondeur de PV by Moya" );

hook_server("PRIVMSG",\&repondeur);
hook_print("Open Context",\&OpenPv);

my $Host;

sub repondeur {
    $_[0][0] =~ /@(.*?)$/;
    if (($1) && (substr($_[0][2],0,1) ne "#"))  {
        $Host = $1;
        $Host = "*!*@".$Host;
        my $List = scan_ignore_list();
        if ($List != 1) {
            if ($_[0][2] !~ /#/) {
                $_[0][0] =~ /:(.*?)!/;
                my $Nick = $1;
                my $Fcontext = find_context($Nick);
                if (!$Fcontext) {
                    prnt "- PV de $Vert$Nick$Norm -\ci".substr($_[1][3],1);
                    command("msg $Nick ⚠ Répondeur ⚠");
                    command("msg $Nick Désolé $Nick je ne réponds pas aux Pv's sans demande !");
                    command("msg $Nick Je ne suis pas dispo pour les rencontres, merci de vous abstenir !");
                    command("msg $Nick Tout abus sera signalé aux modérateurs.");
                    command("msg $Nick Conversation terminée.");
                    if (find_context($Nick)) {
                        set_context($Nick);
                        command('CLOSE', $Nick);
                    }
                    command("IGNORE $Host PRIV ");
                }
                return EAT_NONE;
            }
        } 
    } else { return EAT_ALL; }
}
sub OpenPv {
   my $Context = get_info("channel");
    my $S311 = hook_server('311',\&get_host);
    # set_context("EuropNet");
    if (substr($Context,0,1) ne "#") { command("whois $Context") } else { unhook($S311) }
    return EAT_HEXCHAT
}
sub get_host {
    my $UserHost = $_[0][5];
    if ($UserHost) {$UserHost = "*!*@".$UserHost}
    foreach my $sil (get_list("ignore")) {
        if ($sil->{"mask"} eq $UserHost) {
            command("UNIGNORE $UserHost");
        }
    }
    return EAT_NONE;
}
sub scan_ignore_list() {
    foreach my $sil (get_list("ignore")) {
        if ($sil->{"mask"} eq $Host) {
            return 1;
        }
    }
}