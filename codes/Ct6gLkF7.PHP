
class NataliMigration extends Migration {
  public function __construct() {
    parent::__construct();
    $this->description = t('Migrate products from the source database');
   
    $this->map = new MigrateSQLMap($this->machineName,
    array('id'  => array(
              'type' => 'int',
              'not null' => TRUE
    ),
    ),
    MigrateDestinationTerm::getKeySchema()
    );

     $query = db_select('nat_real')     
     ->fields('Inventory', array(
          'name', //title
          'Part_number', //Sku
          'Description', //Body
          'price_cad', //price cdn 840
          'price_usd', //price usd 124
          'id', //unique key
          //image
          	
     ));
     
      
    $this->source = new MigrateSourceSQL($query, array(), NULL,  array('map_joinable' => FALSE));
    
    $this->destination = new MigrateDestinationNode('product'); // Product
    
    $this->addFieldMapping('title', 'name');
    $this->addFieldMapping('body', 'Description');
    $this->addFieldMapping('name', 'username');  
   
    $this->addUnmigratedDestinations(array('name', 'created', 'changed', 'status',
      'promote', 'revision', 'language'));
      
  }
}