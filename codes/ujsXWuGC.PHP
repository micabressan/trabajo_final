<?php 
session_start();
ob_start();
    include ("header.php");
//    ini_set('display_errors', 1);
//    ini_set('display_startup_errors', 1);
//    error_reporting(E_ALL);
?>

<?php

include_once("config.php");
$post = filter_input_array(INPUT_POST, FILTER_DEFAULT);
$post['senha'] = MD5($post['senha']);


//$usuario = filter_input(INPUT_POST, usuario);
//$senha = MD5(filter_input(INPUT_POST, senha));
//$nome = filter_input(INPUT_POST, nome);
//$email = filter_input(INPUT_POST,email);
//$sobrenome = filter_input(INPUT_POST, sobrenome);
//$data_nascimento = filter_input(INPUT_POST, data_nascimento);
//$rg = filter_input(INPUT_POST, rg);
//$cpf = filter_input(INPUT_POST, cpf);
//$telefone = filter_input(INPUT_POST, telefone);
//$rua = filter_input(INPUT_POST, rua);
//$num = filter_input(INPUT_POST, num);
//$complemento = filter_input(INPUT_POST, complemento);
//$bairro = filter_input(INPUT_POST, bairro);
//$cep = filter_input(INPUT_POST, cep);
//$cidade = filter_input(INPUT_POST, cidade);
//$estado = filter_input(INPUT_POST, estado);

$post['tipo_cadastro'] = 1;
//$into = implode(', ', array_keys($post));
$val = implode(', ', array_values($post));
        
$query_select = "SELECT usuario, email FROM usuarios WHERE usuario = '{$post['usuario']}' OR email = '{$post['email']}'";
$select = mysqli_query($link, $query_select);
$array = mysqli_fetch_array($select);
$logarray = $array['usuario'];
$logarray_email = $array['email'];

$_SESSION["post"] = filter_input_array(INPUT_POST, FILTER_DEFAULT);

if ($post['usuario'] == "" || $post['usuario'] == null || $post['email'] == "" || $post['email'] == null) {
    $_SESSION['msg'] = "Necessário preencher todos os campos";
} else {
    if ($logarray == $post['usuario'] || $logarray_email == $post['email']) {
        echo"<script language='javascript' type='text/javascript'>alert('Esse usuario ou email cadastrados já existem');</script>";
    } else {


       // $query = "INSERT INTO usuarios($into) VALUES($val)";
        
       $query = "INSERT INTO usuarios (nome, sobrenome, email, usuario, senha, data_nascimento, rg, cpf, telefone, rua, num, complemento, bairro, cep, cidade, estado, tipo_cadastro) VALUES ($val)";
        $insert = mysqli_query($link, $query);

        if ($insert) {
            echo"<script language='javascript' type='text/javascript'>alert('Usuário cadastrado com sucesso!');window.location.href='login.php'</script>";
        } else {
            echo"<script language='javascript' type='text/javascript'>alert('Não foi possível cadastrar esse usuário');window.location.href='cadastro.html'</script>";
        }
    }
}
?>
<body class="bg-dark">

