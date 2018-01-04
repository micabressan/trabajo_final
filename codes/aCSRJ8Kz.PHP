<?php
define('NOBILITY_PRIMITIVE', 1);
define('NOBILITY_NOMADIC', 2);
define('NOBILITY_BARBARIC', 4);
define('NOBILITY_CIVILIZED', 8);
class Social
{
	// class construction requirements
	private $db;
	private $loot;
	private $skillManager;
	private $culture;
	private $underworld;
	private $person;

	// database schema `status_social`
	// current social status
	private $_id;
	private $_name;
	private $_short;
	private $_modifier;
	private $_litchance;
	private $_survskill;
	private $_basewealth;
	private $_description;

	// class properties
	private $social         = array();
	private $nobility       = array();
	private $details        = array();
	private $isWealthy      = FALSE;
	private $isNobile       = FALSE;
	private $isLiterate     = FALSE;
	private $nobilityTitles = null;

	private $possibleMoney  = 0;
	private $startingGold   = 0;

	// logic variables
	private $useCuMod = TRUE;

	public function __construct() {
		$this->db = Registry::getInstance()->get('database');
		$this->skillManager = Registry::getInstance()->get('skills');

		$this->culture = Registry::getInstance()->get('culture');
		$this->underworld = Registry::getInstance()->get('underworld');
		$this->person = Registry::getInstance()->get('person');
	}

	public function rollSocialClass($cultureMOD) {
		// Determine if we are of Nobile ranking
		if ($this->isNobile()) {
			// Add the results together
			$dice = (dice(100) + $cultureMOD + $this->nobility['modifier']);

			// Forbid another nobility roll
			$dice = ($dice >= 100 ? 99 : $dice);
		}
		else
			$dice = dice(100) + $cultureMOD;

		return $dice;
	}

	private function convertBaseWealth() {
		$max = 0;
		for ($i = 0; $i < 4; $i++)
			$max += 6;
		$max = $max * 100; // In Gold, Then...
		$max = $max * 10; // Multiply by 10, Then...
		$max = $max * $this->getBaseWealth();

		$this->possibleMoney = $max;

		$money = 0;
		for ($i = 0; $i < 4; $i++)
			$money += dice(6);
		$money = $money * 100; // In Gold, Then...
		$money = $money * 10; // Multiply by 10, Then...
		$money = $money * $this->getBaseWealth();

		$this->startingGold = $money;
	}

	public function calculateLiteracy() {

		$rank = dice(4) + $this->getMod();

		$percent = $this->culture->getLit() + $this->getLit();

		if ($this->getShort() == 'd')
			$percent = 5;

		if ($this->isNobile())
			$percent += 30;

		$ntobeat = dice(100);

		if (chance($percent)) {
			$this->isLiterate = TRUE;
			$this->skillManager->add(SKILL_LITERACY, $rank);
			//$this->addDetail("Succeeded in learning to be literate: Rolled below {$percent} ({$ntobeat}) at Rank {$rank}");
		}
		else {
			$this->isLiterate = FALSE;
			//$this->addDetail("Failed to be literate: Rolled a {$ntobeat} over {$percent}");
		}
	}

	public function setup() {

		if (CONFIG::$SOCIAL_STATUS_FIXED > 0) {
			if (CONFIG::$SOCIAL_STATUS_FORCE_NOBILITY && !$this->isNobile()) {
				$this->nobility();
				return;
			}

			$categoryID = CONFIG::$SOCIAL_STATUS_FIXED;
			goto statusFixed;
		}

		$categoryIDs = array(
			1 => [1, 15],	// dest
			2 => [16, 40], // poor
			3 => [41, 84], // comfortable
			// 85, 86 - reroll
			4 => [87, 95], // wtd
			5 => [96, 99], // wealthy, has subroutine
			7 => [100, 110] // nobility
		);

		// The loop to determine our social class.
		socialIDLoop:
		$value = $this->rollSocialClass( ($this->useCuMod ? $this->culture->getMod() : 0) );
		foreach ($categoryIDs as $key => $array) {
			$min = $array[0];
			$max = $array[1];
			if ($value >= $min && $value <= $max) {
				$categoryID = $key;
				if ($this->isNobile() && $categoryID == 7)
					goto socialIDLoop;
				break;
			}
		}

		// Logic rolled an 85 or an 86. Re-roll and do not add Culture Mod.
		if (!isset($categoryID)) {
			$this->useCuMod = FALSE;
			goto socialIDLoop;
		}

		if (!$this->useCuMod)
			$this->useCuMod = TRUE;

		// Wealthy social status has a subroutine.
		if ($categoryID == 5) {
			if (dice(100) <= ($this->isNobile() ? $this->nobility['modifier'] : 0) + 1)
				$categoryID = 6;
			else
				$categoryID = 5;
		}

		if ($categoryID == 7) {
			$this->nobility();
			return;
		}

		statusFixed:
		$sql = "SELECT * FROM `social` WHERE `id` = :id LIMIT 1";
		$social = $this->db->query($sql)
				->bind(':id', $categoryID)
				->single();

		foreach($social as $field => $value) {
			$field = '_'.$field;
			$this->$field = $value;
		}

		if ($this->isNobile()) { $this->setMod($this->getMod() + 5); }

		$this->culture->setSPoints( $this->culture->getSPoints() + $this->getSurvival());

		$this->doMisc();
	}

