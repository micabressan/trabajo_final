<?php

$param = array(
	'Email'             => 'test@test.com',
	'ProductUniqueCode' => 'KL1941IDADR',
	'Amount'            => 1,
	'Discount'          => 0,
	'Name'              => 10,
	'Tell'              => 452542,
	'Fax'               => 452452,
	'Country'           => 'iran',
	'City'              => 'iran',
	'Comment'           => 'comment'
);

kasperskyBuy($param);
function kasperskyBuy($params) {
	//$partnerID = 'KLTEST';
	$deliveryDate = date('Y-m-d\T00:00:00\Z');

	$client = new SoapClient('http://www.soha.ae/KLsales.asmx?WSDL');
	// BEGIN LOGIN
	$strData    = strlen(KASPERSKY_PARTNER_ID).KASPERSKY_PARTNER_ID.strlen($deliveryDate).$deliveryDate;
	$hash       = $this->hmac($strData, KASPERSKY_SECURITY_KEY);
	$hash       = strtoupper($hash);
	$loginParam = array(
		'partId' => KASPERSKY_PARTNER_ID,
		'date'   => $deliveryDate,
		'hash'   => $hash
	);
	$sessionID = $client->Login($loginParam)->LoginResult;
	// E N D LOGIN
	if ($sessionID != '1') {
		$param = array(
			'SessionId'         => $sessionID,
			'Email'             => $params['Email'],
			'Time'              => $deliveryDate,
			'ProductUniqueCode' => $params['ProductUniqueCode'],
			'Amount'            => $params['Amount'],
			'Discount'          => $params['Discount'],
			'Name'              => $params['Name'],
			'Tell'              => $params['Tell'],
			'Fax'               => $params['Fax'],
			'Country'           => 'iran',
			'City'              => 'iran',
			'Comment'           => 'comment'
		);
		$strResult = $client->Sale($param)->SaleResult;
		switch ($strResult) {
			case '1':
				throw new ServiceException('Invalid sessionId', 0);
				break;
			case '2':
				throw new ServiceException('Session timeout', 0);
				break;
			case '3':
				throw new ServiceException('Invalid ProductUniqCode: '.$param['ProductUniqueCode']);

				break;
			case '4':
				throw new ServiceException('BuyCeiling', 0);

				break;
			case '5':
				throw new ServiceException('End of validity period', 0);

				break;
			case '6':
				throw new ServiceException('Kaspersky Error', 0);
				break;
			case '7':
				throw new ServiceException('SOHA Error', 0);
				break;
			default:
				return $strResult;
				break;
		}
	} else {
		throw new ServiceException('Authentication failed', 0);
	}
}