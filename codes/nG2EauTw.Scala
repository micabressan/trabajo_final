import scala.collection.mutable.ArrayBuffer
import io.StdIn
import scala.annotation.switch

class Wallet(var numeroCompte:Int, var PIN:Int, var DécouvertAutorisé:Double, var ArgentDisponible:Double){
    /*private var PIN:Int = PIN
    private var numeroCompte:Int = numeroCompte
    private var DécouvertAutorisé:Double = DécouvertAutorisé
    private var ArgentDisponible:Double = ArgentDisponible //pas d'argent quand créer le wallet*/
    private val FraisDebit:Double = 5/100
    private val FraisCredit:Double = 5/100
    
    def verifiePIN(EssaiPin:Int): Boolean={                                              //Vérifie si PIN juste
      if (EssaiPin== PIN){ 
        return true
      }else{
        return false 
      }
    }
    
    def changeCode(EssaiPin:Int, nouveauPin:Int): Boolean ={                             //Si PIN juste, change le code PIN
      if (verifiePIN(EssaiPin)){  // si c'est le bon PIN
        PIN= nouveauPin
        return true             //true si la modification peux être réalisée
      }else{
        return false
      } 
    }
    
    def operationDebit(EssaiPin:Int, aDebiter:Double): Boolean={                             //Si PIN juste, dit si possible de débiter(retirer $$)
      if (verifiePIN(EssaiPin)){   // si c le bon pin
        var TotalaDebiter:Double = aDebiter + ((aDebiter/100) * 5)  //nouvelle valeur à retirer en rajoutant cout d'operation
        if (TotalaDebiter <= (ArgentDisponible+DécouvertAutorisé)){  //Si pas assez d'argent pr débiter
          ArgentDisponible -= TotalaDebiter
          return true
        }else{
          return false //pas assez d'argent pour retirer somme voulu
        }
      }
      else{
        return false //code PIN faux
      }
    }
    
    def operationCredit(EssaiPin:Int, aCrediter:Double): Boolean = {                     //Si PIN juste, dit si possible de créditer(ajouter $$)
      if (verifiePIN(EssaiPin)){
        var TotalaCrediter:Double = aCrediter - ((aCrediter/100) * 5)
        ArgentDisponible += TotalaCrediter
        return true 
      }else{
        return false //code PIN faux
      }
    }
  }

object ProgrammeBanque {

  

  def accederCompte(banque : ArrayBuffer[Wallet])={
    
    
    println("Quel est le numéro de compte que vous souhaitez accéder ? >")
    var numéro = StdIn.readInt()
    
    if (banque.contains(numéro)){
      var choix= StdIn.readLine("Que souhaitez vous faire ? (changerPin, débiter ou créditer)")

      if (choix== "changerPin"|| choix == 1){                                                                        //=> Changer PIN

        println("Veuillez insérer votre code PIN >")
        var PinInséré = StdIn.readInt()
        if (banque(numéro).verifiePIN(PinInséré)){
          println("Veuillez inserer votre nouveau code PIN >")
          var NewPin = StdIn.readInt()
          banque(numéro).changeCode(PinInséré,NewPin)
          println("Votre code PIN est maintenant "+banque(numéro).PIN+".")
        }
        else{
          println("Code PIN erroné.")
        }
      }

      if (choix== "débiter" ||choix == 2){                                                                         //Ou Débiter

        println("Insérer le code PIN >")
        var PinInséré= StdIn.readInt()
        if (banque(numéro).verifiePIN(PinInséré)){
          println("Combien souhaitez vous débiter ? >")
          var debiter= StdIn.readDouble()
          if (banque(numéro).operationDebit(PinInséré,debiter)){
            println("Opération effectuée.")
          }
          else{
            println ("Il n'y a pas assez d'argent dans votre compte.")
          }
        }
        else{
          println ("Code PIN erroné.")
        }
      }

      if (choix == "créditer" ||choix == 3){                                                                       // Ou Créditer

        println("Insérer le code PIN >")
        var PinInséré= StdIn.readInt()
        if (banque(numéro).verifiePIN(PinInséré)){
          println("Combien souhaitez vous créditer ? >")
          var credit= StdIn.readDouble()
          if (banque(numéro).operationCredit(PinInséré,credit)){
            println("Operation effectuee.")
          }
          else{
            println ("Erreur.")
          }
        }
        else{
          println ("Code PIN erroné.")
        }
      }
    }
    else println("Ce numéro de compte n'existe pas")
  }
    
    
    
    
  def creerCompte(banque:ArrayBuffer[Wallet])={
    
    println("Entrez le code PIN de votre choix >")
    var pin = StdIn.readInt()
    println("Combien souhaitez vous mettre dans le nouveau porte monnaie ? >")
    var montant = StdIn.readInt()
    var tmp_porte_monnaie : Wallet = new Wallet(banque.size+1, pin, 70, montant )
    println("Code PIN: "+tmp_porte_monnaie.PIN)
    println("Montant disponible: "+tmp_porte_monnaie.ArgentDisponible)
    banque += tmp_porte_monnaie
    }
  
  
  def main(args: Array[String]):Unit ={

    var banque = new ArrayBuffer[Wallet]()
    
    var port_monnaie1 : Wallet = new Wallet(1, 1234, 70, 970)  //on cree un porte monnaie  et on l'initialise numeroCompte = 1, PIN = 1234, adecouvert=70, adebiter=970
    banque+=port_monnaie1
    
    var fini:Boolean = false
    while(true && !fini){
      println("Que voulez-vous faire : écrivez 1 pour accéder à un compte, 2 pour créer un compte, 3 pour quitter :")
      val menu:Int = StdIn.readInt()
      val x = (menu: @switch) match {
        case 1  => accederCompte(banque)
        case 2  => creerCompte(banque)
        case 3  => fini = true
        case _ => println("Mauvais choix, recommencez...")
      }
    }
    println("fermeture du programme")
  }
}