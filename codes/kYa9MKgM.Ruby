#Ler o arquivo de configuração do sistema
setup = YAML.load_file("setup.yml")
root = setup["RaizFTP"]

#Ler o arquivo de configuração de cada cliente
loop do
	$c_setup = Dir.glob("#{root}/*/setup.{yml, yaml}")
	
	unless $c_setup.empty?
		$c_setup.each do |item|
			$c_setup = YAML.load_file(item)
			
			$c_setup["PapelJornal"].zip($c_setup["PapelOffset"]).each do |item2, item3|
				$received_n = Find.find(root).grep(/\/#{item2}#/).grep(/.pdf$/)
				$received_o = Find.find(root).grep(/\/#{item3}#/).grep(/.pdf$/)
				
				$originals = [File.dirname(item) + "/#{item2}_original"] + [File.dirname(item) + "/#{item3}_original"]
				
				puts $originals
				
				#$inksaving = [File.dirname(item) + "/#{item2}_inksaving"]
				#$jpg = [File.dirname(item) + "/#{item2}_jpg"]
				
				#$originals = $originals + [File.dirname(item) + "/#{item2}_original"]
				#$inksaving = $inksaving + [File.dirname(item) + "/#{item2}_inksaving"]
				#$jpg = $jpg + [File.dirname(item) + "/#{item2}_jpg"]
			end
			
			#Não citar a variável $originals fora deste laço, pois ela ficará incompleta
		end
		
		#Criar pastas
		
		else
			puts "Não há quaisquer arquivos de configuração dos clientes."
	end
	
	#Aguardar 5 segundos
	sleep(5)
end