#include <iostream>
#include <limits>
#include <array>

//-------------------------------------------------------------------------------------
void leer_valor(int& v, std::string msg)
{
	std::cout << msg;
	std::cin >> v;
	while (std::cin.fail())
        {
            std::cin.clear();
            std::cin.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
	    std::cout << msg;
            std::cin >> v;
        }
}

//-------------------------------------------------------------------------------------
bool comprobar_estado_partida(std::array<int, 7>& charca)
{
	/* comprobar si la partida a finalizado o no */
	for (int i = 0; i < 3; i++)
	{
		if (charca[i] != i + 4)
		{
			return false;
		}
	}
	for (int i = 4; i < 7; i++)
	{
		if (charca[i] != i - 3)
		{
			return false;
		}
	}

	return true; 
}

//-------------------------------------------------------------------------------------
void realizar_movimientos(std::array<int, 7>& charca, int& rana_a_mover, int& tam_salto)
{
	/* realizar cambios de posición de las ranas */
	for (int i = 0; i < 7; i++)
	{
		if (charca[i] == rana_a_mover)
		{
			if (rana_a_mover <= 3)
			{
				charca[i] = 0;
				charca[i + tam_salto] = rana_a_mover;
				break;
			}
			else if (rana_a_mover >= 4)
			{
				charca[i] = 0;
				charca[i - tam_salto] = rana_a_mover;
				break;
			}
		}
	}
}

//-------------------------------------------------------------------------------------
void leer_movimientos(std::array<int, 7>& charca, int& rana_a_mover, int& tam_salto)
{
	int pos_rana = 0;
	bool rana_correcta  = false;
	bool salto_correcto = false;

	/* mientras los valores introducidos sean erroneos */
	while (!rana_correcta || !salto_correcto)
	{
	    /* ¿qué rana desea mover? */
	    leer_valor(rana_a_mover, "[+] Rana a mover: ");

	    /* comprobar si la rana introducida existe */
	    for (int i = 0; i < 7; i++)
	    {
	   		if (charca[i] == rana_a_mover)
	   		{
	   			rana_correcta = true;
	   			break;
	   		}
	    }

	    /* leer el tamaño del salto */
	    leer_valor(tam_salto, "[+] Saltar a piedra libre que tienen enfrente (1) o pueden saltar por encima de una rana (2): ");

	    /* comprobar si el tamaño del salto es correcto */
	    if (tam_salto == 1 || tam_salto == 2)
	    {
		/* guardar posicion de la rana que se desea desplazar */
		for (int i = 0; i < 7; i++)
		{
			if (charca[i] == rana_a_mover)
			{
				pos_rana = i; 
			}
		}

		/* comprobar si la posición a la que se quiere mover la rana esta vacía */
		if ((charca[pos_rana + tam_salto] == 0 && rana_a_mover <= 3) || 
			(charca[pos_rana - tam_salto] == 0 && rana_a_mover >= 4))
		{
			salto_correcto = true;
		}
	     }
	}
}

//-------------------------------------------------------------------------------------
void imprimir_charca(std::array<int, 7> &charca)
{
	/* imprimir la charca */
	for (int i = 0; i < 7; i++)
	{
		std::cout << charca[i] << "  "; 
	}
	std::cout << std::endl;
}

//-------------------------------------------------------------------------------------
bool jugando()
{
	int rana_a_mover = 0; 
	int tam_salto = 0;

	static std::array<int, 7> charca = {1, 2, 3, 0, 4, 5, 6};	 

	imprimir_charca(charca);
	leer_movimientos(charca, rana_a_mover, tam_salto);
	realizar_movimientos(charca, rana_a_mover, tam_salto);
	/* comprueba si has superado el reto o no */
	if (comprobar_estado_partida(charca))
	{
		std::cout << "[!] Enhorabuena, has superado el reto." << std::endl;
		return false;
	}
	
	return true;
}

//-------------------------------------------------------------------------------------
int main()
{
	while (jugando());
	/* se cierra el programa con éxito */
	return EXIT_SUCCESS; 
}