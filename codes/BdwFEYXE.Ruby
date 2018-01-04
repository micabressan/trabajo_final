#5 4 9 6
#10 26 6 4
#-10 26 6 4
#-8 -4 3 5
#2.   Tekstiniame faile duotos stačiakampių plokštumoje apatinio kairiojo kampo koordinatės (x,y), aukštis ir plotis. Rezultatus įrašyti į tekstinį failą. Stačiakampių kraštinės lygiagrečios su koordinačių ašimis. Sudarykite metodus stačiakampio plotui ir perimetrui apskaičiuoti. Rezultatus įrašyti į tekstinį failą. Rasti:
#a)  Stačiakampių plotus.
#b)  Kurio iš stačiakampių III ketvirtyje perimetras yra didžiausias? 
#c)  Kiek stačiakampių yra II ketvirtyje?

def perimetras (a,b)
  pr=a*2+b*2
end

def plotas (a,b)
  if(a<0)
    a=a*(-1)
  end
  if(b<0)
    b=b*(-1)
  end
  p=a*b
end

fp=File.open("input.txt", "r")
rz=File.open("output.txt", "w+")
x,y=[]
max=0
j=0
l=0
t=0
stac=0

fp.each do |item|
c=item.split(" ")
for i in 0..c.length do
  x=c[0].to_i
  y=c[1].to_i
  a=c[2].to_i
  b=c[3].to_i
end
d=plotas(a,b)
per=perimetras(a,b)
j+=1
if(x<0) and (y<0) then
  if per>max then
    max=per
    t=j
  end
end
if (x<0) and (y>0) then
  stac=stac+1
end

puts "#{j} - ojo staciakampio plotas #{d}"
puts "\n"
end

puts "#{t} -ojo staciakampio III ketv perimetras didz. #{max} \n"
puts "II ketvirtyje yra staciakambiu #{stac}"