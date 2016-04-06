$post_data = [
    'email' => 'joe@gmail.con',
];
$model = new DynamicModel($post_data);
$model->addRule('email', 'email')->validate();
if ($model->hasErrors()){
   
}