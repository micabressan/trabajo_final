$factory->define('App\Models\User::class', function (Faker\Generator $faker) {

    return [
        'username' => $faker->username,
        'password' => bcrypt("testpassword"),
        'email' => $faker->email,
        'steam_id' => bcrypt(str_random(10))        
    ];
});