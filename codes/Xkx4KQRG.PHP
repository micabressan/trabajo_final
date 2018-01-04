    function getAll($search = null)
    {
        $temp=$this->request;
        if ($this->requrest->is('ajax')) {
            $this->autoRender = false;
            $name = $this->request->query['term'];
            $results = $this->Users->find('all', [
                'conditions' => ['commercial_name LIKE' => $name . '%']
            ]);
            $resultsArr = [];
            foreach ($results as $result) {
                $resultsArr[] = ['label' => $result['commercial_name'], 'value' => $result['id']];
            }
            echo json_encode($resultsArr);
        }
    }