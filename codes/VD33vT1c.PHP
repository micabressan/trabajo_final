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
  //ID	category	subcat	Part_number	Description	Warehouse	product_code	country_available	stock_available	Location	On_hold	price_cad	price_usd	qty1	discount1	qty2	discount2	qty3	discount3	Sales_tax_1	Sales_tax_2	Unit_measure	Last_PO_number	Last_PO_due_date	Discountable	Sales_department	Qty_on_hand	Re_order_point	Qty_back_ordered	Qty_on_order	Alternate	Notes	Weight	Image_file	UPC_code	Last_modified	Created	Extended_description	name	picture	file	info	bulk	show_price	special	popular	status
    //$query = Database::getConnection('nat_real' , 'default')
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