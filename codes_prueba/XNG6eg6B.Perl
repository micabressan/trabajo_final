#!/usr/bin/perl

# include things we need
use CGI qw/:standard/;

# make a new CGI object
#$q = CGI->new qw/:standard/;
print header,
        start_html('Brunto'),
        h1({-color=>red,-font=>'courier new'},"brunto"),
        start_form,
        "Navigation: ",
        popup_menu(-name=>'navbox',
                -values=>['Home','Status']),p,
        submit,
        end_form,
        hr,"\n";

#login form
print h2("Login"),
        start_form({-action=>"login.pl",-name=>"loginform"}),
        "\nUsername: ",
        textfield({-name=>uname, -id=>un}),br,
        "\nPassword: ",
        password_field({-name=>pword, -id=>pw}),br,"\n",
        hidden({-name=>buntro, -value=>remote_host()}),
        submit,
        end_form,
        hr,"\n";

if(param('navbox')){
        print "You are currently in ",em(param('navbox'));
}
print end_html;