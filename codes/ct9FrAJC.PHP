case 35:
				/*
                    $args[0] = date A
					$args[1] = date B
                    get ALL ocupacoes docente between date A and date B
                    
                    "SELECT data, hora_inicio, hora_fim, motivo, docentesid
                    FROM ocupacoes_docentes
                    WHERE data BETWEEN '. $ocupacoes[i]->data. ' AND '. $ocupacoes[i]->data. '"
				*/
                $res = Ocupacoes_docentes::select('data', 'hora_inicio', 'hora_fim', 'motivo', 'docentesid')->whereBetween('data', [$args[0], $args[1]])->get();
				break;