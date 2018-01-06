# Petit jeu codé par ThinX294 à enregistrer en .rb
# Normalement il n'y a pas trop de bugs


require 'date'

$date_inscription = Date.today
$cibles_atk = Array.new
$pseudo = nil



module Guides

  def self.show_targets
    puts "Cibles :"
    puts "
    "
    cibles_gen("puts_cibles", "ST")
    reponder
  end

  def self.help
    puts "Guide :"
    puts "
    "
    puts "- Tapez !connect pour voir les différentes options d'attaque"
    puts "- Tapez EXIT pour revenir au menu principal"
    reponder
  end
end


def profil
  puts "Pseudo ==> #{$pseudo}"
  puts "première connexion ==> #{$date_inscription}"
  if $cibles_atk.length == 0
    puts "Vous n'avez attaqué personne pour l'instant"
  elsif $cibles_atk.length == 1
    puts "#{$cibles_atk.length} cible attaquée ==> #{$cibles_atk}"
  else
    puts "#{$cibles_atk.length} cibles attaquées ==> #{$cibles_atk}"
  end
  reponder
end

def cibles_gen(key, mtf) # c'est ici que les cibles sont réglées

  # Si vous créez une nouvelle cible, rentrez tous ces paramètres :
  # cible = ["NIVEAU DE SECURITE", "Nom", mot de passe, "date de création", "créateur", nombres de caractères composants le mot de passe, "préciser si le mot de passe est formé d'une chaine de caractère ou de nombres relatifs (ou les deux)", "donnez le signe du mot de passe (+ / -) seulement s'il est de type INTEGER "]
  google_DIH_Services = ["HAUTEMENT SECURISE", "Google DIH Services", 976594623164765, "07/04/2001", "Willy Johnson", 15, "INTEGER", "POSITIVE"]
  azerty_developement = ["FAIBLEMENT SECURISE", "Azerty development, Inc", "azerty", "?", "Lucas Parker", 6, "STRING", "NONE"]
  dkbdh = ["MOYENNEMENT SECURISE", "Central Dkbdh", 1506179549, "28/03/2013", "Patrik Söht", 10, "INTEGER", "POSITIVE"]
  adobe_Cloud_Tr = ["HAUTEMENT SECURISE", "Adobe Cloud Tr, Inc", 72468934704011, "14/02/2006", "Charles Geschke", 14, "INTEGER", "POSITIVE"]
  dG_Pop = ["FAIBLEMENT SECURISE", "DG POP", 22062015, "22/06/2015", "Gary Brown", 8, "INTEGER", "POSITIVE"]
  windows_test_servers = ["EXTREMEMENT SECURISE", "Windows TestServer", 647831495897465331, "05/08/1979", "Liam Perez", 18, "INTEGER", "POSITIVE"]
  nT_Studio = ["FAIBLEMENT SECURISE", "NT Studio", -35468985, "12/10/2016", "Ethan Harris", 8, "INTEGER", "NEGATIVE"]
  lab_III_US = ["EXTREMEMENT SECURISE", "Lab. III US", -7465132567495375048, "17/05/2010", "Harry Adam", "?", "?", "NEGATIVE"]
  aTOM_Area = ["?", "ATOM Area", 95467831646573412088, "01/11/1999", "Logan Rodriguez", "?", "?", "?"]
  # puis mettre le nom de votre nouvelle cible à la fin du tableau ci-dessous :
  cibles_stock_arr = [google_DIH_Services, azerty_developement, dkbdh, adobe_Cloud_Tr, dG_Pop, windows_test_servers, nT_Studio, lab_III_US, aTOM_Area]
# Cela terminé, le programme s'occupera du reste ;)
  if key == "puts_cibles" && mtf == "ST"
    cibles_stock_arr.each do |cible|
      puts "- " + cible[1]
    end
  elsif mtf == "btf"
    cibles_stock_arr.each do |cible|
      if key == cible[1]
        pass = ""
        pass = cible[2]
        pass = pass.to_i
        puts "
        "
        Attaques::Attaque_bruteforce::presentation(pass, key)
      end
    end
  elsif mtf == "AF"
      cibles_stock_arr.each do |cible|
        if key == cible[1]
          pass = ""
          pass = cible[2]
          pass = pass.to_s
          puts "
          "
          puts "Connexion à : #{key}..."
          blocker_chr

          Attaques::Attaque_finale::register_WWS(key, pass)
        end
    end
  elsif mtf == "OI"
    cibles_stock_arr.each do |cible|
      if key == cible[1]
        pass = ""
        pass = cible[2]
        pass = pass.to_i
        difficult = cible[0]
        date_creation = cible[3]
        createur = cible[4]
        pass_counter = cible[5]
        pass_type = cible[6]
        relative_number = cible[7]
        puts "
        "
        puts "Obtentions d'informations sur : #{key}..."
        blocker_chr
        Attaques::Obtenir_infos::pompr(key, pass, difficult, date_creation, createur, pass_counter, pass_type, relative_number)
      end
  end
    end
    unless mtf == "ST"
    errorTarget(key)
    end
  end

