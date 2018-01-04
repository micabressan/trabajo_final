================== TEST FILE =======================
subtest 'TESTING HVE::Utility::List::list' => sub {
	subtest 'GIVEN We have an empty list of ids' => sub {

		my $staff_ids;
		my $staff = HVE::Utility::List::list(
			$context, 'staff',
			{
				conditions => { id => [ map { $_->{id} } @{$staff_ids || []} ] },
			},
		);
		subtest 'WHEN We call HVE::Utility::List::list with conditions => id => [] ' => sub {
			my $received = scalar @$staff;
			my $expected = 0;

			use Data::Dumper;
			warn Dumper $staff;

			is($received, $expected, 'THEN We receive no entities');
		};
	};
};
================== Output =======================
    # Subtest: TESTING HVE::Utility::List::list
        # Subtest: GIVEN We have an empty list of ids
            # Subtest: WHEN We call HVE::Utility::List::list with conditions => id => []
            ok 1 - THEN We receive no entities
            1..1
        ok 1 - WHEN We call HVE::Utility::List::list with conditions => id => []
        1..1
    ok 1 - GIVEN We have an empty list of ids
    1..1
ok 1 - TESTING HVE::Utility::List::list
1..1
$VAR1 = [];
ok
All tests successful.