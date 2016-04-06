class Foo {
    /**
     * @property $xdebug
     * @property $shit
     * @property $bullShit
     */
    public function __get($x)
    {
        return $this->{$x}; // czy jak tam chcesz zeby to sie zachowywalo
    }
}

$o = new Foo();
$o->shit // to juz podpowie