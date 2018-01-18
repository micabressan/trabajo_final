Plokštumoje yra daug taškų, kurių koordinatės x, y. Surasti artimiausią koordinačių pradžiai IV –o ketvirčio tašką. Atstumui iki koord. pradžios nustatyti sudarykite metodą.
#4 5 
#3 -5 
#-2 -10 
#-9 8 
#8 -6 
#-6 -2 
#-3 -8


min=9999

def atstumas (x,y)
  atstum=((0-x)**2+(0-y)**2)**0.5
end

fp=File.open("input.txt", "r")
rz=File.open("output.txt", "w+")
x,y=[]

fp.each do |item|
c=item.split(" ")
for i in 0..c.length do
  x=c[0].to_i
  y=c[1].to_i
end

atst=atstumas(x,y)
if (x<0) and (y<0) then
  if (atst<min) then
    min=atst
  end
end

end

puts "IV ketvirtyje artimiausias koordinaciu pradzios ilgis yra #{min}"