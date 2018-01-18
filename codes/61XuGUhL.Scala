import scala.collection.mutable.ArrayBuffer
import io.StdIn

object eWallet {
  class wallet{
    var PIN:Int = 0
    var DécouvertAutorisé:Double = 70
    var ArgentDisponible:Double = 0 //pas d'argent quand créer le wallet
    val FraisDebit:Double = 5/100
    val FraisCredit:Double = 5/100
    
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
  
  
  def main(args: Array[String]):Unit ={

    var banque = ArrayBuffer[wallet]()
    var porte_monnaie1 : wallet = new wallet
    var menu = StdIn.readLine("Que voulez vous faire ? (créer, accéder ou quitter) >")
    
    while (menu != "quitter" || menu != "3") {
      
      menu match{
        case "créer"|"1" => {                                                                              //Si Créer compte
          println("Combien souhaitez vous mettre dans le nouveau porte monnaie ? >")
          var montant = StdIn.readDouble()
          var tmp_porte_monnaie : wallet = new wallet
          println("tapez votre code pin ");
            tmp_porte_monnaie.PIN = StdIn.readInt();
            var first_credit = tmp_porte_monnaie.operationCredit(tmp_porte_monnaie.PIN, montant)
            println("Code PIN: "+tmp_porte_monnaie.PIN)
            println("Montant disponible: "+tmp_porte_monnaie.ArgentDisponible)
            banque += tmp_porte_monnaie;
          }
        
        case "accéder"|"2" => {                                                                     //Si Accéder compte
          if(banque.isEmpty){
            println("aucun porte-monnaie à consulter")
          }
          else{
            //valeur du porte feuille que l'on veut consulter
            //toutes les occurences pour accéder à un index de tablea sont à numero-1 
            //car le premier index d'un tableau est 0 et non 1
            var numero : Int = -1;
            var valid : Boolean = false
            while (banque.length < numero || numero <= 0){
                   println("Quel est le numéro de compte que vous souhaitez accéder ? >")
                   numero = StdIn.readInt()
                }
              var choix= StdIn.readLine("Que souhaitez vous faire ? (changerPin, débiter ou créditer)")
              if (choix== "changerPin"|| choix == "1"){                                                                        //=> Changer PIN
                println("Veuillez insérer votre code PIN >")
               var PinInséré = StdIn.readInt()
                if (banque(numero-1).verifiePIN(PinInséré)){
 println("Veuillez inserer votre nouveau code PIN >")
                 var NewPin = StdIn.readInt()
                  banque(numero-1).changeCode(PinInséré,NewPin)
                  println("Votre code PIN est maintenant "+banque(numero-1).PIN+".")
                }else{
                  println("Code PIN erroné.")
                }
              }
              if (choix== "débiter" ||choix == "2"){                                                                         //Ou Débiter 
                println("Insérer le code PIN >")
                var PinInséré= StdIn.readInt()
                if (banque(numero-1).verifiePIN(PinInséré)){
                  println("Combien souhaitez vous débiter ? >")
                  var debiter= StdIn.readDouble()
                  if (banque(numero-1).operationDebit(PinInséré,debiter)){
                    println("Opération effectuée.")
                    println("nouveau montant sur le compte " + banque(numero-1).ArgentDisponible)
                  }
                  else{
                    println ("Il n'y a pas assez d'argent dans votre compte.")
                  }
                }
                else{
                  println ("Code PIN erroné.")
                }
              }
              if (choix == "créditer" ||choix == "3"){                                                                       // Ou Créditer
                println("Insérer le code PIN >")
                var PinInséré= StdIn.readInt()
                if (banque(numero-1).verifiePIN(PinInséré)){
                  println("Combien souhaitez vous créditer ? >")
                  var credit= StdIn.readDouble()
                  if (banque(numero-1).operationCredit(PinInséré,credit)){
                    println("Operation effectuee.")
                    println("nouveau montant sur le compte " + banque(numero-1).ArgentDisponible)
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
          //}
        }
        
        
        case "quitter" | "3" => {                                                                       //Si Quitter compte
          println("Retourner au menu principal")
        }
        //choix indéfini
        case _ =>{
          menu = StdIn.readLine("Que voulez vous faire ? (créer, accéder ou quitter) >")
        }
      }
      //quand on finit la boucle on demande si l'utilisateur veut de nouveau faire une opération
      menu = StdIn.readLine("Que voulez vous faire ? (créer, accéder ou quitter) >")
    }
  }
}