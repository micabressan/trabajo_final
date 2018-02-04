<?php

namespace vas\models;
use Phalcon\Mvc\Model\Validator\Uniqueness;

class Shortcode extends \Phalcon\Mvc\Model
{
    public function validation()
    {
        $this->validate(
            new Uniqueness(
                array(
                    "field"   => "shortcode",
                    "message" => "The shortcode name must be unique"
                )
            )
        );
        return $this->validationHasFailed() != true;
    }
}

$model = Shortcode::findFirstById(1);
try {
	if($model->save()) {
		echo "Success";
	} else {
		foreach($model->getMessages() as $m) {
			print_r($m->getMessage());
		}
		echo "Failed";
	}
} catch (\Exception $e) {
	print_r($e->getMessage());
}