protected function _get_authorization_action_for_method($method) {
        if (in_array($method, array('metoda1', 'metoda2'))) {
            return parent::_get_authorization_action_for_method('fisa_consultatie_programare');
        } else {
            return parent::_get_authorization_action_for_method($method);
        }
    }