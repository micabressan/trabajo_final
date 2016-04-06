<?php
abstract class AbstractWriter {

		public $data = array();
		public $summa;
		private $sesion_key;

		public function addProduct ( Product $product )
		{
			$_SESSION[$this->sesion_key][] = $product;
		}

		public function setKey($key) {
			$this->sesion_key = $key;
		}

		public function writeCur ( $path = '' ) {
			if ($path != '') $currency = file("../libs/data/catalogName.dat");
			else $currency = file("libs/data/catalogName.dat");

		    echo '<select id="catalogName" onchange="selected();" size="30" multiple="multiple">';
		    sort($currency);
		    for($i = 0; $i < count($currency); $i++) {
		        echo '<option value="' . $currency[$i] . '">' . $currency[$i] . '</option>';
		    }

		    echo '</select>';

		}

	public static function staticGetSum() {
		if (isset($_SESSION[$this->sesion_key])) {
			$result = 0.00;
			$sum = 0.00;

			foreach ($_SESSION[$this->sesion_key] as $key) {
				$result = $key->count * $key->price;
				$sum += $result;
			}

			return $sum;
		}
	}

		public function getSum()
		{
			if (isset($_SESSION[$this->sesion_key]))
			{
				$result = 0.00;
				$sum = 0.00;

				foreach ($_SESSION[$this->sesion_key] as $key)
				{
					$result = $key->count * $key->price;
					$sum += $result;
				}

				return $sum;
			}
		}


		// показать текущую сессию
		public function write ()
		{
			$result = 0;
			$count = 0;
			$sum = 0;
			$id = 0;
			$color = '';

			if (isset($_SESSION[$this->sesion_key]))
			{
				foreach ($_SESSION[$this->sesion_key] as $idObj => $key)
				{
					$id++;
					if ($id % 2 == 0 ) $color = 'green'; else $color = 'gray';
					echo '<tr style="background: ' . $color . '"><td>' . $id . '</td><td>' . $key->name . '</td><td>' . $key->count . '</td><td>' . $key->price . '</td>';
					$result = $key->count * $key->price;
					$sum += $result;
					printf('<td>%.2f</td><td><a href="?edit=' . $idObj . '">Ред.</a></td><td><a href="?delete=' . $idObj . '">Удал.</a></td></tr>', $result);
				}

				$this->summa = $sum;
				return $sum;
			}

		}

		public function getFormId($id, $path = '') {

			$form = '';

			if ($path != '') $formHandler = '/pr/';

			$object = $_SESSION[$this->sesion_key][$id];

			$form .= '<div class="col-xs-3"><form action="' . $formHandler . 'index.php" method="post">
				<input class="form-control input-small" type="hidden" name="id" value="' . $id . '">
				<input class="form-control input-small" type="text" value="' . $object->name . '" name="edit-name">
				<input onchange="return digit(this);" onkeyup="return digit(this);" class="form-control input-small" type="text" value="' . $object->count . '" name="edit-count">
				<input onchange="return digit(this);" onkeyup="return digit(this);" class="form-control input-small" type="text" value="' . $object->price . '" name="edit-price">
				<input class="btn btn-primary btn-xs" type="submit" value="Сохранить">
				</form></div>';

			return $form;
		}

		public function saveObject ( $name, $count, $price, $hiddenId ) {

			$_SESSION[$this->sesion_key][$hiddenId]->name = $name;
			$_SESSION[$this->sesion_key][$hiddenId]->count = $count;
			$_SESSION[$this->sesion_key][$hiddenId]->price = $price;

		}

	}