<div class="container">
<div class="card card-register mx-auto mt-5">
  <div class="card-header">Cadastro de Revedendor</div>
  <div class="card-body">
        <?php 
        if(isset($_SESSION['msg'])){
            echo '<div class="alert alert-danger" role="alert">'.
                    $_SESSION['msg'] .
                    '<button type="button" class="close" data-dismiss="alert" aria-label="Close">
    <span aria-hidden="true">&times;</span>
  </button>
                </div>';
            unset($_SESSION['msg']);
        }
        ?>
    <form method="POST" action="">
      <div class="form-group">
        <div class="form-row">
          <div class="col-md-6">
            <label for="exampleInputName">Nome</label>
            <input class="form-control" id="nome" type="text" name="nome" placeholder="Enter first name">
          </div>
          <div class="col-md-6">
            <label for="exampleInputLastName">Sobrenome</label>
            <input class="form-control" id="sobrenome" type="text" name="sobrenome" placeholder="Enter last name">
          </div>
        </div>
      </div>
      <div class="form-group">
        <div class="form-row">
            <div class="col-md-6">
                <label for="exampleInputEmail1">Email</label>
                <input class="form-control" id="email" type="email" name="email" placeholder="Enter email">
            </div>
            <div class="col-md-6">
                <label for="exampleInputEmail1">Usuário</label>
                <input class="form-control" id="usuario" type="text" name="usuario" placeholder="Insira o nome de Usuário">
            </div>
        </div>
      </div>
      <div class="form-group">
        <div class="form-row">
          <div class="col-md-6">
            <label for="exampleInputPassword1">Senha</label>
            <input class="form-control" id="senha" type="password" placeholder="Password" name="senha">
          </div>
          <div class="col-md-6">
            <label for="exampleConfirmPassword">Data Nascimento</label>
            <input class="form-control" id="exampleConfirmPassword" type="date" name="data_nascimento" placeholder="Data de Nascimento">
          </div>
        </div>
      </div>
        <div class="form-group">
            <div class="form-row">
                <div class="col-md-6">
                    <label for="exampleInputPassword1">RG</label>
                    <input class="form-control" id="rg" type="text" placeholder="RG" name="rg">
                </div>
                <div class="col-md-6">
                    <label for="exampleInputPassword1">CPF</label>
                    <input class="form-control" id="cpf" type="text" placeholder="CPF" name="cpf">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="form-row">
                <div class="col-md-6">
                    <label for="exampleInputPassword1">Telefone (Preferência Whatsapp)</label>
                    <input class="form-control" id="telefone" type="text" placeholder="Telefone" name="telefone">
                </div>
                <div class="col-md-6">
                    <label for="exampleInputPassword1">Cidade ou Região que deseja atuar</label>
                    <input class="form-control" id="cidade_regiao" type="text" placeholder="Cidade ou Região que deseja atuar" name="cidade_regiao">                    
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="form-row">
                <div class="col-md-6">
                    <label for="exampleInputPassword1">Rua</label>
                    <input class="form-control" id="rua" type="text" placeholder="Rua" name="rua">
                </div>
                <div class="col-md-3">
                    <label for="num">Número</label>
                    <input class="form-control" id="num" type="number" placeholder="Número" name="num">
                </div>
                <div class="col-md-3">
                    <label for="complemento">Complemento</label>
                    <input class="form-control" id="complemento" type="text" placeholder="Complemento" name="complemento">
                </div>
                <div class="col-md-6">
                    <label for="bairro">Bairro</label>
                    <input class="form-control" id="bairro" type="text" placeholder="Bairro" name="bairro">
                </div>
                <div class="col-md-6">
                    <label for="cep">CEP</label>
                    <input class="form-control" id="cep" type="text" placeholder="CEP" name="cep">
                </div>
                <div class="col-md-6">
                    <label for="cidade">Cidade</label>
                    <input class="form-control" id="cidade" type="text" placeholder="Cidade" name="cidade">
                </div>
                <div class="col-md-6">
                    <label for="Estado">Estado</label>
                    <input class="form-control" id="estado" type="text" placeholder="Estado" name="estado">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="form-row">
                <div class="col-md-12">
                    <label for="exampleInputPassword1">Como você ficou sabendo da Profix?</label>
                    <input class="form-control" id="sabendo_oportunidade" type="text" placeholder="Como você ficou sabendo da Profix?" name="sabendo_oportunidade">
                </div>
            </div>
        </div>
        <div class="form-group">
            <div class="form-row">
                <div class="col-md-12">
                <label for="exampleInputPassword1">Observação</label>
                <textarea class="form-control" id="observacao" name="observacao" rows="3"></textarea>                  
                </div>
            </div>
        </div>
        <input type="submit" value="Register" class="btn btn-primary btn-block" />
    </form>
    <div class="text-center">
      <a class="d-block small mt-3" href="login.html">Login Page</a>
      <a class="d-block small" href="forgot-password.html">Forgot Password?</a>
    </div>
  </div>
</div>
    
<?php 
include ("footer.php");
?>