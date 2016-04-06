#! /usr/bin/perl
use DBI;

# open directory
my $directory = "/home/pete/Desktop/dbchallenge"; # change to match the source directory
# connect to Database
my $dbh = DBI->connect('DBI:mysql:receipts', 'root', 'k@k@r0t1') or die "Couldn't connect to database: " . DBI->errstr;

#create tables with their respective columns
$dbh->do("CREATE TABLE orders (orderid INTEGER, date CHAR(10), name VARCHAR(20), phone INTEGER, address VARCHAR(30), city VARCHAR(10), state CHAR(2), zip INTEGER, email VARCHAR(30), shipmethod VARCHAR(20), subtotal DECIMAL(5,2), shipcost DECIMAL(5,2), tax DECIMAL(5,2), total DECIMAL(5,2))");
$dbh->do("CREATE TABLE items (itemid INTEGER, name VARCHAR(30), price DECIMAL(5,2), quantity INTEGER)");

# open and read the directory
opendir(my $dh, $directory) || die "can't opendir $directory: $!";
my @receipts = grep { /^Order/} readdir($dh); # read the folder opened earlier and grep the filenames into array @receipts
if ($#receipts > 1) {
     print "Found (" . ($#receipts + 1) . ")receipts \n"; # number of receipts
}

# for each filename in @receipts
foreach (@receipts) {
     open (RECEIPT, $_) || die "Can't open file $_, $!"; # open
     my $id;
     my $date;
     my $name;
     my $phone;
     my $address;
     my $city;
     my $state;
     my $zip;
     my $email;
     my $shiptype;
     my $subtotal;
     my $shipcost;
     my $tax;
     my $total;
     while (<RECEIPT>) { # read through the file
          my $line = $_;
          $line =~ s/(\n|\r)//g;
          my @linesplit;
          @linesplit = split(m/\x3a\s+|\x24/, $line); # split the current line either on ": " or "$"
          if (index($line, "Order ID:") > -1) {
               $id = $linesplit[1];
               next;
          } elsif (index($line, "Date:") > -1) {
               $date = $linesplit[1];
               next;
          } elsif (index($line, "Name:") > -1) {
               $name = $linesplit[1];
               next;
          } elsif (index($line, "Phone:") > -1) {
               $phone = $linesplit[1];
               $phone =~ s/\D//g;
               next;
          } elsif (index($line, "Address:") > -1) {
               chomp $linesplit[1];
               $address = "$linesplit[1]";
               next;
          } elsif ($line =~ m/(\w+)\x2c\s+(\w{2})\s+(\d{5})/) {
               $city = $1;
               $state = $2;
               $zip = $3;
               next;
          } elsif (index($line, "Email:") > -1) {
               $email = $linesplit[1];
               next;
          } elsif (index($line, "Shipping:") > -1) {
               $shiptype = $linesplit[1];
               next;
          } elsif (index($line, "Sub Total ") > -1) { # totals section
               $subtotal = $linesplit[1];
               next;
          } elsif (index($line, "Shipping ") > -1) {
               $shipcost = $linesplit[1];
               next;
          } elsif (index($line, "Tax ") > -1) {
               $tax = $linesplit[1];
               next;
          } elsif ($line =~ m/Total\s+\x24/) {
               $total = $linesplit[1]; # total should be the only one that doesn't push to next iteration of the while loop
          } elsif ($line =~ m/^\s*(?#item number)\d+\s+(?<name>.*)\s+\x24(?<price>[\d\x2e]+)\s+(?<quantity>\d+)\s+\x24(?<total>[\d\x2e]+)/) { # if the line is an item
               my $itemname = $+{name}; # referencing the captures by name an setting them to scalar variables.
               my $price = $+{price};
               my $quantity = $+{quantity};
               my $itemtotal = $+{total};
               my $itemAdd = "INSERT INTO items VALUES ($id, \'$itemname\', $price, $quantity)"; # sql statement
               $dbh->do($itemAdd); # add item to item table with order id number.
               next;
          } else {
               next;
          }
          $orderAdd = "INSERT INTO orders VALUES ($id, \'$date\', \'$name\', $phone, \'$address\', \'$city\', \'$state\', $zip, \'$email\', \'$shiptype\', $subtotal, $shipcost, $tax, $total)"; 
          $dbh->do($orderAdd); # add order to order table database
     }
     close (RECEIPT);
}

printOrders();
sub printOrders() { # look into database and retreive orders.
     my $query = "SELECT DISTINCT(orderid) FROM orders;";
     my $orderIDs = $dbh->prepare($query);
     $orderIDs->execute();
     print "your available order ID's are:\n";
     while (my @results = $orderIDs->fetchrow_array()) {
          print "   $results[0]\n";
     }
     print "enter an order ID to show:";
     my $orderID = <STDIN>;
     chomp $orderID;
     $query = "SELECT * FROM orders WHERE orderid=$orderID;";
     my $orders = $dbh->prepare($query);
     $orders->execute();
     while (my @results = $orders->fetchrow_array()) {
          $query = "SELECT * FROM items WHERE itemid=$orderID;";
          my $items = $dbh->prepare($query);
          $items->execute();
          print "\n\n################################################################################\n";
          print "id: @results[0]\n";
          print "date: @results[1]\n";
          print "name: @results[2]\n";
          print "phone: @results[3]\n";
          print "address: @results[4]\n";
          print "city: @results[5]\n";
          print "state: @results[6]\n";
          print "zip: @results[7]\n";
          print "email: @results[8]\n";
          print "shiptype: @results[9]\n";
          print "\n\nITEMS:\n";
          print "   Name                             Quant     Ea.\n";
          while (@itemResult = $items->fetchrow_array()) {
               print "   $itemResult[1]    ";
               print "$itemResult[3]         ";
               print "\$$itemResult[2]\n";
          }
          print "\nORDER SUMMARY:\n";
          print "   subtotal: @results[10]\n";
          print "   shipcost: @results[11]\n";
          print "   tax: @results[12]\n";
          print "   total: @results[13]\n";
          print "################################################################################\n\n\n";
     }
     again();
}
sub again() {
     print "would you like to see another order? (Yes/No)";
     my $response = <STDIN>;
     chomp $response;
     if ($response =~ m/^(?i)yes$/) {
          printOrders();
     }
}
$dbh->do("DROP TABLE orders, items");
print "\nDropped Tables. \n\n"