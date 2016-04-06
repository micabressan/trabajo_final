 KONTROLLER

public function actionLogin()
    {
        if (!\Yii::$app->user->isGuest) {
            return $this->goHome();
        }

        $model = new LoginForm();
        if ($model->load(Yii::$app->request->post()) && $model->login() ) {
            return $this->goBack();  //metoda wykonuje się.
        } else {
            return $this->render('login',[
                'model' => $model,
            ]);
        }
    }

////////////////



main view

<?php $this->beginBody() ?>
    <div class="wrap">
        <?php
            NavBar::begin([
                'brandLabel' => 'My Company',
                'brandUrl' => Yii::$app->homeUrl,
                'options' => [
                    'class' => 'navbar-inverse navbar-fixed-top',
                ],
            ]);
            echo Nav::widget([
                'options' => ['class' => 'navbar-nav navbar-right'],
                'items' => [
                    ['label' => 'Home', 'url' => ['/site/index']],
                    ['label' => 'About', 'url' => ['/site/about']],
                    ['label' => 'Contact', 'url' => ['/site/contact']],
                    Yii::$app->user->isGuest ?
                        ['label' => 'Login', 'url' => ['/site/login']] :
                        ['label' => 'Logout (' . Yii::$app->user->identity->username . ')', ///TUTAJ NIE WIDZI USERNAME
                            'url' => ['/site/logout'],
                            'linkOptions' => ['data-method' => 'post']],
                    ['label' => 'Register', 'url' => ['/site/register']]
                ],
            ]);
            NavBar::end();
        ?>