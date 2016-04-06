 public function createComponentArticleEditForm($id) {
	$from = new \DateTime($this->record->from_date);
	$to = new \DateTime($this->record->to_date);

	$form = new Form();
	$form->getElementPrototype()->role('form');
	$form->addText('title', 'NĂˇzov:')
		->setAttribute('class', 'form-control')
		->setDefaultValue($this->record->title)
		->addRule(Form::FILLED, 'ProsĂ­m vyplĹ�te pole nĂˇzov.');
	$form->addText('author', 'Autor: ')
		->setAttribute('class', 'form-control')
		->setDefaultValue($this->record->author);
	$form->addCheckbox('calendar', '')
		->setDefaultValue($this->record->calendar);
	$form->addText('from_date', 'PlatnĂ˝ od:')
		->setAttribute('class', 'form-control datepicker')
		->setDefaultValue($from->format('j.n.Y'));
	$form->addText('to_date', 'PlatnĂ˝ do:')
		->setAttribute('class', 'form-control datepicker')
		->setDefaultValue($to->format('j.n.Y'));
	$form->addTextArea('perex', 'Perex: ', 120, 2)
		->setAttribute('class', 'form-control')
		->setDefaultValue($this->record->perex);
	$form->addTextArea('html', 'Obsah:', 120, 20)
		->setAttribute('class', 'form-control')
		->setDefaultValue($this->record->html);
	$form->addHidden('id', $this->record->id);
	$form->addHidden('created', $this->record->created);
	$form->addSubmit('save', 'ULOĹ˝IĹ¤ ZMENY')->setAttribute('class', 'btn btn-default btn-md');
	$form->onSuccess[] = $this->articleEditFormSubmited;
	return $form;
    }