        \Cake\Core\Plugin::load('Search', ['path' => ROOT . DS]);

        $behavior = $this
            ->getMockBuilder('\Search\Model\Behavior\SearchBehavior')
            ->setMethods(['filterParams'])
            ->disableoriginalConstructor()
            ->getMock();

        $behavior
            ->expects($this->once())
            ->method('filterParams')
            ->will($this->returnValue([
                'search' => [
                    'name' => '1st post'
                ]
            ]));

        $blogs = \Cake\ORM\TableRegistry::get('Blogs');

        $subject = new \Crud\Event\Subject();
        $subject->query = $blogs->find();