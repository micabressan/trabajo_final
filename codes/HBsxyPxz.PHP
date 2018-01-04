/*
					"select periodos_letivos.id, periodos_letivos.nome, periodos_letivos.data_inicio, periodos_letivos.data_fim
					from calendarios_escolares
					left join semestres on calendarios_escolares.id = semestres.calendarios_escolaresid
					left join periodos_letivos on semestres.id = periodos_letivos.semestreid
					where calendarios_escolares.ano_letivo = '" . $ANOLETIV . "' and semestres.designacao = '" . $SEMESTRE . "';"
				*/
                $res = Calendarios_escolares::leftJoin('semestres', 'calendarios_escolares.id', '=', 'semestres.calendarios_escolaresid')->leftJoin('periodos_letivos', 'semestres.id', '=', 'periodos_letivos.semestreid')->select('periodos_letivos.id', 'periodos_letivos.nome', 'periodos_letivos.data_inicio', 'periodos_letivos.data_fim')->where([
                    ['calendarios_escolares.ano_letivo', '=',$ano ],['semestres.designacao', '=', $sem],
                ])->get();