public function click(PlayerInteractEvent $event){
$player = $event->getPlayer();

if($this->clicks[$player->getName()] == 100){ //если в массиве 100
$player->sendMessage("100 clicks");
$this->clicks[$player->getName()] = 0; //ставим 0 в массив
}else{
$this->clicks[$player->getName()]++; //добавляем 1 в массив
}
}