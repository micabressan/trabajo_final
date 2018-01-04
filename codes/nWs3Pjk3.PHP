PocketMine-MP Crash Dump Tue Jan 2 07:18:00 CST 2018

Error: Call to a member function addChunkPacket() on null
File: src/pocketmine/inventory/ChestInventory
Line: 90
Type: notice

Code:
[81] 	}
[82] 
[83] 	protected function broadcastBlockEventPacket(Vector3 $vector, bool $isOpen) : void{
[84] 		$pk = new BlockEventPacket();
[85] 		$pk->x = (int) $vector->x;
[86] 		$pk->y = (int) $vector->y;
[87] 		$pk->z = (int) $vector->z;
[88] 		$pk->eventType = 1; //it's always 1 for a chest
[89] 		$pk->eventData = $isOpen ? 1 : 0;
[90] 		$this->getHolder()->getLevel()->addChunkPacket($this->getHolder()->getX() >> 4, $this->getHolder()->getZ() >> 4, $pk);
[91] 	}
[92] }
[93] 
[94] 
[95] 
[96] 
[97] 
[98] 
[99] 
[100] 

Backtrace:
#0 src/pocketmine/inventory/DoubleChestInventory(120): pocketmine\inventory\ChestInventory->broadcastBlockEventPacket(pocketmine\tile\Chest object, boolean )
#1 src/pocketmine/inventory/BaseInventory(399): pocketmine\inventory\DoubleChestInventory->onClose(cosmiccore\CosmicPlayer object)
#2 src/pocketmine/Player(3799): pocketmine\inventory\BaseInventory->close(cosmiccore\CosmicPlayer object)
#3 src/pocketmine/Player(3813): pocketmine\Player->removeWindow(pocketmine\inventory\DoubleChestInventory object, boolean )
#4 src/pocketmine/Player(3641): pocketmine\Player->removeAllWindows()
#5 CosmicCore_v4.7.phar/src/cosmiccore/CosmicCore(653): pocketmine\Player->teleport(pocketmine\level\Location object)
#6 CosmicCore_v4.7.phar/src/cosmiccore/deepweb/queries/TeleportToHomeQuery(66): cosmiccore\CosmicCore::cooldownTP(cosmiccore\CosmicPlayer object, pocketmine\level\Location object)
#7 CosmicCore_v4.7.phar/src/cosmiccore/thread/CosmicThread(156): cosmiccore\deepweb\queries\TeleportToHomeQuery->onCompletion(pocketmine\Server object)
#8 src/pocketmine/scheduler/AsyncTask(186): cosmiccore\thread\CosmicThread->onProgressUpdate(pocketmine\Server object, cosmiccore\deepweb\queries\TeleportToHomeQuery object)
#9 src/pocketmine/scheduler/AsyncPool(160): pocketmine\scheduler\AsyncTask->checkProgressUpdates(pocketmine\Server object)
#10 src/pocketmine/scheduler/ServerScheduler(342): pocketmine\scheduler\AsyncPool->collectTasks()
#11 src/pocketmine/Server(2532): pocketmine\scheduler\ServerScheduler->mainThreadHeartbeat(integer 50055)
#12 src/pocketmine/Server(2275): pocketmine\Server->tick()
#13 src/pocketmine/Server(2150): pocketmine\Server->tickProcessor()
#14 src/pocketmine/Server(1738): pocketmine\Server->start()
#15 src/pocketmine/PocketMine(554): pocketmine\Server->__construct(BaseClassLoader object, pocketmine\utils\MainLogger object, string /home/planets/monster/, string /home/planets/monster/plugins/)
#16 /home/planets/monster/PocketMine-MP.phar(1): require(string phar:///home/planets/monster/PocketMine-MP.phar/src/pocketmine/PocketMine.php)

PocketMine-MP version: 1.7dev #565 [Protocol 160; API 3.0.0-ALPHA10]
Git commit: 0000000000000000000000000000000000000000
uname -a: Linux cosmicpe.me 4.9.58-xxxx-std-ipv6-64 #1 SMP Mon Oct 23 11:35:59 CEST 2017 x86_64
PHP Version: 7.2.0
Zend version: 3.2.0
OS : Linux, linux

Loaded plugins:
CosmicCore 4.7 by Muqsit for API(s) 3.0.0-ALPHA10

----------------------REPORT THE DATA BELOW THIS LINE-----------------------

===BEGIN CRASH DUMP===
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
===END CRASH DUMP===