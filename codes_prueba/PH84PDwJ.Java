/*PASSOS PREVIS: LLegir el contingut del fitxer PassosASeguir.txt (dins del zip del fitxer adjunt) 

EXERCICI:
Heu d'implementar el mètode Consulta de la classe CtrlDdadesPublic. Aquest mètode ha de: 
- Retornar una fila per cada dni de professor obtingut a partir dels paràmetres d'entrada. En cada fila hi ha d'haver el dni d'un professor i la quantitat d'assignacions del professor.

Cal tenir en compte que: 
- Els dni de professors en els paràmetres d'entrada s'hauran acabat quan es trobi el dni -999.
- Cal que tingueu en compte que en Java per comparar strings s'ha d'usar els mètodes equals o compareTo de la classe String. 

En cas que ocorri algun error, el mètode ha de llançar una excepció identificada amb el codi d'error que s'indica.
11: Error intern

Pel joc de proves públic el resultat que s'obtindrà és el següent:
Dni	Quantitat d'assignacions	
111	1

En el fitxer adjunt trobareu: 
- Els passos a seguir: (PassosASeguir.txt)
- Les classes i mètodes per obtenir els paràmetres d'entrada: (MetodesAuxiliars.txt) 
- Les classes i mètodes per retornar el resultat i llençar excepcions: (MetodesAuxiliars.txt) 
- El projecte Eclipse que cal estendre. */

/*-----------------------*/
/* Imports de la classe */
import java.sql.*;
/* Capa de Control de Dades */
class CtrlDadesPublic extends CtrlDadesPrivat {
    public ConjuntTuples consulta(Connection c, Tuple params) throws BDException {
        ConjuntTuples ct = new ConjuntTuples();
        try {
            PreparedStatement ps = c.prepareStatement("SELECT p.dni, COUNT(a.dni) FROM "
                    + "PROFESSORS p, ASSIGNACIONS a WHERE p.dni = a.dni AND "
                    + "p.dni = ? GROUP BY p.dni;");
            int i = 1;
            String dni;
            while(i <= params.tamany() && !(dni = params.consulta(i)).equals("-999")) {
                ps.setString(1, dni);
                ResultSet rs = ps.executeQuery();
                if(rs.next()) {
                    Tuple t = new Tuple();
                    t.afegir(rs.getString(1));
                    t.afegir(rs.getString(2));
                    ct.afegir(t);
                }
                i++;
            }
        } catch(SQLException sqle) {
            throw new BDException(11);
        }
        return ct;
    }
}




/*--------------------------------------------------------------------
PASSOS PREVIS: LLegir el contingut del fitxer PassosASeguir.txt 

EXERCICI:
Heu d'implementar el mètode consulta. Aquest mètode ha de: 
Esborrar els despatxos del mòdul D que tenen una superfície inferior a S. Els paràmetres D i S es passaran en els paràmetres d'entrada del mètode consulta.
Retornar una única fila amb la suma de les superfícies dels despatxos que queden a la base de dades després de la sentència d'esborrat. Si no en queda cap a la base de dades, en lloc d'un 0, ha de sortir "NO".
Retornar per cada professor que hi ha a la base de dades que té alguna assignació finalitzada, el nom del professor i la quantitat d'assignacions finalitzades que té a despatxos.

Cal tenir en compte que:
En les dades d'entrada només es passa un únic nom de mòdul i una superfície.

En cas que s'identifiqui una de les situacions següents, el mètode ha de llançar una excepció identificada amb el codi d'error que s'indica.
12: No hi ha cap despatx en el modul passat com a parametre amb superfície més petita que S . 
13: Algun dels despatxos a esborrar té assignacions de professors i no es pot esborrar. 
14: Error Intern

Pel joc de proves públic el contingut de la taula d'assignacions serà el següent:
20	
Toni	1

En el fitxer adjunt trobareu: 
- Els passos a seguir: (PassosASeguir.txt)
- La descripció del conjunt del programa Practica: (ProgramaPractica.pdf) 
- Les classes i mètodes per obtenir els paràmetres d'entrada: (MetodesAuxiliars.txt) 
- Les classes i mètodes per retornar el resultat i llençar excepcions: (MetodesAuxiliars.txt) 
- El projecte Eclipse que cal estendre. 
--------------------*/

/* Imports de la classe */
import java.sql.*; 

/* Capa de Control de Dades */
class CtrlDadesPublic extends CtrlDadesPrivat {
	
	public ConjuntTuples consulta(Connection c, Tuple params) throws BDException {
		ConjuntTuples ct = new ConjuntTuples();
		
		try{
			String modul = params.consulta(1);
			int superficie = Integer.parseInt(params.consulta(2));
		
			Statement s = c.createStatement();
			int nDespatxos = s.executeUpdate("DELETE FROM DESPATXOS d "
					+ "WHERE d.modul = '" + modul + "' AND "
							+ "d.superficie < " + superficie + ";");
			
			if(nDespatxos == 0) throw new BDException(12);
			
			ResultSet rs = s.executeQuery("SELECT SUM(D.superficie) FROM "
					+ "DESPATXOS D;");
			
			rs.next();
			int superficieRestant = rs.getInt(1);
			
			Tuple t = new Tuple();
			if(rs.wasNull()){
				t.afegir("NO");
			} else {
				t.afegir("" + superficieRestant);
			}
			
			ct.afegir(t);
			
			ResultSet profAssig = s.executeQuery("SELECT p.nomProf, COUNT(*) "
					+ "FROM professors p, assignacions a "
					+ "WHERE p.dni = a.dni AND a.instantFi IS NOT NULL "
					+ "GROUP BY p.nomProf;");
			
			while(profAssig.next()){
				Tuple t1 = new Tuple();
				t1.afegir(profAssig.getString(1));
				t1.afegir(profAssig.getString(2));
				ct.afegir(t1);
			}
			
			s.close();
		} catch(SQLException e){
			//System.out.println(e.getMessage());
			if(e.getSQLState().equals("23503")) throw new BDException(13);
			throw new BDException(14);
		}
		
		return ct;
	}
}