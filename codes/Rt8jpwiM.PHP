$validator = $this->get('swivl_user.validator.email_black_list');
$blackListConstraint = new BlackList();
$blackListErrors = $validator->validate($form->getData()->getEmail(), $blackListConstraint);

if (count($blackListErrors) > 0) {
	dump($blackListErrors);die;
}