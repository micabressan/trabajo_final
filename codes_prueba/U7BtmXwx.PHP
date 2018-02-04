    /**
     * @param  ApiTester $I
     * @param  Example $example
     * @dataprovider createDataProvider
     * @depends fixtures
     * @before authToken
     */
    public function create(ApiTester $I, Example $example)
    {
        $I->wantTo('Create a Credit Worklog record.');
        $this->internalCreate($I, $example);
    }

    /**
     * @return array<string,array> data for test `create()`.
     */
    protected function createDataProvider()
    {
        return [
            'create worklog' => [
                'urlParams' => [
                    'credit_id' => 1
                ],
                'data' => [
                    'process_id' => 2,
                    'stage_id' => 5
                ],
                'httpCode' => HttpCode::CREATED,
            ],
            'unprocessable worklog' => [
                'urlParams' => [
                    'credit_id' => 1
                ],
                'data' => [
                    'process_id' => 2,
                    'stage_id' => 1
                ],
                'httpCode' => HttpCode::UNPROCESSABLE_ENTITY,
                'validationErrors' => [
                    'stage_id' => 'Stage ID is invalid.',
                ],
            ],
        ];
    }