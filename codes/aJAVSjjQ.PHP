<?php
header('Content-Type: text/html; charset=UTF-8');

ini_set('display_errors', 1);

require('../../board/lib/common.php');

//if (!$log)
//	die('nah lol');


// kill magic_quotes but alsdjf
if (get_magic_quotes_gpc()) {
foreach ($_GET as $k => $v) $_GET[$k] = stripslashes($v);
foreach ($_POST as $k => $v) $_POST[$k] = stripslashes($v);
}

if (isset($_GET['e'])) { $_GET['act'] = 'edit'; $_GET['id'] = $_GET['e']; }

// the array of actions we can do, which include listing certain types
$actions = array('list', 'edit', 'modsprite', 'submitsprite', 'listunused', 'listunknown', 'listknown', 'listcomplete');
$action = $_GET['act'];
if (!in_array($action, $actions)) $action = 'list';
	

print "
<html>
  <head>
    <meta http-equiv='Content-Type' content='text/html;charset=utf-8'>
<link href=\"icon.png\" rel=\"icon\" type=\"image/png\" />
    <style type='text/css'>
      body { font-family: Arial, sans-serif; font-size: 13px; }
      div.unusedp, div.unknownp, div.knownp, div.completep { border-top: 1px solid #000; border-bottom: 1px solid #000; text-align: center; font-size: 11px; line-height: 16px; float: left; height: 16px; }
      /*div.unusedp { background: #d6c6ff; border-right: 1px solid #000; }*/
      div.unknownp { background: #ffc9cd; border-right: 1px solid #000; }
      div.knownp { background: #ffd696; border-right: 2px solid #000; }
      div.completep { background: #c6ff9b; border-left: 1px solid #000; border-right: 2px solid #000; }
      tr.unknown { background: #ffc9cd; }
      tr.known { background: #ffd696; }
      tr.complete { background: #c6ff9b; }
      td.original { background: #d6c6ff; border: 1px solid #000; }
      table.sprites td { padding: 2px; }
      table.data td { background: #fff; font-size: 12px; }
      table.origdata td { }
      table.origdata tr.datarow td { border-top: 1px solid #000; font-family: monospace; padding: 0px; }
      div.groupbox { border: 1px solid #000; width: 80%; padding: 2px; }
      div.groupbox div.header { background: #d1ecff; padding: 2px; }
      div.groupbox div.content { padding: 6px; }
      div.groupbox form { margin: 0px; }
      div.groupbox input.submit { margin: 6px 4px 0px 4px; }
      div.groupbox input.text, div.groupbox select { border: 1px solid #303030; font-family: Arial, sans-serif; font-size: 12px; }
      hr { color: #000000; background-color: #000000; height: 1px; border: 0; margin: 4px 0px; }
      table.fieldeditor td { padding: 0px; }
      table.fieldeditor tr.header td { font-size: 9px; }
	  textarea { resize: none; }
    </style>
  </head>
  <body>
    <h1>NSMBW Sprite Database</h1>
	<br>";

  // if we're looking at the entire list
  switch ($action) {
    case 'list':
	 
      $gettotal = mysqli_fetch_array(Query('select count(id) from nsmbw_sprites WHERE id BETWEEN 0 AND 723'));
      $getoriginal = mysqli_fetch_array(Query('select count(id) from nsmbw_sprites where orig = 1 AND id BETWEEN 0 AND 723'));
      $getknown = mysqli_fetch_array(Query('select count(id) from nsmbw_sprites where known = 1 AND id BETWEEN 0 AND 723'));
      $getcomplete = mysqli_fetch_array(Query('select count(id) from nsmbw_sprites where complete = 1 AND id BETWEEN 0 AND 723'));

      $fields = array();
      $getfields = Query('select * from nsmbw_fields order by CAST(nybble as SIGNED INTEGER) asc');
      while ($row = mysqli_fetch_array($getfields)) {
        $s = $row[1];
        if (!isset($fields[$s])) $fields[$s] = array();
        $fields[$s][] = $row;
      }

	  // nab our values for complete, original, known, and unknown.
      $c = intval($getcomplete[0]);
      $o = $getoriginal[0];
      $k = $getknown[0] - $c;
      $u = $gettotal[0] - $k - $c;// - $o;
	  
	  $ct = $c + $k + $u;
	  
	  // generates a random number inbetween 0, and 723. 
	  // used for a random sprite chooser
	  $takemesomewhere = rand(0, 482);
	  
	  // calculating percents, basic algebra
	  // complete divided by the total, times by 100.
	  $cpercent = $c / $ct * 100;
	  $kpercent = $k / $ct * 100;
	  $upercent = $u / $ct * 100;
	 
	  print "<title>NSMBW Sprite Database</title>";
	  
	  $cu = $u - 1;
	  
	  // we have our marker bar here, along with the amount inside each section, along with a percent complete.
      print "&nbsp;{$gettotal[0]} total, $o unused";
      if ($c > 0) print "<div class='completep' style='width: {$c}px'>$c (" . round($cpercent) . "%)</div>";
      if ($k > 0) print "<div class='knownp' style='width: {$k}px'>$k (" . round($kpercent) . "%)</div>";
      if ($u > 0) print "<div class='unknownp' style='width: {$cu}px'>$cu (" . round($upercent) . "%)</div>";
      //print "<div class='unusedp' style='width: {$o}px'>$o</div>";
      print "<br><br>The above bar needs <i>more green</i>. HELP US MAKE IT HAPPEN!<br>";
	  
	
      print "<br><br>Is the data in your Reggie outdated? <a href='spritexml.php'>Click here</a> for an automatically generated version of spritedata.xml which you can put into your Reggie data folder containing all the data listed here!<br>
Here is how the system works. All of the sprites, used and unused, are listed here. You document the data of the sprite, and mark it.<br>
<ul>
<li>Complete (Green) - All of the data is documented. All of the possible nybbles, and the name and description are clear.</li>
<li>Known (Orange) - Sprite's function is known. However, it's nybbles are not known.</li>
<li>Unknown (Red) - Nothing is known about the sprite.</li>
<li>Unused (Purple) - The sprite is not used in the retail game.</li>
</ul>
Please keep this database clean. Any abuse will lead to an entire ban from the server. I can see when somebody is misusing this database.<br><br>
Please, don't mark an object complete when there's missing sprite data. Make sure everything is documented.<br><br>

Font colors are allowed in nybble descriptions and sprite notes. Just use this syntax:<br>
&#60;font color=\"COLOR\"&#62;your text here&#60;/font&#62;<br>
You can use these basic colors: purple, red, blue, green, yellow, and many more.
<br><br>

Filter Results -- • Regular • <a href='?act=listunknown'>Unknown</a> • <a href='?act=listknown'>Known</a> • <a href='?act=listcomplete'>Complete</a> • <a href='?act=listunused'>Unused</a><br><br>
<a href='spriteDB.php?e=" . $takemesomewhere . "'>Random Sprite</a><br>
";

  if ($loguser['primarygroup'] == -1)
		print "<h1>You can view this database, however, you can't edit it. You are banned.</h1>";
  print "<br><br>";
  // we begin to print out table with entries
  print "<table style='width: 80%' class='sprites'><tr><td style='width: 48px'>ID:</td><td>Name:</td></tr>";
  $getsprites = Query('select * from nsmbw_sprites where id BETWEEN 0 AND 723 order by id');
  while ($row = mysqli_fetch_array($getsprites)) {
	if ($row[2] == 0) {
	  $class = 'unknown';
	} else {
	  if ($row[3] == 0) {
		$class = 'known';
	  } else {
		$class = 'complete';
	  }
	}

	if ($row[4] == 0) {
	  $orig = '';
	  $origs = '';
	} else {
	  $orig = " class='original'";
	  $origs = '*';
	}

	print "<tr class='$class'><td{$orig}><a href='spriteDB.php?e=$row[0]'>$row[0]</a>{$origs}</td><td>".htmlspecialchars($row[1]);

	if (isset($fields[$row[0]])) {
	  print "<table style='width: 100%' class='data'>";
	  foreach ($fields[$row[0]] as $field) {
		print "<tr><td>";
		switch ($field[2]) {
		  case 'checkbox':
			print "<b>".htmlspecialchars($field[6])."</b>: checkbox on nybble ".htmlspecialchars($field[5])." with mask ".htmlspecialchars($field[4]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'value':
			print "<b>".htmlspecialchars($field[6])."</b>: value at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'index':
			print "<b>".htmlspecialchars($field[6])."</b>: index at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'list':
			//$listentries = str_replace("\n", ', ', $field[4]);
			//$listentries = substr($listentries, 0, -2);
			$listentries = str_replace("\n", ', ', rtrim($field[4]));
			print "<b>".htmlspecialchars($field[6])."</b>: list at nybble ".htmlspecialchars($field[5]).": $listentries";
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		}
		print "</td></tr>";
	  }
	  print "</table>";
	}

	print "</td></tr>";
  }
  print "</table>";

  break;
  
// we list unused stuff here
case 'listunused': 
print "<title>NSMBW Sprite Database</title>";
  $fields = array();
  $getfields = Query('select * from nsmbw_fields order by CAST(nybble as SIGNED INTEGER) asc');
  while ($row = mysqli_fetch_array($getfields)) {
	$s = $row[1];
	if (!isset($fields[$s])) $fields[$s] = array();
	$fields[$s][] = $row;
  }
  
print "Filter Results -- • <a href='?act=list'>Regular</a> • <a href='?act=listunknown'>Unknown</a> • <a href='?act=listknown'>Known</a> • <a href='?act=listcomplete'>Complete</a> • Unused<br>";

  if ($loguser['primarygroup'] == -1)
		print "<h1>You can view this database, however, you can't edit it. You are banned.</h1>";
  print "<br><br>";
  print "<table style='width: 80%' class='sprites'><tr><td style='width: 48px'>ID:</td><td>Name:</td></tr>";
  $getsprites = Query('SELECT * FROM nsmbw_sprites WHERE orig=1 AND id BETWEEN 0 AND 723');
  while ($row = mysqli_fetch_array($getsprites)) {
	if ($row[2] == 0) {
	  $class = 'unknown';
	} else {
	  if ($row[3] == 0) {
		$class = 'known';
	  } else {
		$class = 'complete';
	  }
	}

	if ($row[4] == 0) {
	  $orig = '';
	  $origs = '';
	} else {
	  $orig = " class='original'";
	  $origs = '*';
	}

	if (!$loguserid)
		print "<tr class='$class'><td{$orig}>$row[0]{$origs}</td><td>".htmlspecialchars($row[1]);
	else
		print "<tr class='$class'><td{$orig}><a href='spriteDB.php?e=$row[0]'>$row[0]</a>{$origs}</td><td>".htmlspecialchars($row[1]);

	if (isset($fields[$row[0]])) {
	  print "<table style='width: 100%' class='data'>";
	  foreach ($fields[$row[0]] as $field) {
		print "<tr><td>";
		switch ($field[2]) {
		  case 'checkbox':
			print "<b>".htmlspecialchars($field[6])."</b>: checkbox on nybble ".htmlspecialchars($field[5])." with mask ".htmlspecialchars($field[4]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]);
			break;
		  case 'value':
			print "<b>".htmlspecialchars($field[6])."</b>: value at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'index':
			print "<b>".htmlspecialchars($field[6])."</b>: index at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'list':
			$listentries = str_replace("\n", ', ', rtrim($field[4]));
			print "<b>".htmlspecialchars($field[6])."</b>: list at nybble ".htmlspecialchars($field[5]).": $listentries";
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		}
		print "</td></tr>";
	  }
	  print "</table>";
	}

	print "</td></tr>";
  }
  print "</table>";

  break;	
 
case 'listunknown': 
 print "<title>NSMBW Sprite Database</title>";
  $fields = array();
  $getfields = Query('select * from nsmbw_fields order by CAST(nybble as SIGNED INTEGER) asc');
  while ($row = mysqli_fetch_array($getfields)) {
	$s = $row[1];
	if (!isset($fields[$s])) $fields[$s] = array();
	$fields[$s][] = $row;
  }
  
print "Filter Results -- • <a href='?act=list'>Regular</a> • Unknown • <a href='?act=listknown'>Known</a> • <a href='?act=listcomplete'>Complete</a> • <a href='?act=listunused'>Unused</a><br>";

  if ($loguser['primarygroup'] == -1)
		print "<h1>You can view this database, however, you can't edit it. You are banned.</h1>";
  print "<br><br>";
  print "<table style='width: 80%' class='sprites'><tr><td style='width: 48px'>ID:</td><td>Name:</td></tr>";
  $getsprites = Query('SELECT * FROM nsmbw_sprites WHERE known=0 AND complete=0 AND id BETWEEN 0 AND 723');
  while ($row = mysqli_fetch_array($getsprites)) {
	if ($row[2] == 0) {
	  $class = 'unknown';
	} else {
	  if ($row[3] == 0) {
		$class = 'known';
	  } else {
		$class = 'complete';
	  }
	}

	if ($row[4] == 0) {
	  $orig = '';
	  $origs = '';
	} else {
	  $orig = " class='original'";
	  $origs = '*';
	}

	if (!$loguserid)
		print "<tr class='$class'><td{$orig}>$row[0]{$origs}</td><td>".htmlspecialchars($row[1]);
	else
		print "<tr class='$class'><td{$orig}><a href='spriteDB.php?e=$row[0]'>$row[0]</a>{$origs}</td><td>".htmlspecialchars($row[1]);

	if (isset($fields[$row[0]])) {
	  print "<table style='width: 100%' class='data'>";
	  foreach ($fields[$row[0]] as $field) {
		print "<tr><td>";
		switch ($field[2]) {
		  case 'checkbox':
			print "<b>".htmlspecialchars($field[6])."</b>: checkbox on nybble ".htmlspecialchars($field[5])." with mask ".htmlspecialchars($field[4]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'value':
			print "<b>".htmlspecialchars($field[6])."</b>: value at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'index':
			print "<b>".htmlspecialchars($field[6])."</b>: index at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'list':
			//$listentries = str_replace("\n", ', ', $field[4]);
			//$listentries = substr($listentries, 0, -2);
			$listentries = str_replace("\n", ', ', rtrim($field[4]));
			print "<b>".htmlspecialchars($field[6])."</b>: list at nybble ".htmlspecialchars($field[5]).": $listentries";
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		}
		print "</td></tr>";
	  }
	  print "</table>";
	}

	print "</td></tr>";
  }
  print "</table>";

  break;	

case 'listknown': 
 print "<title>NSMBW Sprite Database</title>";
  $fields = array();
  $getfields = Query('select * from nsmbw_fields order by CAST(nybble as SIGNED INTEGER) asc');
  while ($row = mysqli_fetch_array($getfields)) {
	$s = $row[1];
	if (!isset($fields[$s])) $fields[$s] = array();
	$fields[$s][] = $row;
  }	
print "Filter Results -- • <a href='?act=list'>Regular</a> • <a href='?act=listunknown'>Unknown</a> • Known • <a href='?act=listcomplete'>Complete</a> • <a href='?act=listunused'>Unused</a><br>";

  if ($loguser['primarygroup'] == -1)
		print "<h1>You can view this database, however, you can't edit it. You are banned.</h1>";
  print "<br><br>";
  print "<table style='width: 80%' class='sprites'><tr><td style='width: 48px'>ID:</td><td>Name:</td></tr>";
  $getsprites = Query('SELECT * FROM nsmbw_sprites WHERE known=1 AND complete=0 AND id BETWEEN 0 AND 723');
  while ($row = mysqli_fetch_array($getsprites)) {
	if ($row[2] == 0) {
	  $class = 'unknown';
	} else {
	  if ($row[3] == 0) {
		$class = 'known';
	  } else {
		$class = 'complete';
	  }
	}

	if ($row[4] == 0) {
	  $orig = '';
	  $origs = '';
	} else {
	  $orig = " class='original'";
	  $origs = '*';
	}

	if (!$loguserid)
		print "<tr class='$class'><td{$orig}>$row[0]{$origs}</td><td>".htmlspecialchars($row[1]);
	else
		print "<tr class='$class'><td{$orig}><a href='spriteDB.php?e=$row[0]'>$row[0]</a>{$origs}</td><td>".htmlspecialchars($row[1]);

	if (isset($fields[$row[0]])) {
	  print "<table style='width: 100%' class='data'>";
	  foreach ($fields[$row[0]] as $field) {
		print "<tr><td>";
		switch ($field[2]) {
		  case 'checkbox':
			print "<b>".htmlspecialchars($field[6])."</b>: checkbox on nybble ".htmlspecialchars($field[5])." with mask ".htmlspecialchars($field[4]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'value':
			print "<b>".htmlspecialchars($field[6])."</b>: value at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'index':
			print "<b>".htmlspecialchars($field[6])."</b>: index at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'list':
			//$listentries = str_replace("\n", ', ', $field[4]);
			//$listentries = substr($listentries, 0, -2);
			$listentries = str_replace("\n", ', ', rtrim($field[4]));
			print "<b>".htmlspecialchars($field[6])."</b>: list at nybble ".htmlspecialchars($field[5]).": $listentries";
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		}
		print "</td></tr>";
	  }
	  print "</table>";
	}

	print "</td></tr>";
  }
  print "</table>";

  break;		  
  
case 'listcomplete': 
 print "<title>NSMBW Sprite Database</title>";
  $fields = array();
  $getfields = Query('select * from nsmbw_fields order by CAST(nybble as SIGNED INTEGER) asc');
  while ($row = mysqli_fetch_array($getfields)) {
	$s = $row[1];
	if (!isset($fields[$s])) $fields[$s] = array();
	$fields[$s][] = $row;
  }
  
print "Filter Results -- • <a href='?act=list'>Regular</a> • <a href='?act=listunknown'>Unknown</a> • <a href='?act=listknown'>Known</a> • Complete • <a href='?act=listunused'>Unused</a><br>";

  if ($loguser['primarygroup'] == -1)
		print "<h1>You can view this database, however, you can't edit it. You are banned.</h1>";
  print "<br><br>";
  print "<table style='width: 80%' class='sprites'><tr><td style='width: 48px'>ID:</td><td>Name:</td></tr>";
  $getsprites = Query('SELECT * FROM nsmbw_sprites WHERE known=1 AND complete=1 AND id BETWEEN 0 AND 723');
  while ($row = mysqli_fetch_array($getsprites)) {
	if ($row[2] == 0) {
	  $class = 'unknown';
	} else {
	  if ($row[3] == 0) {
		$class = 'known';
	  } else {
		$class = 'complete';
	  }
	}

	if ($row[4] == 0) {
	  $orig = '';
	  $origs = '';
	} else {
	  $orig = " class='original'";
	  $origs = '*';
	}

	if (!$loguserid)
		print "<tr class='$class'><td{$orig}>$row[0]{$origs}</td><td>".htmlspecialchars($row[1]);
	else
		print "<tr class='$class'><td{$orig}><a href='spriteDB.php?e=$row[0]'>$row[0]</a>{$origs}</td><td>".htmlspecialchars($row[1]);

	if (isset($fields[$row[0]])) {
	  print "<table style='width: 100%' class='data'>";
	  foreach ($fields[$row[0]] as $field) {
		print "<tr><td>";
		switch ($field[2]) {
		  case 'checkbox':
			print "<b>".htmlspecialchars($field[6])."</b>: checkbox on nybble ".htmlspecialchars($field[5])." with mask ".htmlspecialchars($field[4]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'value':
			print "<b>".htmlspecialchars($field[6])."</b>: value at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'index':
			print "<b>".htmlspecialchars($field[6])."</b>: index at nybble ".htmlspecialchars($field[5]);
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		  case 'list':
			//$listentries = str_replace("\n", ', ', $field[4]);
			//$listentries = substr($listentries, 0, -2);
			$listentries = str_replace("\n", ', ', rtrim($field[4]));
			print "<b>".htmlspecialchars($field[6])."</b>: list at nybble ".htmlspecialchars($field[5]).": $listentries";
			if ($field[3] != '') print " (comment: ".htmlspecialchars($field[3]).")";
			break;
		}
		print "</td></tr>";
	  }
	  print "</table>";
	}

	print "</td></tr>";
  }
  print "</table>";

  break;		  
  
case 'addsprite':
  print "<title>Add Sprite - NSMBW Sprite Database</title>";

  print "<div class='groupbox' style='width: 500px'>";
  print "<div class='header'>New Sprite Info:</div>";
  print "<div class='content'>";
  print "<form action='spriteDB.php?act=submitsprite' method='post'>";

  print "ID: <input type='text' name='spriteid' value='' class='text'><br>";
  print "Name: <input type='text' name='newspritename' value='' class='text'>";
  
  print "<br>";
  print "<b>Notes:</b><br>";
  $notes = htmlspecialchars($sprite[5]);
  print "<textarea name='newnotes' rows='4' cols='60' style='font-family: Arial,sans-serif'>$notes</textarea>";
  print "<center>";
  print "<input type='submit' name='submitsprite' value='Add Sprite' class='submit'>";
  print "</center>";
  print "</form>";
  print "</div></div>";
  break;
  
case 'edit':
  $id = $_GET['id'];
  
  // stop using strings, jesus
  if (!is_numeric($id)) { die('no'); }
  $id = intval($id);

  $getsprite = Query("select * from nsmbw_sprites where id = $id");
  $sprite = mysqli_fetch_array($getsprite);
  
  // ways to generate the link to the previous sprite, and the next
  $prevsprite = $id - 1;
  $nextsprite = $id + 1;
  
  // void
  if ($id <= -1) 
	die("*various whooshing sounds, the void has been opened*");

  // c:
  if ($id >= 9999) 
	die("this is here because RoadrunnerWMC thinks he is smart<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>he really isnt");

  // invalid id
  if (numRows($getsprite) == 0) { die("Can't find the sprite ID $id"); }
  
  // redefine this for this function, for some reason it undefines itself once inserted here
  $takemesomewhere = rand(0, 482);

  print "<a href='spriteDB.php'>Return to the main sprite list</a><hr>";
  print "<a href='spriteDB.php?e=" . $prevsprite . "'>Previous Sprite</a> -- <a href='spriteDB.php?e=" . $nextsprite . "'>Next Sprite</a><hr>";
  print "<a href='spriteDB.php?e=" . $takemesomewhere . "'>TAKE ME SOMEWHERE RANDOM</a><br>";
  print "<title>".htmlspecialchars($sprite[1])." ($id) — NSMBW Sprite Database</title>";
  print "<h2>Editing sprite ".htmlspecialchars($sprite[1])." ($id):</h2>";

  print "<div class='groupbox' style='width: 600px'>";
  print "<div class='header'>Loaded Files:</div>";
  print "<div class='content'>";
  print "<form action='spriteDB.php?act=modsprite&id={$id}&set=flags' method='post'>";
  $loadedfiles = htmlspecialchars($sprite[27]);
  print "<textarea name='loadedfiles' rows='6' cols='60' style='font-family: Arial,sans-serif'>$loadedfiles</textarea><br>";
  print "<input type='submit' name='saveflags' value='Save Info' class='submit'>";
  print "</div></div>";
  print "<br>";	  

  print "<div class='groupbox' style='width: 500px'>";
  print "<div class='header'>Modify Info:</div>";
  print "<div class='content'>";
  print "<form action='spriteDB.php?act=modsprite&id={$id}&set=flags' method='post'>";

  $n = htmlspecialchars($sprite[1]);
  print "Name: <input type='text' name='spritename' value=\"{$n}\" class='text'>";

  $known = ($sprite[2] == 1) ? " checked='checked'" : '';
  $complete = ($sprite[3] == 1) ? " checked='checked'" : '';
  $orig = ($sprite[4] == 1) ? " checked='checked'" : '';

  print "<br>";
  print "<input type='checkbox' name='known' value='yes'{$known}> This sprite's purpose is known";
  print "<br>";
  print "<input type='checkbox' name='complete' value='yes'{$complete}> This sprite's data is complete";
  print "<br>";
  print "<input type='checkbox' name='orig' value='yes'{$orig}> This sprite does not appear in the standard levels";
  print "<br>";
  print "<b>Notes:</b><br>";
  $notes = htmlspecialchars($sprite[5]);
  print "<textarea name='notes' rows='4' cols='60' style='font-family: Arial,sans-serif'>$notes</textarea>";
  print "<br>";
  print "<center>";
  print "<input type='submit' name='saveflags' value='Save Info' class='submit'>";
  print "<input type='submit' name='saveflagsandreturn' value='Save Info and Go Back' class='submit'>";
  print "</center>";
  print "</form>";
  print "</div></div>";

  print "<br>";

  // fields
  print "<div class='groupbox' style='width: 1200px'>";
  print "<div class='header'>Modify Fields:</div>";
  print "<div class='content'>";
  print "<form action='spriteDB.php?act=modsprite&id={$id}&set=fields' method='post'>";
  
?>
<script language='JavaScript'>
function showhidetypeinfo() {
  var elem = document.getElementById('typeinfo');
  if (elem.style.display == 'none') elem.style.display = 'block';
  else if (elem.style.display == 'block') elem.style.display = 'none';
  return false;
}
</script>
<b>Field Types and Descriptions:</b> (<a href='' onclick='showhidetypeinfo(); return false'>Show/Hide Info</a>)<hr>
<div id='typeinfo' style='display: none'><i>Checkbox</i>: Activates/deactivates a specific bit in a nybble. Use this for flags and simple on/off properties. Set the data to the value of the bit that will be activated - for example, if the value needs to be 2 to be on, enter 2 in the data field. More than one checkbox on the same nybble will work if there are several flags, as long as they have different data fields.<hr>
<i>Value</i>: A simple value which shows up as a spinner in Reggie. It can be larger than one nybble - just enter the nybble numbers like this: <i>11-12</i>. The data field is not used.<hr>
<i>List</i>: Lets you choose from a list of values. Enter the values like this into the data field: <i>0=Right, 1=Up+Right, 2=Up, 3=Up+Left</i> - It can use more than one nybble, using the same method as values. Missing values will automatically show up in Reggie as unknown/unused within the list. DO NOT USE COMMAS IN VALUE NAMES. THIS WILL BREAK THE SPRITEDATA.<hr>
<i>Index</i>: Works in the same way as the value field, but is used for indexes that connect different sprites, like the rotation indexes.<hr>
</div>
<?php
  $getfields = Query("select * from nsmbw_fields where sprite = $id order by CAST(nybble as SIGNED INTEGER) asc");
  if (numRows($getfields) == 0) {
	print "This sprite has no fields.";
  } else {
	print "<table class='fieldeditor' style='width: 100%'>";
	print "<tr class='header'><td>Title:</td><td>Nybble:</td><td>Type:</td><td>Data:</td><td>Comment:</td><td></td></tr>";
	$fieldtypes = array('checkbox', 'value', 'list', 'index');
	while ($row = mysqli_fetch_array($getfields)) {
	  $i = $row[0];
	  $title = htmlspecialchars($row[6]);
	  $nybble = htmlspecialchars($row[5]);
	  $type = $row[2];
	  $data = htmlentities(str_replace("\n", ', ', rtrim($row[4])), 0);
	  $comment = htmlentities($row[3]);
	  print "<tr>";
	  print "<td><input type='text' name='title[$i]' value=\"$title\" size='20' class='text'></td>";
	  print "<td><input type='text' name='nybble[$i]' value=\"$nybble\" size='6' class='text'></td>";
	  print "<td><select name='type[$i]'>";
	  foreach ($fieldtypes as $t) {
		print "<option value='$t'";
		if ($t == $type) print " selected='selected'";
		print ">$t</option>";
	  }
	  print "</select></td>";
	  print "<td><input type='text' name='data[$i]' value=\"$data\" size='65' class='text'></td>";
	  print "<td><input type='text' name='comment[$i]' value=\"$comment\" size='50' class='text'></td>";
	  print "<td style='font-size: 10px'><a href='spriteDB.php?act=modsprite&id={$id}&field={$i}&set=deleteit'>delete</a></td>";
	  print "</tr>";
	}
	print "</table>";
  }

  print "<center>";
  print "<input type='submit' name='savefields' value='Save Fields' class='submit'>";
  print "<input type='submit' name='addfield' value='Save and Add New Field' class='submit'>";
  print "</center>";
  print "</form>";
  print "</div></div>";

  
  print "<br>";

  print "<div class='groupbox' style='width: 700px'>";
  print "<div class='header'>Existing In-Game Sprite Data:</div>";
  print "<div class='content'>";
  print "<form action='spriteDB.php?act=modsprite&id={$id}&set=spritedata' method='post'>";
  $getdata = Query("select * from nsmbw_origdata where sprite = $id");
  if (numRows($getdata) == 0) {
	print "This sprite isn't used in the original game.";
  //print "<center>"; this looks ugly
  //print "<input type='submit' name='savess' value='Save Spritedata Set' class='submit'>";
  //print "<input type='submit' name='saveandaddss' value='Save and Add New Spritedata Set' class='submit'>";
  //print "</center>";		
  } else {
	$datavalues = array();
	print "<table class='origdata'><tr><td style='width: 250px'><b>Data</b></td><td><b>Levels</b>";
	while ($row = mysqli_fetch_array($getdata)) {
	  if (!isset($datavalues[$row[2]])) $datavalues[$row[2]] = array();
	  $datavalues[$row[2]][] = $row[1];
	  //print "<tr><td>$row[1]</td><td>$row[2]</td></tr>";
	}
	foreach ($datavalues as $data => $levels) {
	  print "<tr class='datarow'><td valign='top'>$data</td><td>".implode(', ', $levels)."</td>";
	  //print "<td style='font-size: 10px'><a href='spriteDB.php?act=modsprite&id={$id}&spritedata={$entrydata}&set=deletedata'>delete</a></td></tr>";
	}
  //print "<center>"; this looks ugly
  //print "<input type='submit' name='savess' value='Save Spritedata Set' class='submit'>";
  //print "<input type='submit' name='saveandaddss' value='Save and Add New Spritedata Set' class='submit'>";
  //print "</center>";
  print "</table>";
  }
  print "</div>";

  break;
  
case 'modsprite':
  $id = $_GET['id'];
  if (!is_numeric($id)) { die('Invalid sprite ID'); }
  $id = intval($id);

  $getsprite = Query("select * from nsmbw_sprites where id = $id");
  if (numRows($getsprite) == 0) { die("Can't find the sprite ID $id"); }
  $sprite = mysqli_fetch_array($getsprite);

  if ($_GET['set'] == 'flags') {
	// SAVE FLAGS
	$type = 0;
	if (strpos($_POST['spritename'], 'script') !== false)
		die('no');
	if (strpos($_POST['notes'], 'script') !== false)
		die('no');
	if (strpos($_POST['loadedfiles'], 'script') !== false)
		die('no');
	if (strpos($_POST['actorname'], 'script') !== false)
		die('no');
	$known = 0; if ($_POST['known'] == 'yes') $known = 1;
	$complete = 0; if ($_POST['complete'] == 'yes') $complete = 1;
	$orig = 0; if ($_POST['orig'] == 'yes') $orig = 1;
	$spritename = mysqli_escape_string($dblink, $_POST['spritename']);
	$notes = mysqli_escape_string($dblink, $_POST['notes']);
	$loadedfiles =  mysqli_escape_string($dblink, $_POST['loadedfiles']);	

	$doublederp = Query("update {nsmbw_sprites} set known=$known, complete=$complete, name='$spritename', orig='$orig', notes='$notes' where id=$id");
	//Query("update sprites set known=$known, complete=$complete, name='$spritename', orig='$orig', notes='$notes', actorname='$actorname', enemiesoverworld='$enemiesoverworld', enemiesdesert='$enemiesdesert', enemiesunderground='$enemiesunderground', enemiestowerandcastle='$enemiestowerandcastle', enemiesairship='$enemiesairship', enemieslava='$enemieslava', enemiessnow='$enemiessnow', enemiesjungle='$enemiesjungle', enemiesbig='$enemiesbig', controllers='$controllers', events='$events', platforms='$platforms', bosses='$bosses', rotationcontrolled='$rotationcontrolled', useslines='$useslines', usespaths='$usespaths', items='$items', lightingandeffects='$lightingandeffects', enemiesghost='$enemiesghost', enemiessky='$enemiessky', objfile='$loadedfiles', levelmechs='$levelmechs', enemiesunder='$enemiesunder', gen='$gen', useless='$useless' where id=$id");

	if ($known == 1)          
		$knownblarg = "Known";
else
  $knownblarg = "Unknown";
	if ($complete == 1)
		$completeblarg = "complete";
else
  $completeblarg = "incomplete";
	if ($orig == 1)
		$unused = "\x0314, \x0303unused";
else
  $unused = "";

  } elseif ($_GET['set'] == 'fields') {
	// SAVE FIELDS
	$type = 1;

	if (isset($_POST['title']) && is_array($_POST['title']) && count($_POST['title']) > 0) {
	  foreach ($_POST['title'] as $fid => $data) {
		if ($data == 'New Field')
			die('Come up with a better name, please.');
		$iid = intval($fid); $idata = mysqli_escape_string($dblink, $data);
		Query("update {nsmbw_fields} set title = '$idata' WHERE id = $iid");
	  }
	  foreach ($_POST['nybble'] as $fid => $data) {
		$iid = intval($fid); $idata = mysqli_escape_string($dblink, $data);
		Query("update {nsmbw_fields} set nybble = '$idata' WHERE id = $iid");
	  }
	  foreach ($_POST['type'] as $fid => $data) {
		$iid = intval($fid); $idata = mysqli_escape_string($dblink, $data);
		Query("update {nsmbw_fields} set type = '$idata' WHERE id = $iid");
	  }
	  foreach ($_POST['data'] as $fid => $data) {
		$iid = intval($fid); $idata = mysqli_escape_string($dblink, $data);
		Query("update {nsmbw_fields} set data = '$idata' WHERE id = $iid");
	  }
	  foreach ($_POST['comment'] as $fid => $data) {
		$iid = intval($fid); $idata = mysqli_real_escape_string($dblink, $data);
		Query("update {nsmbw_fields} set comment = '$idata' WHERE id = $iid");
	  }
 }
 
	if (isset($_POST['addfield'])) {
	  Query("insert into nsmbw_fields (sprite,title,nybble,type,data,comment) values ($id,'New Field','1','value','','')");
	}

  } elseif ($_GET['set'] == 'deleteit') {
	$fid = intval($_GET['field']);
	Query("delete from nsmbw_fields where id = $fid");
  
  } elseif ($_GET['set'] == 'deletedata') {
	$entryid = intval($_GET['entryid']);
	Query("delete from nsmbw_origdata where entryid = $entryid");
  }	  

  if (isset($_POST['saveflagsandreturn'])) {
	header("Location: spriteDB.php");
  } else {
	header("Location: spriteDB.php?e=$id");
  }
  
  if (isset($_POST['savess'])) {
	$type = 2;
	$derp = Query("insert into {nsmbw_origdata} (sprite, level, data, entryid) values ({0}, {1}, {2}, {3})", $id, $_POST['game'] . ' ' . $_POST['levelname'] . ' ' . $_POST['levelnum'], $_POST['nybset1'] . ' ' . $_POST['nybset2'] . ' ' . $_POST['nybset3'] . ' ' . $_POST['nybset4'] . ' ' . $_POST['nybset5'] . ' ' . $_POST['nybset6'], 0);
	}

  break;
}
?></body>
</html><?php ob_end_flush(); ?>