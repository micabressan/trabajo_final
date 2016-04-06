<?php

class Person implements JsonSerializable {
    private $name;
    private $surname;

    function __construct($name, $surname) {
        $this->name = $name;
        $this->surname = $surname;
    }

    function jsonSerialize() {
        return array('#t' => 'Person', '#v' => array(
            'name' => $this->name,
            'surname' => $this->surname)
        );
    }
}

class Article implements JsonSerializable {
    private $cislo;
    private $real;
    private $datum;
    private $person;

    function __construct($cislo, $real, $datum, $person) {
        $this->cislo = $cislo;
        $this->real = $real;
        $this->datum = $datum;
        $this->person = $person;
    }

    function jsonSerialize() {
        return array(
            'cislo' => $this->cislo,
            'real' => $this->real,
            'datum' => array('#t' => 'Date', '#v' => $this->datum->format('c')),
            'author' => $this->person,
        );
    }
}

$john = new Person('John', 'Dee');
$article = new Article(42, 3.1415, new DateTime(), $john);
echo JSON_encode($article);