	public Pereche ( Persoana numeP1 , Persoana numeP2 ) {
		
		try {
			if ( ( numeP1.getNume() == null ) || ( numeP1.getPrenume() == null ) || ( numeP1.getVarsta() == 0 ) || ( numeP1.getProfesie() == null ) )
				throw new Exception() ;
			else
				this.numePartener1 = numeP1 ;
		
			if ( ( numeP2.getNume() == null ) || ( numeP2.getPrenume() == null ) || ( numeP2.getVarsta() == 0 ) || ( numeP2.getProfesie() == null ))
				throw new Exception() ;
			else
				this.numePartener2 = numeP2 ;
		}
		catch (Exception e ) {
			
			System.out.println(e.getMessage());
		
		}
		
	}