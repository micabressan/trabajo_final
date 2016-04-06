<?php
interface iCars
{
	public function getPrice();
	public function getWeight();
	public function mineIsBigger($obj);
}
class BMW implements iCars
{
	private $_price;
	private $_weight;

	function __construct($_price, $_weight=4242)
    {
        $this->_price = $_price;
        $this->_weight = $_weight;
    }
    public function getPrice()
    {
    	return $this->_price;
    }
    public function getWeight()
    {
    	return $this->_weight;
    }
    public function mineIsBigger($obj)
    {
    	if(get_class($obj) == "Toyota") echo "Mine is bigger";
    	else if(get_class($obj) == "Smart") echo "Mine is way bigger!";
    	else if(get_class($obj) == "Velib") echo "LOL";
    	else echo "Show me !";
    }
    public static function lessExpensive()
    {
    	return 15000;
    }
}
class Suzuki implements iCars
{
	private $_price;
	private $_weight;

	function __construct($_price, $_weight=4242)
    {
        $this->_price = $_price;
        $this->_weight = $_weight;
    }
    public function getPrice()
    {
    	return $this->_price;
    }
    public function getWeight()
    {
    	return $this->_weight;
    }
    public function mineIsBigger($obj)
    {
    	if(get_class($obj) == "Toyota") echo "Mine is bigger";
    	else if(get_class($obj) == "Smart") echo "Mine is way bigger!";
    	else if(get_class($obj) == "Velib") echo "LOL";
    	else echo "Show me !";
    }
    public static function lessExpensive()
    {
    	return 5000;
    }
}
?>

<?php
	try 
	{
		for ($i=0; $i < 5; $i++) 
		{ 
			call_pangolin();
		}
	}
	catch(Exception $e)
	{
		 echo $e->getMessage();
	}
?>

<?php
namespace Imperium;

	class Soldier
	{
		private $hp;
		private $attack;
		private $name;

		public function getHp() 
		{
			return $this->hp;
		}
		public function setHp($hp) 
		{
			$this->hp = $hp;
		}
		public function getAttack() 
		{
			return $this->attack;
		}
		public function setAttack($attack) 
		{
			$this->attack = $attack;
		}
		public function getName() 
		{
			return $this->name;
		}
		public function setName($name) 
		{
			$this->name = $name;
		}
		public function doDamage($soldier)
		{
			$newhp = ($soldier->getHp()) - ($this->attack) ;
			$soldier->setHp($newhp);
		}
		function __construct($name, $hp=50, $attack=12)
		{
			$this->name = $name;
			$this->hp = $hp;
			$this->attack = $attack;
		}
		public function __toString()
		{
			return $this->name ." the ". __NAMESPACE__." Space Marine : ". $this->hp ." HP.";
		}
	}

namespace Chaos;

	class Soldier
	{
		private $hp;
		private $attack;
		private $name;

		public function getHp() 
		{
			return $this->hp;
		}
		public function setHp($hp) 
		{
			$this->hp = $hp;
		}
		public function getAttack() 
		{
			return $this->attack;
		}
		public function setAttack($attack) 
		{
			$this->attack = $attack;
		}
		public function getName() 
		{
			return $this->name;
		}
		public function setName($name) 
		{
			$this->name = $name;
		}
		function __construct($name, $hp=70, $attack=12)
		{
			$this->name = $name;
			$this->hp = $hp;
			$this->attack = $attack;
		}
		public function doDamage($soldier)
		{
			$newhp = ($soldier->getHp()) - ($this->attack) ;
			$soldier->setHp($newhp);
		}
		public function __toString()
		{
			return $this->name ." the ". __NAMESPACE__." Space Marine : ". $this->hp ." HP.";
		}
	}
?>