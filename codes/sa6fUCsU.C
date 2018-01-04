#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <stdlib.h>
#include <locale.h>
#include <time.h>
#include <conio.h>
#include <string.h>

/*

*/

struct cmplx {
	double ReZ;
	double ImZ;
	struct cmplx *prev;
};

struct sign {
	char s;
	struct sign *prev;
};


struct cmplx* PUSH_c(double re, double im, struct cmplx *up) {
	struct cmplx *nu;
	nu = calloc(1, sizeof(struct cmplx));
	nu->ReZ = re;
	nu->ImZ = im;
	nu->prev = up;
	return nu;
}

struct cmplx* POP_c(double *re, double *im, struct cmplx *up) {
	*re = up->ReZ;
	*im = up->ImZ;
	if ((*up).prev != NULL) {
		struct cmplx *temp;
		temp = up->prev;
		free(up);
		return temp;
	}
	else {
		printf("\nBrak poprzedniego elementu stosu, nie będzie można wykonać poprawnie kolejnych operacji typu ( + - x / ) !!!");
		return up;
	}
}


//pozostałości po próbach realizacji dla ambitnych/:
int PUSH_s(char s, struct sign *up) {
	struct sign *nu_s;
	nu_s = calloc(1, sizeof(struct sign));
	nu_s->s = s;
	nu_s->prev = up;
	return &nu_s[0];
}

void POP_s(char *s, struct sign *up) {
	*s = up->s;
	if (up->prev != NULL) {
		struct sign *temp = up->prev;
		free(up);
		up = temp;
	}
	else {
		printf("\nBrak poprzedniego elementu stosu, nie będzie można wykonać kolejnych operacji");
	}
}

void readData(){
	FILE* file;
	char input[300];
	char *inputPtr;
	inputPtr = &input;
	memset(inputPtr, 0, 300);
	printf("\npodaj po kolei liczby zespolone w formacie a+bi rozdzielone spracjami \na następnie po spacji znaki operacji też rozdzielone spacjami(+-/*):\n");
	gets(inputPtr);
	file = fopen("buffer.jp", "w");
	fprintf(file, "%s", input);
	fclose(file);
}

void makeStack(struct cmplx *up, struct sign *upS) {
	FILE* file;
	file = fopen("buffer.jp", "w");
	int reT,imT, i;
	char cTab[2];
	
	///tutaj jakieś rzeczy mondre///
	while (feof(file)!=1) {
		if (fscanf(file, "%d+%di", &reT, &imT) == 1) {
			PUSH_c(reT, imT, up);
		}

		if (fscanf(file, "%1s", cTab) == 1) {
			PUSH_s(cTab[0], upS);
		}
		//fscanf(file, "%*[^\n]");//??
	}

	fclose(file);
}
/////////////////////////////////////////////////////////////


int add(struct cmplx *up) {
	double r1, r2, i1, i2, rw, iw, *r1p, *r2p, *i1p, *i2p;
	r1p = &r1;
	r2p = &r2;
	i1p = &i1;
	i2p = &i2;
	up = POP_c(r1p, i1p, up);
	up = POP_c(r2p, i2p, up);
	rw = r1 + r2;
	iw = i1 + i2;
	up = PUSH_c(rw, iw, up);
	return &up[0];
}

int subtract(struct cmplx *up) {
	double r1, r2, i1, i2, rw, iw, *r1p, *r2p, *i1p, *i2p;
	r1p = &r1;
	r2p = &r2;
	i1p = &i1;
	i2p = &i2;
	up = POP_c(r1p, i1p, up);
	up = POP_c(r2p, i2p, up);
	rw = r1 - r2;
	iw = i1 - i2;
	up = PUSH_c(rw, iw, up);
	return &up[0];
}

int multiply(struct cmplx *up) {
	double r1, r2, i1, i2, rw, iw, *r1p, *r2p, *i1p, *i2p;
	r1p = &r1;
	r2p = &r2;
	i1p = &i1;
	i2p = &i2;
	up = POP_c(r1p, i1p, up);
	up = POP_c(r2p, i2p, up);
	rw = (r1*r2 - i1*i2);
	iw = (r1*i2 - r2*i1);
	up = PUSH_c(rw, iw, up);
	return &up[0];
}


