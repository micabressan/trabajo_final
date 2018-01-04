
def generarMatrizVotos(sed, cand)
  matrizVotos = []
  
  for i in 0.step(3)
    matrizVotos[i]=[]
    for j in 0.step(2)
      puts "Ingrese los votos del candidato #{cand[j]} en la sede #{sed[i]}"
       votos = gets.chomp.to_i
       matrizVotos[i][j]=votos
    end
  end
  
  return matrizVotos
  
end

def imprimirPorCandidato(can, votos)
	for i in 0.step(can.length-1)
		puts "Votos del candidato #{can[i]} son: #{votos[i]}"
	end
end

def cantidadVotos(matrizV)
  cantidadCandidato=[]
  
  for j in 0.step(matrizV[0].length-1)
      cantidadCandidato[j]=0
      for i in 0.step(matrizV.length-1)
        cantidadCandidato[j]+=matrizV[i][j]
    end
  end
  return cantidadCandidato
end

def ganador(c,nombres)
  mayor = c[0]
  nombreGanador = nombres[0]
  for i in 0.step(c.length-1)
    if c[i]>mayor
      mayor = c[i]
      nombreGanador = nombres[i]
    end
  end
  return nombreGanador
end

candidatos = ["Ivan Ramos", "Jorge Sanchez", "Jose Rios"]

sedes = ["Cali","Palmira", "Buga", "Tulua"]

matrizVotos = generarMatrizVotos(sedes,candidatos)

totalPorCandidato  = cantidadVotos(matrizVotos)

imprimirPorCandidato(candidatos,totalPorCandidato)

nuevoRector = ganador(totalPorCandidato,candidatos)

puts "El ganador es: #{nuevoRector}"