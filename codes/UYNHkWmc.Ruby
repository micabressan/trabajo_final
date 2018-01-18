Plokštumoje yra n atkarpų, kurių galų taškų koordinatės - x1, y1, x2, y2. Surasti ketvirtojo ketvirčio atkarpų ilgių sumą. Atkarpos ilgiui  nustatyti sudarykite metodą.
#4 5 8 3 
#3 -5 6 -4
#-4 -5 8 5
#-9 8 3 6
#8 -6 4 1

def ilgis (x,y,xx,yy)
  ilg=((xx-x)**2+(yy-y)**2)**0.5
end

fp=File.open("input.txt", "r")
rz=File.open("output.txt", "w+")
x,y=[]
xx,yy=[]
j=0
l=0
sum=0

fp.each do |item|
c=item.split(" ")
for i in 0..c.length do
  x=c[0].to_i
  y=c[1].to_i
  xx=c[2].to_i
  yy=c[3].to_i
end
j+=1

if (x>0) and (y<0) and (xx>0) and (yy<0) then
  ilg=ilgis(x,y,xx,yy)
  sum=sum+ilg
  puts "IV-ojo ketvircio #{j}-osios atkarpos ilgis #{ilg}"
end

end

puts "IV ketvirtyje atkarpu ilgiu suma #{sum}"