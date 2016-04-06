        $listener = $this
            ->getMockBuilder('\Crud\Listener\SearchListener')
            ->setMethods(null)
            ->disableoriginalConstructor()
            ->getMock();

        $subject = new \Crud\Event\Subject();

        $listener->injectSearch(new \Cake\Event\Event('Crud.beforePaginate', $subject));