def connect
  puts "Options :"
  puts "
  "
  puts "- Recherche d'informations (!infos)"
  puts "- Bruteforcing de mots de passe de type INTEGER (!bruteforce)"
  puts "- [CODE REQUIS] Attaque (!attaque)"
  puts "
  "
  print "> "
  reponse = gets.chomp.to_s.downcase
  if reponse == "!attaque"
    Attaques::Attaque_finale::corps
  elsif reponse == "!bruteforce"
    Attaques::Attaque_bruteforce::corps
  elsif reponse == "!infos"
    Attaques::Obtenir_infos::corps
  elsif reponse == "exit"
    exit
  else
    puts "
    "
    error(reponse, 2)
  end
end

module Attaques

  module Attaque_finale

    def self.corps
      puts "
      "
      puts "Tapez le nom de la cible à attaquer : (respecter les majuscules, les espaces et autres signes)"
      print "> "
      reponse = gets.chomp.to_s
      if reponse == "exit"
        exit
      else
        cibles_gen(reponse, "AF")
      end
    end

      def self.register_WWS(cible, pass)
        puts "
        "
        puts "# #{cible} > Connexion réussie !"
        puts "
        "
        puts "# #{cible} > ACCESS DENIED ! ENTER THE PASSWORD :"
        puts "
        "
        print "PASSWORD ===> "
        reponse = gets.chomp.to_s.downcase
        if reponse == pass
          puts "
          "
          puts "Bravo ! Vous avez réussi à pénétrer dans le système de #{cible} !"
          puts "
          "
          $cibles_atk = $cibles_atk << cible
          puts "Votre profil a été modifié ! Pour le consulter, tapez \"PROFIL\""
          reponder
        elsif reponse == "exit"
          exit
        else
          puts "
          "
          puts "# #{cible} > INCORRECT PASSWORD ! EJECTING..."
          reponder
        end
      end
  end

  module Attaque_bruteforce
    def self.corps
      puts "
      "
      puts "Tapez le nom de la cible à bruteforcer : (respecter les majuscules, les espaces et autres signes)"
      print "> "
      reponse = gets.chomp.to_s
      if reponse == "exit"
        exit
      else
      cibles_gen(reponse, "btf")
    end
    end

    def self.rver(passBF, pass)
        puts "
        "
        if passBF == pass
          puts "PASSWORD FOUND ==> #{passBF}"
          reponder
        else
          puts "Le mot de passe n'a pas été trouvé entre ces nombres ! Voulez vous continuer ? (oui/non)"
          puts "
          "
          print "==> "
          reponse = gets.chomp.to_s.downcase
          if reponse == "oui"
            infos(pass)
          elsif reponse == "non"
            puts "
            "
            puts "Arrêt du bruteforcing..."
          elsif reponse == "exit"
            exit
          else
            error(reponse, 2)
          end
        end
      end

      def self.methode_opt_puts(passBF, limit, pass)
        puts "
        "
        puts "Voulez vous afficher les mots de passe testé ou non ? (oui/non) (si vous tapez oui, le programme sera moins rapide)"
        print "==> "
        opt_puts = gets.chomp.to_s.downcase
        if opt_puts == "oui"
          tester(passBF, limit, pass, opt_puts)
        elsif opt_puts == "non"
          tester(passBF, limit, pass, opt_puts)
        elsif reponse == "exit"
          exit
        else
          error(opt_puts, 2)
        end
      end

      def self.tester(passBF, limit, pass, opt_puts)
        puts "
        "
        puts "Attaque lancée !"
        puts "
        "
        if opt_puts == "oui"
        for num in passBF..limit
          next if passBF == pass
          puts "TRY TO FIND THE PASSWORD WITH #{passBF}"
          passBF = passBF + 1
        end
      elsif opt_puts == "non"
        for num in passBF..limit
          next if passBF == pass
          passBF = passBF + 1
        end
      else
        error(opt_puts, 2)
      end
      rver(passBF, pass)
    end

      def self.testValeursMinMax(passBF, limit, pass)
        if passBF >= limit
          puts "Le nombre de départ ne dois pas être égal ou supérieur au nombre de limitation ! Voulez-vous corriger cela ? (oui/non)"
          print "==> "
          reponse = gets.chomp.to_s.downcase
          if reponse == "oui"
            infos(pass)
          elsif reponse == "non"
            reponder
          elsif reponse == "exit"
            exit
          else
            error(reponse, 2)
          end
        else
          puts "Dernier nombre ==> #{limit}"
          methode_opt_puts(passBF, limit, pass)
        end
      end

      def self.infos(pass)
        puts "
        "
        puts "Entrez le nombre avec lequel l'attaque bruteforce débutera :"
        print "==> "
        passBF = gets.chomp.to_i
        puts "
        "
        puts "Premier nombre ==> #{passBF}"
        puts "Entrez maintenant le nombre de limitation"
        print "==> "
        limit = gets.chomp.to_i
        puts "
        "
        testValeursMinMax(passBF, limit, pass)
      end

      def self.presentation(pass, cible)
        puts "Vous avez décidé de bruteforcer le mot de passe de : #{cible}"
        puts "
        "
        puts "Pour réduire le temps d'attente, veuillez entrer les nombres entre lesquels chercher le mot de passe"
        infos(pass)
      end
    end

    module Obtenir_infos

      def self.corps
        puts "
        "
        puts "Entrez le nom de la cible sur laquelle vous voulez obtenir des informations : (respecter les majuscules, les espaces et autres signes)"
        print "> "
        reponse = gets.chomp.to_s
        if reponse == "exit"
          exit
        else
          cibles_gen(reponse, "OI")
        end
      end

      def self.pompr(cible, pass, difficult, date_creation, auteur, pass_counter, pass_type, relative_number)
        puts "
        "
        puts "Infos trouvées :"
        puts "
        "
        puts "NAME ==> #{cible}"
        puts "CREATION DATE ==> #{date_creation}"
        puts "CREATOR ==> #{auteur}"
        puts "SECURITY LEVEL ==> #{difficult}"
        puts "PASSWORD TYPE ==> #{pass_type}"
        puts "PASSWORD CHARACTERS NUMBERS ==> #{pass_counter}"
        puts "INTEGER SIGN (+ / -) ==> #{relative_number}"
        reponder
    end

  end

