#Turime rajono ūkininkų auginamų gyvių sąrašą: ūkininko pavardė, gyvio pavadinimas, kiekis, amžius.
#Rasti:
#1)  Paieška pagal duotą gyvio pavadinimą.
#2)  Daugiausia gyvių auginantį ūkininką.
#3)  Paieška pagal gyvių amžiaus apatinę ribą.

$ukis = []    #masyvo sukurimas
# A simple ukis class
class Ukis
  attr_reader :pavarde, :gpavad, :kiekis, :age

  def initialize(pavarde, gpavad, kiekis, age)
    @pavarde = pavarde
    @gpavad = gpavad
    @kiekis = kiekis
    @age = age
  end
  # I string kintamaji
  def to_s
    "#{pavarde}, #{gpavad}, #{kiekis}, #{age}"
  end
end
class Ukiai
  include Enumerable
  def initialize
    @ukiai = []
  end
  def <<(ukis)    #pridejimas
    @ukiai << ukis
  end
  def each
    @ukiai.each { |e| yield(e) }      #nustatymas ka reiskia each
  end
end
class Programa    #pagrindine programa
 
def skaitymas   #nuskaitymas
@@data = Ukiai.new

fp=File.open("input_sar.txt", "r")    #duomenu traukimas is failo

fp.readlines.each do |line|   #nuskaitymas
  c=line.split(",")   #kablelis skiria kintamuosius
  c[2]=c[2].to_i    #3 pozicija skaicius
  c[3]=c[3].to_i    #4 pozicija skaicius
  @@data<<Ukis.new(c[0],c[1],c[2],c[3])   #sukuria nauja
    end

 fp.close   #failo uzdarymas

puts "Sarasas:"
puts "*********************************************************"
@@data.each_with_index{ |e, i| puts "#{i+1}. #{e.to_s}" }     #
puts "*********************************************************"
end

def jaunimas
puts "Iveskite amziaus apatine riba"
m=gets.to_i     #ivedimas
puts "*********************************************************"
puts "Gyvulių nuo duoto amziaus ribos sarasas:"
puts "*********************************************************"
jauni = @@data.select{ |e| e.age >m }   #pasirenka gyvulius kurie vyresni nei duotas amzius
jauni.each{ |p| puts p.to_s }   #isvedimas
puts "*********************************************************" 
end

def paieska
puts "Iveskite gyvio pavadinima"
pavadin=gets.chomp    #ivedimas
puts "#{pavadin} sarasas:"
puts "*********************************************************"
gyvuliai = @@data.select{ |e| e.gpavad == pavadin } #pasirenka gyvulius pagal pavadinima
gyvuliai.each{ |p| puts p.to_s }  #isvedimas
end

def daugiausia
 puts "Daugiausia gyviu auginantis ukininkas:"
puts "*********************************************************" 
max=0
gyvuliai = @@data.select{ |e| e.gpavad}     #nuskaitymas pagal gyvulio pavadinima
gyvuliai.each{ |p| if p.kiekis > max then max=p.kiekis end}   #jeigu gyvuliu kiekis didesnis nei max, tada max yra kiekis
gyvuliai.each{ |p| if p.kiekis==max then puts "#{p.pavarde} ---kiekis-#{max} " end}     #jeigu gyvuliu kiekis lygus max, tada isvedimas
puts "*********************************************************"
end

end

puts "\n"
puts "*********************************************************"
puts "\n"

while true

print <<TEXT
1 - Skaitymas is failo
2 - Paieska pagal duota gyvio pavadinima
3 - Paieska pagal gyviu amziaus apatine riba
4 - Daugiausia gyviu auginantis ukininkas
0 - Pabaiga 
TEXT
s=Programa.new

puts "\n"
puts "*********************************************************"
puts "\n"
    val = gets.to_i
    
         
    case val
    when 1
      s.skaitymas
    when 2
      s.paieska
     when 3
      s.jaunimas
     when 4
      s.daugiausia
    when 0
      puts "Pabaiga"
      exit
    end
    end