package Billing::Controller::Privat24;
use Mojo::Base 'Mojolicious::Controller';
use XML::Fast;
use DateTime;

sub default
{
	my $self = shift;
	my $request = xml2hash($self->req->body);
	my $response = {"Transfer"=>{"-xmlns"=>"http://debt.privatbank.ua/Transfer", "-interface"=>"Debt", 
		"Data"=>{"-xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance"}}};
	$self->{check_query}=$self->{app}->{db}->prepare("select id, secondname, debet, kdebet from users where deleted=0 and mobile=?");
	#say $self->{app}->dumper($request);
	my $current_time = DateTime->now(time_zone => $self->{app}->{config}->{time_zone});
	if(defined($request->{"Transfer"}->{"-action"}))
	{
		if($request->{"Transfer"}->{"-action"} eq "Search")
		{
			$response->{"Transfer"}->{"-action"}="Search";
			if($request->{"Transfer"}->{"Data"}->{"Unit"}->{"-name"} eq "phone")
			{
				$self->{check_query}->execute($request->{"Transfer"}->{"Data"}->{"Unit"}->{"-value"});
				if(my $user=$self->{check_query}->fetchrow_hashref())
				{
					$response->{"Transfer"}->{"Data"}->{"-actualBills"}=$current_time->ymd();
					$response->{"Transfer"}->{"Data"}->{"PayerInfo"}->{"-billIdentifier"}=$user->{id};
					$response->{"Transfer"}->{"Data"}->{"PayerInfo"}->{"Fio"}=$user->{secondname};
					$response->{"Transfer"}->{"Data"}->{"PayerInfo"}->{"Phone"}=$request->{"Transfer"}->{"Data"}->{"Unit"}->{"-value"};
					foreach my $code (keys %{$self->{app}->{config}->{terminals}->{privat24}->{services}})
					{
						push(@{$response->{"Transfer"}->{"Data"}->{"ServiceGroup"}}, {"DebtService"=>{"-serviceCode"=>$code, 
							"DebtInfo"=>{"-debt"=>($user->{$self->{app}->{config}->{terminals}->{privat24}->{services}->{$code}->{field}}*-1)},
							"CompanyCode"=>$self->{app}->{config}->{terminals}->{privat24}->{services}->{$code}->{code}
							}});
					}
				}
				else
				{
					$response->{"Transfer"}->{"Data"}->{"-xsi:type"}="ErrorInfo";
					$response->{"Transfer"}->{"Data"}->{"-code"}="99";
					$response->{"Transfer"}->{"Data"}->{"Message"}="Пользователь не найден";
				}
			}
		}
	}
	$self->render(text=>'<?xml version="1.0" encoding="UTF-8" standalone="yes"?>'.hash2xml($response));
}

1;