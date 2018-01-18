import scala.collection.mutable.ArrayBuffer
import io.StdIn
object Brouillon {
  var VraiPin= 1234
  var ArgentDispo= 100.0
  
  class wallet{
    var PIN:Int = 0
    var DécouvertAutorisé:Double = 70
    var ArgentDisponible:Double = 0 //pas d'argent quand créer le wallet
    val FraisDebit:Double = 5/100
    val FraisCredit:Double = 5/100
    
    def	verifiePIN(EssaiPin:Int): Boolean={                                              //Vérifie si PIN juste
      if (EssaiPin== VraiPin){ 
        return true
      }else{
        return false 
      }
    }
    
    def changeCode(EssaiPin:Int, nouveauPin:Int): Boolean ={                             //Si PIN juste, change le code PIN
      if (verifiePIN(EssaiPin)== true){  // si c'est le bon PIN
        VraiPin= nouveauPin
        return true             //true si la modification peux être réalisée
      }else{
        return false
      } 
    }
    
    def operationDebit(EssaiPin:Int, aDebiter:Double): Boolean={                             //Si PIN juste, dit si possible de débiter(retirer $$)
      if (verifiePIN(EssaiPin) == true){   // si c le bon pin
        var TotalaDebiter:Double = aDebiter + ((aDebiter/100) * 5)  //nouvelle valeur à retirer en rajoutant cout d'operation
        if (TotalaDebiter <= ArgentDispo){  //Si pas assez d'argent pr débiter
          ArgentDispo = ArgentDispo - TotalaDebiter
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
      if (verifiePIN(EssaiPin) == true){
        var TotalaCrediter:Double = aCrediter - ((aCrediter/100) * 5)
        ArgentDispo = ArgentDispo + TotalaCrediter
        return true 
      }else{
        return false //code PIN faux
      }
    }
  }
  
  
  var compte = 0   //Numéro de compte
  def main(args: Array[String]):Unit ={
    println("        (Vrai code PIN: 1234) >")
    println("Quel est votre code PIN ? >")
   var pin = StdIn.readInt()
   if(verifiePIN(pin)==false){
     println("Code PIN erroné.")
   }
   else{
      var menu = StdIn.readLine("Que voulez vous faire ? (créer, accéder ou quitter) >")
      if(menu== "créer"){                                                                               //Si Créer compte
        println("Combien souhaitez vous mettre dans le nouveau porte monnaie ? >")
       var montant = StdIn.readInt()
        var PorteMonnaie=ArrayBuffer[Int]()
        PorteMonnaie += pin
        PorteMonnaie += compte
        PorteMonnaie += montant
        println("Code PIN: "+PorteMonnaie(0))
        println("Numero de compte: "+PorteMonnaie(1))
        println("Montant disponible: "+PorteMonnaie(2))
        compte += 1
      }
      
      
      else if(menu== "accéder"){                                                                     //Si Accéder compte
        println("Quel est le numéro de compte que vous souhaitez accéder ? >")
        var numéro = StdIn.readInt()
        //if (PorteMonnaie(1)== numéro){
          var choix= StdIn.readLine("Que souhaitez vous faire ? (changerPin, débiter ou créditer)")
          if (choix== "changerPin"){                                                                        //=> Changer PIN
            println("Veuillez insérer votre code PIN >")
           var PinInséré = StdIn.readInt()
            if (verifiePIN(PinInséré)== true){
              println("Veuillez inserer votre nouveau code PIN >")
             var NewPin = StdIn.readInt()
              changeCode(PinInséré,NewPin)
              println("Votre code PIN est maintenant "+VraiPin+".")
            }else{
              println("Code PIN erroné.")
            }
          }
          if (choix== "débiter"){                                                                         //Ou Débiter 
            println("Insérer le code PIN >")
            var PinInséré= StdIn.readInt()
            if (ve
 rifiePIN(PinInséré)== true){
              println("Combien souhaitez vous débiter ? >")
              var debiter= StdIn.readDouble()
              if (operationDebit(PinInséré,debiter) == true)
                println("Opération effectuée.")
              else{
                println ("Il n' a pas assez d'argent dans votre compte.")
              }
            }
            else{
              println ("Code PIN erroné.")
            }
          }
          if (choix == "créditer"){                                                                       // Ou Créditer
            println("Insérer le code PIN >")
            var PinInséré= StdIn.readInt()
            if (verifiePIN(PinInséré) == true){
              println("Combien souhaitez vous créditer ? >")
              var credit= StdIn.readDouble()
              if (operationCredit(PinInséré,credit) == true)
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