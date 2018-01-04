import static org.junit.Assert.*;

import org.junit.Test;

/*
 * Ce corrigé n'est pas complet, seuls quelques cas particulièrement intéressants ont été traités.
 */

public class TableauxDimensionSuperieureTest {

	// NB de valeurs vraies dim 2
	
		@Test
		public final void testnbTrueDimension2() {
			
			boolean[][] tabLongsZero = new boolean[0][0];
			assertEquals ("cas longueurs zéro", 0, TableauxDimensionSuperieure.nbTrueDim2(tabLongsZero));

			boolean[][] tabAvecTrueEnBornes = {{true, false, true},{true, false, true}};
			assertEquals ("cas longs>0 et true aux bornes", 4, TableauxDimensionSuperieure.nbTrueDim2(tabAvecTrueEnBornes));
			
			boolean[][] tabAvecTrueHorsBornes = {{false, true, false},{false, true, false}};
			assertEquals ("cas longs>0 et true hors bornes", 2, TableauxDimensionSuperieure.nbTrueDim2(tabAvecTrueHorsBornes));	
		}	
	
// NB de valeurs vraies dim 4
	
	@Test
	public final void testnbTrueDimension4() {
		
		boolean[][][][] tabLongsZero = new boolean[0][0][0][0];
		assertEquals ("cas longueurs zéro", 0, TableauxDimensionSuperieure.nbTrueDim4(tabLongsZero));

		boolean[][][][] tabAvecTrueEnBornes = {{{{true, false, true},{true, false, true}},
												{{true, false, true},{true, false, true}}},
											   {{{true, false, true},{true, false, true}},
												{{true, false, true},{true, false, true}}}};
		assertEquals ("cas longs>0 et true aux bornes", 16, TableauxDimensionSuperieure.nbTrueDim4(tabAvecTrueEnBornes));
		
		boolean[][][][] tabAvecTrueHorsBornes = {{{{false, true, false},{false, true, false}},
												  {{false, true, false},{false, true, false}}},
												 {{{false, true, false},{false, true, false}},
												  {{false, true, false},{false, true, false}}}};
		assertEquals ("cas longs>0 et true hors bornes", 8, TableauxDimensionSuperieure.nbTrueDim4(tabAvecTrueHorsBornes));	
	}

	
// est présent dim 2
	
	@Test
	public final void testEstPresentDimension2() {
	// Cette méthode de test est très incomplète. 
	// Un vrai jeu de tests nécessiterait de prendre en compte beaucoup d'autres cas.
		
		int[][] tabLongsZero = new int[0][0];
		assertFalse ("cas longueurs zéro", TableauxDimensionSuperieure.estPresentDim2(tabLongsZero,12));

		int[][] tab1 = {{12, 0, 5},{13, 8, 9}};
		assertTrue ("cas true 1", TableauxDimensionSuperieure.estPresentDim2(tab1, 12));

		int[][] tab2 = {{7, 0, 5},{13, 8, 12}};
		assertTrue ("cas true 2", TableauxDimensionSuperieure.estPresentDim2(tab2, 12));
		
		int[][] tabPasPrésent = {{7, 0, 5},{13, 8, 55}};
		assertFalse ("cas pas présent", TableauxDimensionSuperieure.estPresentDim2(tabPasPrésent, 12));
	}	
	
	
	
// mettre négatifs à zéro dim 2
	
	@Test
	public final void testMettreLesNégatifsAZéroDimension2() {

		int[][] longZéro = new int[0][0];
		TableauxDimensionSuperieure.mettreLesNégatifsàZéroDim2(longZéro);
		assertArrayEquals("cas Longueur zéro", new int[0][0],longZéro);
		
		int[][] observéNégatifsAuxExtrémités = {{-6, 5, -7, -1}, {-2, 0, 8, -2}, {-1, 7, 2, -12}};
		TableauxDimensionSuperieure.mettreLesNégatifsàZéroDim2(observéNégatifsAuxExtrémités);
		int[][] attenduCasAvecNégatifsAuxExtrémités = {{0,5,0,0},{0,0,8,0},{0,7,2,0}};
		assertArrayEquals("cas négatifs aux extrémités du tableau", attenduCasAvecNégatifsAuxExtrémités, observéNégatifsAuxExtrémités);
		
	}

	
// sommes des colonnes
	
	
		@Test
		public final void testSommeColonnesDimension2() {
			
			int[][] longZéro = new int[0][0];
			assertArrayEquals("cas Longueur zéro", new int[0],TableauxDimensionSuperieure.sommesColonnes(longZéro));
			
			int[][] entrée = {{-6, 5, -7, -1}, {-2, 0, 8, -2}, {-1, 7, 2, -12}};
			int[] attendu = { -9, 12, 3, -15};
			assertArrayEquals("cas moyen", attendu, TableauxDimensionSuperieure.sommesColonnes(entrée));
			
		}
	
	
	
// moyennes des colonnes.
	
	@Test
	public final void testMoyennesColonnes() {

		int[][] longZéro = new int[0][0];
		assertArrayEquals("Cas long zéro", new double[0], TableauxDimensionSuperieure.moyennesColonnes(longZéro), 0.0);
		
		int[][] casMoyen = {{2,4,6},{-6,2,13}};
		double[] attenduCasMoyen = {-2.0,3.0,9.5};
		assertArrayEquals("cas moyen", attenduCasMoyen, TableauxDimensionSuperieure.moyennesColonnes(casMoyen), 0.0);	
	}
	
	@Test (expected = Error.class)
	public final void testMoyennesColonnesSoustableauLongZéroEnTête() {
		int[][] soustableauLongZéroEnTête = {{},{2,3,4}};
		TableauxDimensionSuperieure.moyennesColonnes(soustableauLongZéroEnTête);
	}

	@Test (expected = Error.class)
	public final void testMoyennesColonnesSoustableauLongZéroEnFin() {
		int[][] soustableauLongZéroEnFin = {{2,3,4},{}};
		TableauxDimensionSuperieure.moyennesColonnes(soustableauLongZéroEnFin);
	}

	@Test (expected = Error.class)
	public final void testMoyennesColonnesSoustableauLongZéroAuMilieu() {
		int[][] soustableauLongZéroAuMilieu = {{3,12,2},{6,8,9},{},{2,3,4}};
		TableauxDimensionSuperieure.moyennesColonnes(soustableauLongZéroAuMilieu);
	}
	
	
	
}