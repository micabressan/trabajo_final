function createCustomer($customer) {
    global $dbh;

    $stmt = $dbh->prepare("INSERT INTO customer (first_name, last_name, email, country) VALUES(:first_name, :last_name, :email, :country)");

    return $stmt->execute($customer);
}