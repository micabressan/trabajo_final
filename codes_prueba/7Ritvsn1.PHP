MODEL USERS
/////////////////////////////////////////////////////////////////////////////////////////
<?php

namespace app\models;

use \yii\web\IdentityInterface;
use yii\db\ActiveRecord;

class Users extends ActiveRecord implements \yii\web\IdentityInterface
{

   public static function tableName()
    {
        return 'users';
    }

    public static function findIdentity($id)
    {
        return static::findOne($id);
    }

    public static function findIdentityByAccessToken($token, $type = null)
    {
        return static::findOne(['access_token' => $token]);
    }

    public function getId()
    {
        return $this->ID;
    }
    public static function findByUsername($username)
    {
        $user = Users::find()->where(['username' => $username])->one();
        if(!empty($user)) {
            return $user;
        }
    }

    public function getAuthKey()
    {
       // return $this->authKey;
        return "test1";
    }

    public function validateAuthKey($authKey)
    {
        return $this->authKey === $authKey;
    }
    public function validatePassword($password)
    {
        if ($this->password == $password)
            return true;
        else
            return false;


    }
}
/////////////////////////////////////////////////////////////////////////////////////////
MODEL LOGIN
<?php

namespace app\models;

use Yii;
use app\models\Users;
use yii\base\Model;

/**
 * LoginForm is the model behind the login form.
 */
class LoginForm extends Model
{
    public $username;
    public $password;
    public $email;
    public $rememberMe = true;

    private $_user = false;


    /**
     * @return array the validation rules.
     */
    public function rules()
    {
        return [
            // username and password are both required
            [['username', 'password'], 'required'],
            // rememberMe must be a boolean value
            ['rememberMe', 'boolean'],
            // password is validated by validatePassword()
            ['password', 'validatePassword'],
        ];
    }

    /**
     * Validates the password.
     * This method serves as the inline validation for password.
     *
     * @param string $attribute the attribute currently being validated
     * @param array $params the additional name-value pairs given in the rule
     */
    public function validatePassword($attribute, $params)
    {
        if (!$this->hasErrors()) {
            $user = $this->getUser();

            if (!$user || !$user->validatePassword($this->password)) {
                $this->addError($attribute, 'Incorrect username or password.');
            }
        }
    }

    /**
     * Logs in a user using the provided username and password.
     * @return boolean whether the user is logged in successfully
     */
    public function login()
    {
        if ($this->validate()) {
         //  $ss = $this->getUser();
        //   die("ID: ".$ss->ID. "username: ".$ss->username." password: ".$ss->password." email: ".$ss->email);

            return Yii::$app->user->login($this->getUser(), $this->rememberMe ? 3600 * 24 * 30 : 0);
        } else {
            return false;
        }
    }
    public function getUser()
    {
        if ($this->_user === false) {
            $this->_user = Users::findByUsername($this->username);
        }
        return $this->_user;
    }
}