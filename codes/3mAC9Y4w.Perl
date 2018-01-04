	my $rule = [
		sid			=> [
			[ 'uint',                            'SID is not valid. Please relogin' ],
		],
		id			=> [
			[ 'uint',                            'ID is not valid. Please verify that you have entered the correct information' ],
		],
		name		=> [
			[ 'not_blank',                      'Name cannot be left blank' ],
			[ { length => [ 0x03, 0xFFFFFF ] }, 'Name must be at least 3 characters long'  ],
			[ { length => [ 0x00, 0x10     ] }, 'Name can\'t be longer than 16 characters' ],
			#~ [ 'task_already_exists', 'A task with the name you specified already exists' ],
		],
		subj		=> [
			[ 'not_blank',                       'Subject cannot be left blank' ],
			[ { length => [ 0x03, 0xFFFFFF ] },  'Subject must be at least 3 characters long'     ],
			[ { length => [ 0x00, 0xFFFF   ] },  'Subject can\'t be longer than 65535 characters' ],
		],
		use_proxy	=> [
			[ 'uint',                            '"Use own socks" is not valid. Please verify that you have entered the correct information' ],
			[ { between => [ 0x00, 0x01] },      '"Use own socks" is not valid. Please verify that you have entered the correct information' ],
		],
		grab_contacts	=> [
			[ 'uint',                            '"Grab contacts" is not valid. Please verify that you have entered the correct information' ],
			[ { between => [ 0x00, 0x01] },      '"Grab contacts" is not valid. Please verify that you have entered the correct information' ],
		],
		accounts	=> [
			[ 'not_blank',                       'Accounts cannot be left blank' ],
			[ 'uint',                            'Accounts is not valid. Please verify that you have entered the correct information' ]
		],
		mpa_min		=> [
			[ 'not_blank',                       'MPA cannot be left blank' ],
			[ 'uint',                            'MPA is not valid. Please verify that you have entered the correct information' ],
			[ { between      => [ @$settings{qw/limit_mpa_min limit_mpa_max/} ] },
										sprintf  'MPA must be between %d and %d', @$settings{qw/limit_mpa_min limit_mpa_max/} ],
			[ { less_than    => $p->{mpa_max} }, 'Minimum MPA must be less than maximum MPA' ],
		],
		mpa_max		=> [
			[ 'not_blank',                       'MPA cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_mpa_min limit_mpa_max/} ] },
										sprintf  'MPA must be between %d and %d', @$settings{qw/limit_mpa_min limit_mpa_max/} ],
			[ { greater_than => $p->{mpa_min} }, 'Maximum MPA must be great than minimum MPA' ],
		],
		sd_min		=> [
			[ 'not_blank',                       'Send delay cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_send_delay_min limit_send_delay_max/} ] },
										sprintf  'Send delay must be between %d and %d', @$settings{qw/limit_send_delay_min limit_send_delay_max/} ],
			[ { less_than    => $p->{sd_max} },  'Minimum send delay must be less than maximum send delay' ],
		],
		sd_max		=> [
			[ 'not_blank',                       'Send delay cannot be left blank' ],
			[ { between      => [  @$settings{qw/limit_send_delay_min limit_send_delay_max/} ] },
										sprintf  'Send delay must be between %d and %d', @$settings{qw/limit_send_delay_min limit_send_delay_max/} ],
			[ { greater_than => $p->{sd_min} },  'Maximum send delay must be great than minimum send delay' ],
		],
		cd_min		=> [
			[ 'not_blank',                       'Check delay cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_check_delay_min limit_check_delay_max/} ] },
										sprintf  'Check delay must be between %d and %d', @$settings{qw/limit_check_delay_min limit_check_delay_max/} ],
			[ { less_than    => $p->{cd_max} },  'Minimum check delay must be less than maximum check delay' ],
		],
		cd_max		=> [
			[ 'not_blank',                       'Check delay cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_check_delay_min limit_check_delay_max/} ] },
										sprintf  'Check delay must be between %d and %d', @$settings{qw/limit_check_delay_min limit_check_delay_max/} ],
			[ { greater_than => $p->{cd_min} },  'Maximum check delay must be great than minimum check delay' ],
		],
		rd_min		=> [
			[ 'not_blank',                       'Reply deep cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_reply_deep_min limit_reply_deep_max/} ] },
										sprintf  'Reply deep must be between %d and %d', @$settings{qw/limit_reply_deep_min limit_reply_deep_max/} ],
			[ { less_than    => $p->{rd_max} },  'Minimum reply deep must be less than maximum reply deep' ],
		],
		rd_max		=> [
			[ 'not_blank',                       'Reply deep cannot be left blank' ],
			[ { between      => [ @$settings{qw/limit_reply_deep_min limit_reply_deep_max/} ] },
										sprintf  'Reply deep must be between %d and %d', @$settings{qw/limit_reply_deep_min limit_reply_deep_max/} ],
			[ { greater_than => $p->{rd_min} },  'Maximum reply deep must be great than minimum reply deep' ],
		],
		templates	=> [
			[ 'not_blank',                       'Templates cannot be left blank' ],
			[ { regex => /^[0-9]+(;[0-9])+$/ },  'Templates is not valid. Please verify that you have entered the correct information' ]
			#~ [ 'valid_templates']
		],
		redirects	=> { require => 0x00 }  => [
			[ { regex => /^[0-9]+(;[0-9])+$/ },  'Redirects is not valid. Please verify that you have entered the correct information' ]
		],
		morf		=> [
			[ 'uint',                            '"Twist images" is not valid. Please verify that you have entered the correct information' ],
			[ { between => [ 0x00, 0x01] },      '"Twist images" is not valid. Please verify that you have entered the correct information' ],
		]
	];