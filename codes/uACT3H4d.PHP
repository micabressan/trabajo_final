<?php
if (!defined('TYPO3_MODE')) {
	die('Access denied.');
}

\TYPO3\CMS\Extbase\Utility\ExtensionUtility::configurePlugin(
	'MM.' . $_EXTKEY,
	'Post',
	array(
		'Post' => 'list, show, new, create, edit, update, delete',
		
	),
	// non-cacheable actions
	array(
		'Post' => 'list, show, new, create, edit, update, delete',
		
	)
);

\TYPO3\CMS\Extbase\Utility\ExtensionUtility::configurePlugin(
	'MM.' . $_EXTKEY,
	'Kategorie',
	array(
		'Kategorie' => 'list, show, new, create, edit, update, delete',
		
	),
	// non-cacheable actions
	array(
		'Kategorie' => 'list, show, new, create, edit, update, delete',
		
	)
);

\TYPO3\CMS\Extbase\Utility\ExtensionUtility::configurePlugin(
	'MM.' . $_EXTKEY,
	'Bundesland',
	array(
		'Bundesland' => 'list, show, new, create, edit, update, delete',
		
	),
	// non-cacheable actions
	array(
		'Bundesland' => 'list, show, new, create, edit, update, delete',
		
	)
);

\TYPO3\CMS\Extbase\Utility\ExtensionUtility::configurePlugin(
	'MM.' . $_EXTKEY,
	'Suche',
	array(
		'Suche' => 'list,show',
		
	),
	// non-cacheable actions
	array(
		'Suche' => 'list,show',
		
	)
);