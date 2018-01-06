sub get_contacts_subs
{
my $emailid = ($ARGV[1]);
my $url = "${uri}/${accountid}/c/${clientid}/contacts?status=total&email=${emailid}";
$response = $browser->get($url, @headers);
my ($contactId) = $response->content =~/<contactId>(\d+)</;
my $url = "${uri}/${accountid}/c/${clientid}/subscriptions?contactId=${contactId}";
$response = $browser->get($url, @headers);
my $data;
$data = $response->decoded_content;
my ($addDate, $listId);
my $list_data;
foreach my $s_line (split "\n", $data) {
   if ($s_line =~ /addDate>(.*)</) {
      $addDate = $1;
   }
   if ($s_line =~ /listId>(\d+)</) {
      # end of data block, do stuff
      $listId = $1;

      my $epoch = UnixDate(ParseDate($addDate),"%s");

      $list_data->{$listId} = $epoch;

      $listId = undef;
      $addDate = undef;
   }
}

# sort based on the epoch time in list_data, oldest to newest
my @sorted = sort { $list_data->{$a} <=> $list_data->{$b} } keys %$list_data;

# remove the first element in the array, this is the first subscription
my $first_subscription = shift @sorted;

print "The first subscription has a listID of: $first_subscription\n";