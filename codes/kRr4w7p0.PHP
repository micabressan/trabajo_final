
/*MODEL LoginUser */
 public function login()
    {
        if ($this->validate()) {
         //  $ss = $this->getUser(); //test
        //   die("ID: ".$ss->ID. "username: ".$ss->username." password: ".$ss->password." email: ".$ss->email); //test
	//  validacja danych przebiega prawidlowo, Obiekt $ss klasy AcitveRecord poprawnie zaladowany danymi

            return Yii::$app->user->login($this->getUser(), $this->rememberMe ? 3600 * 24 * 30 : 0);
        } else {
            return false;
        }


/// Class Active Record

class Users extends ActiveRecord implements \yii\web\IdentityInterface
{
/*metody*/
}