	public function doMisc() {

		$this->convertBaseWealth();
		$this->calculateLiteracy();

		$loot = $this->loot;
		$skills = $this->skillManager;
		$location = "{$this->getName()}";

		if ($this->getEntry() == SOCIAL_DESTITUDE)
			$this->addDetail("5% chance to become literate, irregardless of culture");
		else {
			$suboradd = ($this->getLit() < 0 ? 'Subtracted ' : 'Added +');
			$this->addDetail( sprintf("%s<b>%s</b>%% chance to become literate", $suboradd, $this->getLit()) );
		}

		$this->addDetail( sprintf("Starting Money (x<b>%s</b>): <b>%s</b>", $this->getBaseWealth(), parseMoney($this->getMoney())) );

		if ($this->getSurvival() !== 0) {
			$sign = ($this->getSurvival() > 0 ? 'Added +':'Subtracted ');
			$this->addDetail( sprintf("%s %s to Survival Skills", $sign, $this->getSurvival()) );
		}

		switch($this->getEntry()):
			case SOCIAL_DESTITUDE: // Destitude
				if ($this->culture->isCivilized() OR $this->culture->getEntry() == 9) {
					$skills->add(SKILL_BRAWLING, 4);
					$skills->add(SKILL_DAGGER, 4);
					$this->addDetail("Learned <b>Dagger</b> and <b>Brawling</b> at Rank <b>4</b>");

					// if ($this->person->isAdolescent()) {
					// 	$skills->add(SKILL_BRAWLING, 1);
					// 	$skills->add(SKILL_DAGGER, 1);
					// }
				}
				if ($this->culture->getEntry() == CULTURE_DECADENT) {
					if (chance(60) && !$this->underworld->isEnded()) {
						$this->underworld->create();
						$this->addDetail("Acquired an Underworld Experience");
					}
				}
				elseif ($this->culture->isCivilized()) {
					if (chance(40) && !$this->underworld->isEnded()) {
						$this->underworld->create();
						$this->addDetail("Acquired an Underworld Experience");
					}
				}
				break;
			case 2: // Poor
				if (chance(50)) {
					$skills->add(SKILL_BRAWLING, 3);
					$skills->add(SKILL_DAGGER, 3);
					$this->addDetail("Learned <b>Dagger</b> and <b>Brawling</b> at Rank <b>3</b>");
				}
				break;
			case 3: // Comfortable
				// Simple, Light / One-Hand Melee
				$sql = sprintf("SELECT * FROM `loot_template`
					INNER JOIN `loot_template_weapon`
					ON loot_template.entry = loot_template_weapon.entry
					WHERE `category` = %s
					AND `group` = %s
					AND loot_template.entry != %s
					AND `equip_handle` = %s OR `equip_handle` = %s
					LIMIT 1", LOOT_CATEGORY_WEAPONS, WEAPON_GROUP_SIMPLE, WEAPON_EQUIP_HANDLE_LIGHT, WEAPON_EQUIP_HANDLE_ONEHANDED, LOOT_WEAPON_DAGGER);

				$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->setName("Heirloom " . $item->getName());
				$item->store();
				$this->addDetail("Heirloom weapon: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				break;
			case 4: // Well-to-Do
				// Two "Weapons"
				for ($i = 0; $i < 2; $i++) {
					// Simple, Light / One-Hand Melee
					$sql = sprintf("SELECT * FROM `loot_template`
						INNER JOIN `loot_template_weapon`
						ON loot_template.entry = loot_template_weapon.entry
						WHERE `category` = %s
						AND `group` = %s
						AND loot_template.entry != %s
						AND `equip_handle` = %s OR `equip_handle` = %s
						LIMIT 1", LOOT_CATEGORY_WEAPONS, WEAPON_GROUP_SIMPLE, WEAPON_EQUIP_HANDLE_LIGHT, WEAPON_EQUIP_HANDLE_ONEHANDED, LOOT_WEAPON_DAGGER);

					$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
					$item->setSQL($sql);
					$item->make();
					$item->setLocation($location);
					$item->store();
					$this->addDetail("Acquired a weapon: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");
				}

				$sql = sprintf("SELECT *
					FROM `loot_template`
					INNER JOIN `loot_template_pet`
					ON loot_template.entry = loot_template_pet.entry
					WHERE loot_template.entry = %s", CREATURE_RIDING_ANIMAL);

				$item = LootFactory::select(LOOT_CATEGORY_CREATURE);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();

				$this->addDetail("Acquired a riding animal: <b>{$item->getName()}</b>");
				break;
			case 5: // Wealthy

				// Finely Furnished Home
				$sql = sprintf("SELECT * FROM `loot_template` WHERE loot_template.entry = %s", 4502);
				$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->setDescription("The furnishings are quite fine.");
				$item->store();
				$this->addDetail("Acquired a <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				// Riding Animal
				$sql = sprintf("SELECT *
					FROM `loot_template`
					INNER JOIN `loot_template_pet`
					ON loot_template.entry = loot_template_pet.entry
					WHERE loot_template.entry = %s", CREATURE_RIDING_ANIMAL);

				$item = LootFactory::select(LOOT_CATEGORY_CREATURE);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Acquired a riding animal: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				// Clothing
				$sql = sprintf("SELECT * FROM `loot_template`
					WHERE `category` = %s
					AND `subcategory` = %s
					ORDER BY RAND()
					LIMIT 1", LOOT_CATEGORY_GENERAL, LOOT_SUBCATEGORY_CLOTHING);
				$clothes = dice(5);
				for ($i = 0; $i < $clothes; $i++) {
					$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
					$item->setSQL($sql);
					$item->make();
					$item->setLocation($location);
					$item->setDescription("Fine");
					$item->setCost($item->getCost() * 5);
					$item->store();
				}
				$this->addDetail("Acquired <b>{$clothes}</b> Fine Clothing");


				// Dagger
				$sql = sprintf("SELECT * FROM `loot_template`
					INNER JOIN `loot_template_weapon`
					ON loot_template.entry = loot_template_weapon.entry
					WHERE loot_template.entry = %s
					LIMIT 1", LOOT_WEAPON_DAGGER);

				$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Acquired a <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				// Jewelry
				$sql = sprintf("SELECT * FROM `loot_template`
					WHERE `category` = %s
					AND `subcategory` = %s
					ORDER BY RAND()
					LIMIT 1", LOOT_CATEGORY_GENERAL, LOOT_SUBCATEGORY_JEWELRY);

				$jewels = dice(5);
				$jewelCost = $this->getMoney() * 10;
				for ($i = 0; $i < $jewels; $i++) {
					$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
					$item->setSQL($sql);
					$item->make();
					$item->setLocation($location);
					$item->setDescription("Extremely Valuable");
					$item->setCost($jewelCost);
					$item->store();
				}
				$this->addDetail("Acquired <b>{$jewels}</b> Jewelry worth <b>".parseMoney($jewelCost)."</b> each");

				// Simple, Light / One-Hand Melee
				$sql = sprintf("SELECT * FROM `loot_template`
					INNER JOIN `loot_template_weapon`
					ON loot_template.entry = loot_template_weapon.entry
					WHERE `category` = %s
					AND `group` = %s
					AND loot_template.entry != %s
					AND `equip_handle` = %s OR `equip_handle` = %s
					LIMIT 1", LOOT_CATEGORY_WEAPONS, WEAPON_GROUP_SIMPLE, WEAPON_EQUIP_HANDLE_LIGHT, WEAPON_EQUIP_HANDLE_ONEHANDED, LOOT_WEAPON_DAGGER);

				$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Simple, Light Melee weapon: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");


				break;
			case 6: // Extremely Wealthy
				if (chance(30)) {
					$lang = dice(4);
					$this->addDetail("Learned to <b>Speak</b> <b>{$lang}</b> additional languages.");
				}

				// Estate
				$sql = sprintf("SELECT * FROM `loot_template` WHERE loot_template.entry = %s", BACKGROUND_LOOT_ESTATE);
				$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->setDescription("A lavish estate written in your name.");
				$item->store();
				$this->addDetail("Acquired a <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				// Riding Animal
				$sql = sprintf("SELECT *
					FROM `loot_template`
					INNER JOIN `loot_template_pet`
					ON loot_template.entry = loot_template_pet.entry
					WHERE loot_template.entry = %s", CREATURE_RIDING_ANIMAL);

				$item = LootFactory::select(LOOT_CATEGORY_CREATURE);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Acquired a riding animal: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				// Clothing
				$sql = sprintf("SELECT * FROM `loot_template`
					WHERE `category` = %s
					AND `subcategory` = %s
					ORDER BY RAND()
					LIMIT 1", LOOT_CATEGORY_GENERAL, LOOT_SUBCATEGORY_CLOTHING);
				$clothes = dice(5);
				for ($i = 0; $i < $clothes; $i++) {
					$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
					$item->setSQL($sql);
					$item->make();
					$item->setLocation($location);
					$item->setDescription("Expensive");
					$item->setCost($item->getCost() * 15);
					$item->store();
				}
				$this->addDetail("Acquired <b>{$clothes}</b> Expensive Clothing");

				// Jewelry
				$sql = sprintf("SELECT * FROM `loot_template`
					WHERE `category` = %s
					AND `subcategory` = %s
					ORDER BY RAND()
					LIMIT 1", LOOT_CATEGORY_GENERAL, LOOT_SUBCATEGORY_JEWELRY);

				$jewels = dice(5);
				$jewelCost = $this->getMoney() * 15;
				for ($i = 0; $i < $jewels; $i++) {
					$item = LootFactory::select(LOOT_CATEGORY_GENERAL);
					$item->setSQL($sql);
					$item->make();
					$item->setLocation($location);
					$item->setDescription("Extremely Valuable");
					$item->setCost($jewelCost);
					$item->store();
				}
				$this->addDetail("Acquired <b>{$jewels}</b> Jewelry worth <b>".parseMoney($jewelCost)."</b> each");


				// Dagger
				$sql = sprintf("SELECT * FROM `loot_template`
					INNER JOIN `loot_template_weapon`
					ON loot_template.entry = loot_template_weapon.entry
					WHERE loot_template.entry = %s
					LIMIT 1", LOOT_WEAPON_DAGGER);

				$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Acquired a <b class='q{$item->getQuality()}'>{$item->getName()}</b>");


				// Simple, Light / One-Hand Melee
				$sql = sprintf("SELECT * FROM `loot_template`
					INNER JOIN `loot_template_weapon`
					ON loot_template.entry = loot_template_weapon.entry
					WHERE `category` = %s
					AND `group` = %s
					AND loot_template.entry != %s
					AND `equip_handle` = %s OR `equip_handle` = %s
					LIMIT 1", LOOT_CATEGORY_WEAPONS, WEAPON_GROUP_SIMPLE, WEAPON_EQUIP_HANDLE_LIGHT, WEAPON_EQUIP_HANDLE_ONEHANDED, LOOT_WEAPON_DAGGER);

				$item = LootFactory::select(LOOT_CATEGORY_WEAPONS);
				$item->setSQL($sql);
				$item->make();
				$item->setLocation($location);
				$item->store();
				$this->addDetail("Simple, Light Melee weapon: <b class='q{$item->getQuality()}'>{$item->getName()}</b>");

				$this->addDetail("Within reason, <b>any material possessions desired.</b>");
				break;
		endswitch;

		if ($this->isNobile())
			$this->addDetail("Born into <b>Nobility</b>, view on Special");
	}

	public function nobility() {
		if ($this->isNobile()) return;
		$this->isNobile = true;

		$entry = $this->culture->getEntry();
		if ($entry == 2)
			$bit = NOBILITY_PRIMITIVE;
		elseif ($entry == 4)
			$bit = NOBILITY_NOMADIC;
		elseif ($entry == 5)
			$bit = NOBILITY_BARBARIC;
		elseif ($this->culture->isCivilized())
			$bit = NOBILITY_CIVILIZED;

		$sql = "SELECT * FROM  `nobility` WHERE (`cultureMask` & :bit) > 0 ORDER BY RAND() LIMIT 1";

		$result = $this->db->query($sql)
				->bind(':bit', $bit)
				->single();

		$result['modifier'] = diceEx($result['modifier']);
		$result['description'] = "The character is a member of a nobile family, the aristocracy of the land. Most nobiles view their fellow humans as less than themselves, including destitudes.";
		$result['roleplay'] = "Nobles, by definition, are supposed to be better than others, born to lead their lesser brethren. Even a Destitute Noble will consider themselves to be better than others. The importance and role of Nobility within a Culture will vary with the Culture.They may be dynamic hereditary leaders, able to command men to their deaths, or pleasure-loving parasites who are tolerated only because their existence is traditional.<br><br>Nobles exist and live by the works of others, having social value only when they coordinate, represent and protect those who do work. The justification of Nobility in a fantasy setting is often based on the assumption that the gods have chosen a select few to lead the people. The continuance of Nobility is based upon the facts that 'them what has, gets more' and 'might makes right.'";
		$result['details'] = array();

		$this->nobility = $result;

		$this->addNDetail("Added +<b>5</b> to SolMod");
		$this->addNDetail("Added +<b>30</b>% chance to become literate");

		$detail = sprintf("Family holds the title of a <b>%s</b> (<b>%s</b>)", $result['title'], diceEx($result['modifier']));
		$this->addNDetail($detail);
		// Aliases
		if ($result['aliases'] == 0)
			$this->addNDetail("People do not have nicknames for you.");
		elseif (ctype_digit($result['aliases']) && $result['aliases'] > 0) {
			if (chance($result['aliases']))
				$this->addNDetail("Known as 1 alias.");
		}
		else {
			$aliases = diceEx($result['aliases']);
			$this->addNDetail("Known as {$aliases} aliases.");
		}

		$this->addNDetail( sprintf("TiMod Modifier: <b>%s</b>", diceEx($result['modifier']) ));

		// Determine our real social status.
		$this->setup();
	}
	public function randNobileTitle() {
		if (is_null($this->nobilityTitles)) {
			$sql = "SELECT `title` FROM `nobility`";

			$result = $this->db->fetchAll($sql);

			$this->nobilityTitles = $result;
		}
		$result = randomElement($this->nobilityTitles);
		return $result['title'];
	}

	public function addDHeader($string) {
		array_push($this->details, array());
		end($this->details);
		$idx = key($this->details);
		$this->details[$idx]['header'] = $string;
		$this->details[$idx]['bullets'] = array();
	}
	public function addDBullet($string) {
		end($this->details);
		$idx = key($this->details);
		array_push($this->details[$idx]['bullets'], $string);
	}




	public function addDetail($string) { array_push($this->details, $string); }
	public function addNDetail($string) { array_push($this->nobility['details'], $string); }

	public function setMod($value) { $this->_modifier = $value; return $this; }

	public function getEntry()	{ return $this->_id; }
	public function getName() { return $this->_name; }
	public function getMod() { return $this->_modifier; }
	public function getShort() { return $this->_short; }
	public function getLit() { return $this->_litchance; }
	public function getSurvival() { return $this->_survskill; }
	public function getBaseWealth() { return $this->_basewealth; }
	public function getDescription() { return $this->_description; }
	public function getDetails() { return $this->details; }

	public function getMoney() { return $this->startingGold; }
	public function isNobile() { return $this->isNobile; }
	public function isLiterate() { return $this->isLiterate; }
	public function isDestitude() {
		if ($this->getEntry() == SOCIAL_DESTITUDE)
			return TRUE;
		return FALSE;
	}
	public function isWealthy() {
		$entry = $this->getEntry();
		if ($entry == 4 || $entry == 5 || $entry == 6)
			return TRUE;
		return FALSE;
	}
	public function isEWealthy() {
		if ($this->getEntry() == SOCIAL_EWEALTHY)
			return TRUE;
		return FALSE;
	}



	public function getSocial() {
		$social = array(
			'entry'         => $this->getEntry(),
			'name'          => $this->getName(),
			'short'         => $this->getShort(),
			'modifier'      => $this->getMod(),
			'litchance'     => $this->getLit(),
			'survskill'     => $this->getSurvival(),
			'startingMoney' => $this->getMoney(),
			'description'   => $this->getDescription(),
			'luxuries'      => $this->_luxuries,
			'patrons'       => $this->_patrons,
			'isLiterate'    => $this->isLiterate(),
			'details'       => $this->getDetails()
		);

		if ($this->isNobile()) {
			$social['nobility'] = $this->nobility;
		}

		return $social;
	}
}
?>