int divide(struct cmplx *up) {
	double r1, r2, i1, i2, rw, iw, *r1p, *r2p, *i1p, *i2p;
	r1p = &r1;
	r2p = &r2;
	i1p = &i1;
	i2p = &i2;

	up = POP_c(r1p, i1p, up);
	up = POP_c(r2p, i2p, up);
	if (r2 != 0 || i2 != 0) {
		rw = ((r1*r2) + (i1*i2)) / ((r2*r2)*(i2*i2));
		iw = ((i1*r2) - (r1*i2)) / ((r2*r2)*(i2*i2));
	}
	else {
		iw = 0;
		rw = 0;
		printf("\nCHCIAŁEŚ WYKONAĆ DZIELENIE PRZEZ 0, ZA KARĘ ZAMIAST WYNIKU WPISANO 0");
	}

	up = PUSH_c(rw, iw, up);
	return &up[0];
}

int realpart(struct cmplx *up) {
	up->ImZ = 0;
	return &up[0];
}

int imaginarypart(struct cmplx *up) {
	up->ReZ = 0;
	return &up[0];
}

int conj(struct cmplx *up) {
	double temp = up->ImZ; 
	temp = -temp;
	up->ImZ = temp;
	return &up[0];
}







int scanI() {
	int temp;
	while (1) {
		if (scanf("%d", &temp) == 1) {
			return temp;
		}
		printf("Podano niewłaściwy format, spróbuj ponownie:\t");
		scanf("%*s");
	}
}

double scanD() {
	double temp;
	while (1) {
		if (scanf("%lf", &temp) == 1) {
			return temp;
		}
		printf("Podano niewłaściwy format, spróbuj ponownie:\t");
		scanf("%*s");
	}
}





