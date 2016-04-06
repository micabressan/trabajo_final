<?php


class BuilderBase{


	protected $cache_id;

	/**
	* $rows['x'] = array(
	*	'id' => 'x',
	*	'weight' => 0,
	*	'title' => ''.
	*	'settings' => array(),
	* );
	*/
	protected $rows;
	
	/**
	* $columns['x'] = array(
	*	'id' => 'y',
	*	'parent' => 'x'
	*	'weight' => 0,
	* 	'title' => '',
	* 	'settings' => array(),
	* );
	*
	*
	*/
	protected $columns;
	
	
	/**
	* $contents['z'] = array(
	*	'id' => 'z',
	*	'parent'=> 'y',
	*	'weight' => 0,
	*	'title' => '',
	* 	'settings' => array(),
	* );
	*/
	protected $contents;
	
	
	public function __construct(){
		
		$data = cache_get($this->cache_id);
		
		$this->rows = $data['rows'];
		$this->columns = $data['columns'];
		$this->contents = $data['contents'];
		
	}
	
	public function getElement($type = 'row', $id){
		
		switch $type{
			
			case 'row':
				return $this->rows[$id];
			break; 
			
			case 'column':
				return $this->columns[$id];
			break;
			
			case 'content':
				return $this->contents[$id];
			break;
		}
		
	}
	
	public function setElement($type = 'row', $id = NULL, $data = array()){
		$elements = array(
			'row' => 'rows';
			'column' => 'columns',
			'content' => 'contents',
		);
		if(empty($id)){
			
			$id = uniqid($type.'_');
		}
		
		
		if(isset($elements[$type])){
			$this->$elements[$type][$id] = $data;
		}else{
			
			$this->$type[$id] = $data;
		}
		
		// do save element to Object attributes here.
		
		// call to update function save builder to cache.
		$this->update();
		
	}
	
	
	/**
	* Do save builder data to cache when Object changed.
	*/
	public function update(){
		
		$data = get_object_vars($this);
		// example to save builder to cache.
		cache_save($this->cache_id, $data);
		
	}
	
	// Now idea for render this Builder
	
	public function render(){
		
		// Idea here.
	}
	


}



// #version 2 *** =======  *////////////////

<?pph

class BuilderBase{
	
	
	protected $cache_id;
	protected $elements;
	
	
	
	
	public function __construct(){
		
		$data = cache_get($this->cache_id);
		
		$this->elements = $data['elements'];
	}
	
	public function __get($id){
		
		
		return isset($elements->$id) ? $elements->$id : NULL;
	}
	
	
	public function __set($id, $element){
		
		
		
		// this is how element array look like.
		
		/*$element = array(
			'#type' => 'row',
			'#id' => $id,
			'#settings' => array(),
			'#weight' => 0,
		); */
		
		$this->elements->$id = $element;
		
		// detect object change. So we need save builder to cache.
		
		$this->update();
	}
	
	private function update(){
		
		cache_save($this->cache_id, $elements);
	}
	
	public function getAll(){
		return $this->elements;
	}
	
	
}



$builder = new BuilderBase();
$id = uniqid($type.'_');
$element = array(
	'#type' => 'row',
	'#id' => $id,
	'#settings' => array(),
	'#weight' => 0,
);

$id = 'abcxyz';
$builder->$id = $element;