#pragma strict
var Velocidade : float;
var VelocidadeY: float;
var Personagem : Rigidbody2D;
var Anim : Animator;
var Posicao1 : Transform;
var Posicao2 : Transform;
var chao : boolean;
function Start () {
 Personagem = GetComponent(Rigidbody2D);
 Anim = GetComponent(Animator);
 Velocidade = 2;
 VelocidadeY = 4;
}

function Update () {
Raycast();
//movimentaçao do personagem
Personagem.velocity.x = Velocidade * Input.GetAxis("Horizontal");

Anim.SetFloat("speed",Mathf.Abs(Input.GetAxis("Horizontal")));

if(Input.GetAxis("Horizontal")!=0)
{
if(Input.GetAxis("Horizontal")> 0)
{
Personagem.transform.localScale.x = 3;

}
else
{
Personagem.transform.localScale.x = -3;
}
}
if(chao == true)
{
Anim.SetBool("jumping", false);
Anim.SetBool("falling", false);
//pulo do personagem
if(Input.GetButtonDown("Jump"))
{
Personagem.velocity.y = VelocidadeY;
}
}
else
{
if(Input.GetButtonUp("Jump")&& Personagem.velocity.y>0)
{
Personagem.velocity.y = Personagem.velocity.y/2;
}
if(Personagem.velocity.y > 0)
{
Anim.SetBool("jumping", true);
Anim.SetBool("falling", false);
}
if(Personagem.velocity.y < 0)
{
Anim.SetBool("jumping", false);
Anim.SetBool("falling", true);

}

if(Personagem.velocity.y == 0)
{
Anim.SetBool("jumping", false);
Anim.SetBool("falling", false);

}
}
}

function Raycast()
{

Debug.DrawLine(Posicao1.position, Posicao2.position, Color.blue);
if(Physics2D.Linecast(Posicao1.position,Posicao2.position))
{
 chao = true;
 
}
else
{

chao = false;
}
}