int main() {
	setlocale(LC_ALL, "polish_poland");
	struct cmplx *upper;
	struct cmplx *first;
	struct sign *upperS;
	struct sign *firstS;

	int numb_nxt = 1;
	int sign_nxt = 1;
	int calc_nxt = 1;
	int first_in_c = 0;
	int prev_ent_c = 0;
	int first_in_s = 0;
	int prev_ent_s = 0;

	int stack_cnt = 0;

	int i;

	double temp1, temp2;
	char temp3;

	double nure, nuim, re1, im1, re2, im2;
	double *nurep, *nuimp, *re1p, *im1p, *re2p, *im2p;
	char sign;
	char *signp;

	nurep = &nure;
	nuimp = &nuim;
	im1p = &im1;
	re1p = &re1;
	im2p = &im2;
	re2p = &re2;
	signp = &sign;

	first = calloc(1, sizeof(struct cmplx));
	first->prev = NULL;
	firstS = calloc(1, sizeof(struct sign));
	firstS->prev = NULL;
	
	upper = NULL;
	upperS = NULL;

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//wprowadzanie liczb:
	while (numb_nxt != 0) {
		stack_cnt++;
	ifincorrectnumber:
		printf("\npodaj liczbę zespoloną w formacie a+bi:\n\t");
		if (scanf("%lf+%lf%c", &temp1, &temp2, &temp3)!=0 && temp3=='i') {
			printf("\nscan popr.");
			nure = temp1;
			nuim = temp2;
			if (first_in_c == 1) {
				printf("\npushuję");
				upper=PUSH_c(nure, nuim, upper);
				if (prev_ent_c == 0) {
					upper->prev = first;
					prev_ent_c = 1;
				}
				if (upper->ReZ != 0 && upper->ImZ != 0) {
					printf("\nwprowadzono (%lf)+(%lf)i", upper->ReZ, upper->ImZ);
				}
				else if (upper->ReZ != 0) {
					printf("\nwprowadzono %lf", upper->ReZ);
				}
				else if (upper->ImZ != 0) {
					printf("\nwprowadzono (%lf)i", upper->ImZ);
				}
			}
			if (first_in_c == 0) {
				printf("\nwczyt. na 1wszy");
				first->ReZ = nure;
				first->ImZ = nuim;
				first_in_c = 1;
				if (first->ReZ != 0 && first->ImZ != 0) {
					printf("\nwprowadzono (%lf)+(%lf)i", first->ReZ, first->ImZ);
				}
				else if (first->ReZ != 0) {
					printf("\nwprowadzono %lf", first->ReZ);
				}
				else if (first->ImZ != 0) {
					printf("\nwprowadzono (%lf)i", first->ImZ);
				}
			}
		}	
		
		else{
			printf("\npodano nieprawidłowy format, spróbuj ponownie:\n\t");
			scanf("%*s");
			goto ifincorrectnumber;
		}
		printf("\nna stosie znajduje się %d liczb \n czy chcesz podać kolejną liczbę? naciśnij literę:\n [n] = nie \n [dowolna inna] = tak\n", stack_cnt);
		temp3 = _getch();
		if (temp3 == 'n') {
			numb_nxt = 0;
		}
	}

	if (stack_cnt=1) {
		//upper = calloc(1, sizeof(struct cmplx));
		upper = first;
	}


	//wprowadzanie znaków i operacje	
	while (sign_nxt != 0) {

	ifincorrectsign:
		printf("\npodaj znak działania: \n\t");
		if (scanf(" %c", &temp3) != 0) {
			printf("\nscan popr.");
			sign = temp3;
		}
		else {
			printf("\npodano nieprawidłowy format, spróbuj ponownie:\n\t");
			scanf("%*s");
			goto ifincorrectsign;
		}

		switch (sign) {
		case '+':
			upper=add(upper);
			printf("\ndodano");
			stack_cnt--;
			//dodawanie
			break;
		case '-':
			upper = subtract(upper);
			printf("\nodjęto");
			stack_cnt--;
			//odejmowanie
			break;
		case 'x':
			upper = multiply(upper);
			printf("\npomnożono");
			stack_cnt--;
			//odejmowanie
			break;
		case '/':
			upper = divide(upper);
			printf("\npodzielono");
			stack_cnt--;
			break;
		case 'r':
			upper = realpart(upper);
			printf("\nczęść rzeczywista");
			break;
		case 'i':
			upper = imaginarypart(upper);
			printf("\nczęść urojona");
			break;
		case 's':
			upper = conj(upper);
			printf("\nsprzężenie");
			break;
		default:
			printf("\nnie ma takiej operacji\n");
			break;
		}

		if (upper != 0) {
			if (upper->ReZ != 0 && upper->ImZ != 0) {
				printf("\naktualny wynik to: (%lf)+(%lf)i", upper->ReZ, upper->ImZ);
			}
			else if (upper->ReZ != 0) {
				printf("\naktualny wynik to: %lf", upper->ReZ);
			}
			else if (upper->ImZ != 0) {
				printf("\naktualny wynik to: (%lf)i", upper->ImZ);
			}
			else {
				printf("\n przeleciało warunki wyświetlania");
			}
		}
			

		else {
			printf("\nz powodu błędu zastosowania kalkulatora nie można podać aktualnego wyniku");
		}


		printf("\n na stosie znajduję się %d liczb, czy chcesz podać kolejny znak? naciśnij literę:\n [n] = nie \n [dowolna inna] = tak\n", stack_cnt);
		temp3 = _getch();
		if (temp3 == 'n') {
			sign_nxt = 0;
		}
	}

	printf("\n\n");
	if (upper != 0) {
		if (upper->ReZ != 0 && upper->ImZ != 0) {
			printf("\nOSTATECZNY WYNIK TO: (%lf)+(%lf)i", upper->ReZ, upper->ImZ);
		}
		else if (upper->ReZ != 0) {
			printf("\nOSTATECZNY WYNIK TO: %lf", upper->ReZ);
		}
		else if (upper->ImZ != 0) {
			printf("\nOSTATECZNY WYNIK TO: (%lf)i", upper->ImZ);
		}
	}
	printf("\n\n");
	system("PAUSE");
	return 0;
}