#!/usr/bin/perl
use Pg;
use Env;
use IO::File;
use LWP;
use Time::HiRes qw(time);
use POSIX qw(strftime);
use strict;

my $handle;
my $pid = $$;
my $name = $0;
$name =~ /([^\/]+)$/;
$name = $1;

my $_t_ = time;
my $_date_ = strftime "%Y-%m-%d", localtime $_t_;
sysopen($handle, "/var/log/cgi/$_date_.$name.log", O_RDWR | O_CREAT);
seek($handle, 0, SEEK_END);

_log_('start');

my $conn = Pg::connectdb('dbname=ipt user=pgsql host=localhost port=5432 password=123');
if ( $conn->status != PGRES_CONNECTION_OK ) {
    _log_('cant connect to db');
    exit;
};
$conn->exec("set client_encoding to 'UTF8'");

my $res = $conn->exec('select * from send_email()');
my $i = $res->ntuples;

while ($i > 0) {
    my $id = $res->getvalue($i - 1, 0);
    my $msg = $res->getvalue($i - 1, 1);

    my $ua = LWP::UserAgent->new;
    my $req = HTTP::Request->new(POST => 'https://mailer.iptelefon.su/api/');
    $req->content_type('application/json');
    $req->content_encoding('UTF-8');
    $req->content($msg);

    _log_("try");
    _log_("$msg");

    my $hres = $ua->request($req);
    my $data = $hres->content;
    if ($hres->is_success) {
        $conn->exec("update event2user set pass = 1 where id_event2user = $id");
        _log_('success');
    } else {
        _log_('fail');
    };
    _log_("$data");

    $i--;
};

_log_('stop');


sub _log_ {
    my $_t_ = time;
    my $_date_ = strftime "%Y%m%d %H:%M:%S", localtime $_t_;
    $_date_ .= sprintf ".%03d", ($_t_ - int($_t_)) * 1000;

    my $_tmp_ = $$ . ' ' . $_date_ . ' ' . $_[0] . "\n";
    syswrite($handle, $_tmp_, length($_tmp_));
};