end

def blocker_chr
  number = 0
  while number != 200000000
    number += 1
  end
end

  def autobanning(str)
    str.tr(' ', '')
  end

def errorTarget(reponse)
  puts "
  "
  puts "#{reponse} ==> ERROR::NAME : UNKNOW TARGET"
  connect
end

def errorPseudo
  if $pseudo == ""
    puts "Erreur ! Le pseudo ne peut pas être vide !"
    accueil
  end
end

def error(str, rver) #lieu 1 = reponder, lieu 2 = connect
  puts "\"#{str}\" > ERROR::TYPE : UNKNOW COMMAND"
  if rver == 1
    reponder
  elsif rver == 2
    puts "
    "
    connect
  end
end

def reponder
  puts "
  "
  print "#{$pseudo} ==> "
  reponse = gets.chomp.to_s.downcase
  reponse = autobanning(reponse)
  puts "
  "
  if reponse == "show_targets"
    Guides::show_targets
  elsif reponse == "help"
    Guides.help
  elsif reponse == "profil"
    profil
  elsif reponse == "!connect"
    connect
  elsif reponse == "exit"
    puts "Vous êtes déjà au menu principal ! "
    reponder
  else
    error(reponse, 1)
  end
end

def exit
  puts "
  "
  puts "INTERRUPTION..."
  reponder
end

def accueil
puts "
"
puts "Entrez votre pseudo : "
print "==> "
$pseudo = gets.chomp.to_s
errorPseudo
puts "
"
puts "Bonjour #{$pseudo} ! Bienvenue sur votre console d'attaque !"
puts "
"
puts "SHOW_TARGETS ==> voir les cibles"
puts "HELP         ==> demander de l'aide"
puts "PROFIL       ==> informations sur votre profil"
reponder

end
accueil