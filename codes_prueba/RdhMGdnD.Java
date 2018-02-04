Tarea nueva=new Tarea(nombreP, descripcionP, fechaInicioP, fechaFinTarea);
		Tarea actual=primeraTarea;
		if(primeraTarea==null)
		{
			primeraTarea=nueva;
		}
		else if(actual!=null){
			while(actual.darSiguienteTarea()!=null)
			{
				if(actual.darNombre().equals( nueva.darNombre() )&& actual.darFechaInicio().equals( nueva.darFechaInicio()))
				{
					throw new ElementoExisteException("Ya existe la tarea");
				}
				actual=actual.darSiguienteTarea();
			}
			actual.cambiarSiguienteTarea(nueva);

		}