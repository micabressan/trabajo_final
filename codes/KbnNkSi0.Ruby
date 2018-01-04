#2.  Tekstiniame faile duotos plokštumoje nubrėžtų apskritimų centrų koordinatės (x,y) ir spinduliai R. Sudarykite metodus apskritimo ilgiui ir perimetrui apskaičiuoti. Rezultatus įrašyti į tekstinį failą. Rasti:
#a)  Apskritimų perimetrus.
#b)  Kurio apskritimo I ketvirtyje ilgis didžiausias?
#c)  Kiek apskritimų patenka į IV ketvirtį?

#4 5 8
#3 -5 6
#-4 -5 8
#-9 8 3
#8 -6 4

def ilgis (r)
  ilg=r*2
end

def perimetras (r)
  p=2*3.14*r
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
  r=c[2].to_i
end
ilg=ilgis(r)
per=perimetras(r)
j+=1
if(x>0) and (y>0) then
  if ilg>max then
    max=per
    t=j
  end
end
if (x>0) and (y<0) then
  stac=stac+1
end

puts "#{j} - ojo staciakampio ilgis #{per}"
puts "\n"
end

puts "#{t} -ojo staciakampio I ketv perimetras didz. #{max} \n"
puts "IV ketvirtyje yra staciakambiu #{stac}"