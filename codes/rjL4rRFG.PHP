 public function save()
    {
        switch($this->_saved === null)
        {
            case false:
                throw new Gorilla_Job_Exception('Cannot save. This Job has already been updated.');
            case true:
                $this->_job->getResource()->beginTransaction();
                try{
                    switch($this->_nextStateRequestUpdate)
                    {
                        default:
                            throw new Gorilla_Job_Exception('Invalid state.');
                        case Gorilla_Job_Model_Job::STATE_WORKING_RETRY:
                            $this->_job->setTimesRetried($this->_job->getTimesRetried() + 1);
                            $this->_job->setWorkAtDatetime($this->_workAtDatetimeUpdate);
                            break;
                        case Gorilla_Job_Model_Job::STATE_EMPTY:
                            switch($this->_assignedStateUpdate)
                            {
                                default:
                                    throw new Gorilla_Job_Exception('Invalid state.');
                                case Gorilla_Job_Model_Job::STATE_COMPLETE_FAILED:
                                case Gorilla_Job_Model_Job::STATE_COMPLETE_QUIT:
                                case Gorilla_Job_Model_Job::STATE_COMPLETE_SUCCESS:
                                    $this->_job->setDestroyDatetime(
                                        Mage::helper('gorilla_job/job')
                                            ->getDestroyDateTime($this->_job)
                                            ->format(Varien_Db_Adapter_Pdo_Mysql::DATETIME_FORMAT)
                                    );
                                    $this->_statusService->finalize();
                                    break 2;
                                case Gorilla_Job_Model_Job::STATE_HOLD:
                                    $this->_job->setTimesHold($this->_job->getTimesHold()+1);
                                    break 2;
                            }
                    }

                    Mage::helper('gorilla_job/job_state')->transitionJob(
                        $this->_job,
                        $this->_assignedStateUpdate,
                        $this->_nextStateRequestUpdate
                    );
                    $this->_job->getResource()->commit();
                    $this->_saved = true;
                }catch(Exception $e){
                    $this->_job->getResource()->rollBack();
                    throw $e;
                }
            // no break.
        }

        return $this;
    }