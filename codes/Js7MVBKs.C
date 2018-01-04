void indexImageNB(){
	remove("test_descripteur");
	FILE * p;
	FILE * f = NULL;
	char * res = malloc(sizeof(char));
	//p = popen("ls TEST_NB/ | grep .txt |  sed -i -e 's#^#/TEST_NB#'", "r");
	p = popen("ls TEST_NB/ | grep .txt ", "r");

	IMAGE_NB * image1; 
	int nbligne, nbcolonne, type;


	while (fscanf(p,"%s",res) == 1) {
	 	printf("%s\n",res );
	 	lectureFichier(res,&f,&nbligne,&nbcolonne,&type);
	 	printf("a\n");
		fflush(stdout);
	  	image1 = initImageNB(res,nbligne,nbcolonne);
	  	printf("b\n");
		fflush(stdout);
		lectureImgageNB(*image1,f);
		printf("c\n");
		fflush(stdout);
		quantificationImageNB(*image1);
		printf("d\n");
		fflush(stdout);
		creationDescripteur(*image1);
		printf("e\n");
		fflush(stdout);
		fclose(f);
		free(image1);
		printf("Fichier traite\n");
		fflush(stdout);
	}

}