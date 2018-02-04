puts "ingrese el presupuesto inicial destinado a la recuperación del campo"
presupuestoInicial=gets.chomp.to_f

def datosmatriz(n,m)
matrizprincipal=[]
puts "ingrese la cantidad de proyectos"
cantidad=gets.chomp.to_i
for i in 0.step(cantidad-1)
matrizprincipal[i]=[]
for j in 1.step(4)
puts  "#{n[i]} #{m[j]}"
proyectos=gets.chomp.to_i
matrizprincipal[i][j]=proyectos 
end
matrizprincipal[i][0]=i+1
end
return matrizprincipal
end


def asignacionpresupuesto(matrizprincipal,presupuestoInicial)
    presupuestoZona=[]
    presupuestoTotal=[]
    for j in 0.step(matrizprincipal.size-1)
    if matrizprincipal[j][1]==1
        presupuestoZona[j]=presupuestoInicial*0.25
           elsif matrizprincipal[j][1]==2
            presupuestoZona[j]=presupuestoInicial*0.20
              elsif matrizprincipal[j][1]==3
                presupuestoZona[j]=presupuestoInicial*0.35
                elsif matrizprincipal[j][1]==4
                    presupuestoZona[j]=presupuestoInicial*0.20
                else
                    puts "Codigo invalido"
             end
             
    end
    
    for j in 0.step(matrizprincipal.size-1)
    if matrizprincipal[j][2]==1 and matrizprincipal[j][4] < 6
        presupuestoTotal[j]=presupuestoZona[j]*0.006*matrizprincipal[j][3]+((presupuestoZona[j]*0.006)*0.04)
         else matrizprincipal[j][1]==1 and matrizprincipal[j][4] > 5
        presupuestoTotal[j]=presupuestoZona[j]*0.006*matrizprincipal[j][3]+((presupuestoZona[j]*0.006)*0.06)
    end
     if matrizprincipal[j][2]==2 and matrizprincipal[j][4] < 6
        presupuestoTotal[j]=presupuestoZona[j]*0.005*matrizprincipal[j][3]+((presupuestoZona[j]*0.005)*0.04)
          else matrizprincipal[j][2]==2 and matrizprincipal[j][4] > 5
             presupuestoTotal[j]=presupuestoZona[j]*0.005*matrizprincipal[j][3]+((presupuestoZona[j]*0.005)*0.06)
    end
    if matrizprincipal[j][2]==3  and matrizprincipal[j][4] < 6 
        presupuestoTotal[j]=presupuestoZona[j]*0.02+((presupuestoZona[j]*0.02)*0.04)
         else matrizprincipal[j][2]==3  and matrizprincipal[j][4] > 5
        presupuestoTotal[j]=(presupuestoZona[j]*0.02)+((presupuestoZona[j]*0.02)*0.06)
    end
    if matrizprincipal[j][2]==4  and matrizprincipal[j][4] < 6 
        presupuestoTotal[j]=presupuestoZona[j]*0.02+((presupuestoZona[j]*0.02)*0.04)
         else matrizprincipal[j][2]==3  and matrizprincipal[j][4] > 5
        presupuestoTotal[j]=presupuestoZona[j]*0.02+((presupuestoZona[j]*0.02)*0.06)
    end
    end
    return presupuestoTotal,presupuestoZona
    
end

def proyectosavalados(presupuestoZona,presupuestoTotal,matrizprincipal)
    avalados=[0,0,0,0]
    avaladosPacifico=[]
    avaladosAtlantico=[]
    avaladosCentro=[]
    avaladosOriental=[]
    for j in 0.step(matrizprincipal.size-1)
        if matrizprincipal[j][1]==1
            if presupuestoTotal[j]+avalados[0]<presupuestoZona[0]
                avalados[0]+=presupuestoTotal[j]
                avaladosPacifico[j]=j+1
            end
        elsif matrizprincipal[j][1]==2
            if presupuestoTotal[j]+avalados[1]<presupuestoZona[1]
                avalados[1]+=presupuestoTotal[j]
                avaladosAtlantico[j]=j+1
            end
        elsif matrizprincipal[j][1]==3
            if presupuestoTotal[j]+avalados[2]<presupuestoZona[2]
                avalados[2]+=presupuestoTotal[j]
                avaladosCentro[j]=j+1
            end
        elsif matrizprincipal[j][1]==4
            if presupuestoTotal[j]+avalados[3]<presupuestoZona[3]
                avalados[3]+=presupuestoTotal[j]
                avaladosOriental[j]=j+1
            end
        else 
            puts "Algun error rectifique"
        end
    end
    return avalados,avaladosPacifico,avaladosAtlantico,avaladosCentro,avaladosOriental  
end

items=["orden de llagada","zona","activida productiva","cantidad de hectareas","cantidad de personas"]
orden=[]
matrizprincipal=datosmatriz(orden,items)
presupuestoTotal,presupuestoZona=asignacionpresupuesto(matrizprincipal,presupuestoInicial)
avalados,avaladosPacifico,avaladosAtlantico,avaladosCentro,avaladosOriental=proyectosavalados(presupuestoZona,presupuestoTotal,matrizprincipal)


#PORGRAMA PRINCIPAL
puts "#{matrizprincipal}"
puts "#{asignacionpresupuesto(matrizprincipal,presupuestoInicial)}"
puts "los presupuestos avalados para la zona pacifica #{avalados[0]}"
puts "los proyectos avalados son #{avaladosPacifico}"
puts "los presupuestos avalados para la zona Atlantica #{avalados[1]}"
puts "los proyectos avalados son #{avaladosAtlantico}"
puts "los presupuestos avalados para la zona centro #{avalados[2]}"
puts "los proyectos avalados son #{avaladosCentro}"
puts "los presupuestos avalados para la zona oriental #{avalados[3]}"
puts "los proyectos avalados son #{avaladosOriental}"