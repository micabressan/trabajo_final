import scala.collection.mutable.ArrayBuffer
import io.StdIn
object Brouillon {
  
  class wallet{
    private var PIN:Int = 0
    private var DécouvertAutorisé:Double = 70
    private var ArgentDisponible:Double = 0 //pas d'argent quand créer le wallet
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
      if (verifiePIN(EssaiPin)== true){  // si c'est le bon PIN
        PIN= nouveauPin
        return true             //true si la modification peux être réalisée
      }else{
        return false
      } 
    }
    
    def operationDebit(EssaiPin:Int, aDebiter:Double): Boolean={                             //Si PIN juste, dit si possible de débiter(retirer $$)
      if (verifiePIN(EssaiPin)){   // si c le bon pin
        var TotalaDebiter:Double = aDebiter + ((aDebiter/100) * 5)  //nouvelle valeur à retirer en rajoutant cout d'operation
        if (TotalaDebiter <= (ArgentDispo+DécouvertAutorisé)){  //Si pas assez d'argent pr débiter
          ArgentDispo -= TotalaDebiter
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
        ArgentDispo += TotalaCrediter
        return true 
      }else{
        return false //code PIN faux
      }
    }
  }
  
  
  def main(args: Array[String]):Unit ={

    var banque = ArrayBuffer[Int]()
    var port_monnaie1 : wallet = new wallet
 
    println("        (Vrai code PIN: 1234) >")
    println("Quel est votre code PIN ? >")
   var pin = StdIn.readInt()
   if(!porte_monnaie1.verifiePIN(pin)){
     println("Code PIN erroné.")
   }
   else{
      var menu = StdIn.readLine("Que voulez vous faire ? (créer, accéder ou quitter) >")
      if(menu== "créer"){                                                                               //Si Créer compte
        println("Combien souhaitez vous mettre dans le nouveau porte monnaie ? >")
       var montant = StdIn.readInt()
  var tmp_porte_monnaie : wallet = new wallet
        tmp_porte_monnaie.PIN = pin
        tmp_porte_monnaie.ArgentDisponible = montant
        println("Code PIN: "+tmp_porte_monnaie.PIN)
        println("Montant disponible: "+tmp_porte_monnaie.ArgentDisponible)
        banque += tmp_porte_monnaie;
      }
      
      
      else if(menu== "accéder"){                                                                     //Si Accéder compte
     var = -1;
  while !banque.contains(numero){
           println("Quel est le numéro de compte que vous souhaitez accéder ? >")
           numéro = StdIn.readInt()
        }
          var choix= StdIn.readLine("Que souhaitez vous faire ? (changerPin, débiter ou créditer)")
          if (choix== "changerPin"|| choix == 1){                                                                        //=> Changer PIN
            println("Veuillez insérer votre code PIN >")
           var PinInséré = StdIn.readInt()
            if (banque(numero).verifiePIN(PinInséré)){
              println("Veuillez inserer votre nouveau code PIN >")
             var NewPin = StdIn.readInt()
              banque(numero).changeCode(PinInséré,NewPin)
              println("Votre code PIN est maintenant "+VraiPin+".")
            }else{
              println("Code PIN erroné.")
            }
          }
          if (choix== "débiter" ||choix == 2){                                                                         //Ou Débiter
 println("Insérer le code PIN >")
            var PinInséré= StdIn.readInt()
            if (banque(numero).verifiePIN(PinInséré)){
              println("Combien souhaitez vous débiter ? >")
              var debiter= StdIn.readDouble()
              if (banque(numero).operationDebit(PinInséré,debiter))
                println("Opération effectuée.")
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
            if (banque(numero).verifiePIN(PinInséré)){
              println("Combien souhaitez vous créditer ? >")
              var credit= StdIn.readDouble()
              if (banque(numero).operationCredit(PinInséré,credit))
                println("Operation effectuee.")
              else{
                println ("Erreur.")
              }
            }
            else{
              println ("Code PIN erroné.")
            }
          }
        //}
      }
      
      
      else if (menu== "quitter"){                                                                       //Si Quitter compte
        println("Retourner au menu principal")
      }
      else{
        println("Erreur. Je n'ai pas compris.")
      }
   }
  }
}