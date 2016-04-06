     echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => 'Home', 'url' => ['/site/index']],
                    ['label' => 'About', 'url' => ['/site/about']],
                    ['label' => 'Contact', 'url' => ['/site/contact']],
                    Yii::$app->user->isGuest ?
                        ['label' => 'Login', 'url' => ['/site/login']] :
                        ['label' => 'Logout (' . Yii::$app->user->identity->username . ')', // W TYM MIEJSCU WYSWIETLA MI KOMUNIKAT

Field 'username' not found in class null|yii\web\IdentityInterface less... (Ctrl+F1) 
Referenced field is not found in subject class. Note: Check is not performed on objects of type "stdClass" or derived.

                            'url' => ['/site/logout'],
                            'linkOptions' => ['data-method' => 'post']],
                    ['label' => 'Register', 'url' => ['/site/register']]
                ],
            ]);


/////////////////////////////////////////////////
 public function actionLogin()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login() ) {
            return $this->goBack(); /// ten kod sie wykonuje
        } else {
            return $this->render('login',[
                'model' => $model,
            ]);
        }
    }