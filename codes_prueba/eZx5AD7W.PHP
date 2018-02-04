<!DOCTYPE html>
<?php
//Заводим текстовую строку Lorem100 TAB
$text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit. Cumque facere totam ad neque, suscipit vitae at vero quidem atque aliquam nostrum! Quae deserunt ipsa, quis accusamus maiores provident molestiae? Fugit adipisci est, facilis asperiores voluptas, magni quae odit iusto nesciunt ipsam similique officia dolores repudiandae praesentium cumque pariatur, nobis rem voluptatum delectus! Ducimus neque distinctio quae nisi error ullam eveniet, eos doloribus vel hic unde tempore soluta inventore quam asperiores repudiandae aliquid ipsa, ipsum cumque minima odio illo culpa nam quia. Dolorem nulla minus delectus unde recusandae, magni animi voluptate nisi illo. Laboriosam debitis, quis architecto maxime autem deserunt fugiat.";


// Если нажали на кнопку то textarea становится нашей строкой 
if($_SERVER["REQUEST_METHOD"] == POST){
    $text = $_POST['textarea'];
}
//Создаем подмаску любого символа буквы

//   \w - любая цифра, буква
//   + - одно или более вхождений.

$pattern = '~(\w+)~';

// ищем все слова входящие в данную строку
// preg_match_all — Выполняет глобальный поиск шаблона в строке
// $out[0] содержит массив полных вхождений шаблона, 
// $out[1] содержит массив подстрок

preg_match_all($pattern, $text, $out);

// Создаем массив $a в котором ключ это наше слово а значение - частота слов
$a =[];
foreach($out[0] as $value){
    if(!$a[$value])
        $a[$value]=1;
    else 
        $a[$value]++;
    }
    
// А теперь создадим массив $b который будет состоять из массивов 
// с элементом самим словом и частотой его повторения 
$i=0;
foreach($a as $key => $value){
    $b[$i]=array('word'=>strtolower($key),'frequency'=>$value);
    $i++;
}
// Итак, чтобы было интересно попробуем одним махом отсортировать по частоте
// и по алфавиту

//создаем две переменные со значение ключей подмассивов
$type_abc = 'word';
$type_123 = 'frequency';


// создаем mysort используя сразу две переменные
$mysort = function($b1,$b2) use ($type_abc,$type_123){
//если переменные по частоте отличаются приоритет у той, которая больше 
    if($b1[$type_123]>$b2[$type_123])
        return -1;
    elseif ($b1[$type_123]<$b2[$type_123])
        return 1;
    else{
//если переменные по частоте равны приоритет у той, чье слово раньше в словаре

        if($b1[$type_abc]>$b2[$type_abc])
            return 1;
        else 
            return -1;
    }
    
};


// сортируем массив. (Честно говоря впечатлен работой этой функции) 
usort($b,$mysort);
?>
 <head>
<meta charset="utf-8">
<!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css" integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">

</head>

<body>
<div style="width:50%; margin: 0 auto;">

<h1>Task 5: Sorting an array an anonymous function</h1>
<!--выводим форму-->
<form method="POST" role = "form">
   
   <div class = "form-group">
       <!--заполняем форму вначале lorem далее тем что отправили-->
        <textarea class = "form-control" name ="textarea" rows = "3" ><?=$text?></textarea>
   </div>
        <input class="btn btn-outline-success my-2 my-sm-0" type="submit" value="Submit"/>
   
</form>

<!--выводим таблицу с частотой слов и по алфавиту-->
<table class="table table-hover"> 
  <thead> 
    <tr> 
      <th>#</th>
      <th>Word</th>
      <th>Frequency</th>
    </tr>
  </thead> 
  <tbody>
      <?php for($i=0; $i<count($b); $i++){ ?>
    <tr> 
      <th scope="row"><?=$i+1?></th>
      <td><?=$b[$i]['word']?></td> 
      <td><?=$b[$i]['frequency']?></td> 
    </tr> 
       <?php } ?>
  </tbody>
</table>
</div>

</body>