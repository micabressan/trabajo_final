Duota n apskritimų plokštumoje koordinatės (x,y) ir spinduliai -R. Rasti IV-io ketvirčio apskritimų ilgius (C=2πR) ir kiek jų yra. Sudaryti metodą apskritimo ilgiui skaičiuoti. 
#4 5 8
#3 -5 6
#-4 -5 8
#-9 8 3
#8 -6 4

def ilgis (r)
  ilg=2*3.14*r
end

fp=File.open("input.txt", "r")
rz=File.open("output.txt", "w+")
x,y=[]
j=0
l=0
stac=0

fp.each do |item|
c=item.split(" ")
for i in 0..c.length do
  x=c[0].to_i
  y=c[1].to_i
  r=c[2].to_i
end
j+=1

if (x>0) and (y<0) then
  stac=stac+1
  ilg=ilgis(r)
  puts "IV-ojo ketvircio #{j}-o apskritimo ilgis #{ilg}"
end

end

puts "IV ketvirtyje yra apskritimu #{stac}"