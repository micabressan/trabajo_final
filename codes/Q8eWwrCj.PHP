<?php
namespace Controller;

use Lib\Config;

use Framework\Http\Request;

use Framework\Factory\ServiceFactory;
use Framework\Support\Input;
use Framework\Controller\AbstractAjaxController;

class GuildController extends AbstractAjaxController
{
	public function readGuild()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readGuild($params);

		if (empty($result['alliance']) || ! $result['ownGuild']) {
			return $this->forward('Guild@viewCreate', $result);
		}

		return $result;
	}

	public function autocomplete()
	{
		$params = Input::all('post');

		return ServiceFactory::create('Alliance')->autocomplete($params);
	}

	public function viewCreate($params)
	{

		$strings = Config::load('guildTranslations', 'translations/guild');
		foreach ($strings as $key => $str) {
			Request::getInstance()->setParam('txt.' . $key, _($str));
		}
		Request::getInstance()->setParam('txt.enter_guild_name', _('alliance.enter_guild_name'));
		Request::getInstance()->setParam('txt.create', _('common.create'));

		$params['isLocked'] = getHero()->getLevel() < 15 ? true : false;

		return $params;
	}

	public function doCreate()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doCreate($params);

		$this->forward('Guild@readGuild');
	}

	public function doUpdate()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doUpdate($params);

		$this->forward('Guild@readGuild');
	}

	public function doJoin()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doJoin($params);

		$this->forward('Guild@readGuild');
	}

	public function doInvitation()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doInvitation($params);

		return array('status' => $result);
	}

	public function doLeave()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doLeave($params);

		$this->forward('Guild@readGuild');
	}

	public function doKickMember()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doKickMember($params);

		$this->forward('Guild@readGuild');
	}

	public function doChangePosition()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doChangePosition($params);

		$this->forward('Guild@readGuild');
	}

	public function readRules()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readRules($params);

		return $result;
	}

	public function doUpdateRules()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doUpdateRules($params);

		$this->forward('Guild@readRules');
	}

	//election
	public function doElectionCandidate()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doElectionCandidate($params);

		$this->forward('Guild@readGuild');
	}

	public function doElectionVote()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doElectionVote($params);

		$this->forward('Guild@readGuild');
	}

	//read stash
	public function readStash()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readStash($params);

		if (! $result) {
			return $this->forward('Guild@readGuild');
		}

		return $result;
	}

	public function doStashUpgrade()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doStashUpgrade($params);

		$this->forward('Guild@readStash');
	}

	public function doStashUpdatePermissions()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doStashUpdatePermissions($params);

		$this->forward('Guild@readStash');
	}

	public function readStashLog()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readStashLog($params);

		return $result;
	}

	//treasure
	public function readTreasury()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readTreasury($params);

		return $result;
	}

	public function doChnageTax()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doChnageTax($params);

		return $this->forward('Guild@readTreasury');
	}

	public function doDonate()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doDonate($params);

		return $this->forward('Guild@readTreasury');
	}

	//development
	public function readDevelopment()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->readDevelopment($params);

		return $result;
	}

	public function doResearch()
	{
		$params = Input::all('post');

		$result = ServiceFactory::create('Alliance')->doResearch($params);

		return $this->forward('Guild@readDevelopment');
	}
}