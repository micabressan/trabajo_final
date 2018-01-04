int main(int argc, char *argv[]) {
	t3_config_error_t error;
	FILE *file = stdin;
	t3_config_t *config, *reread;

	setlocale(LC_ALL, "nl_NL.UTF-8");

	if (argc == 2) {
	//char *fileName = argv[optind];
		if ((file = fopen(argv[optind], "r")) == NULL)
			fatal("Could not open input '%s': %m\n", argv[optind]);
	} else if (argc > 2) {
		fatal("Usage: test [<test file>]\n");
	}

	if (argc <= 1) {
		fatal("argc too small\n");
	}

	char * dupptr = strdup(argv[optind]);
	path[0] = dirname(dirname(dupptr));
	path[1] = NULL;

	/* Read file. */
	if ((config = t3_config_read_file(file, &error, &opts)) == NULL)
		fatal("Error loading input: %s %s @ %d\n", t3_config_strerror(error.error),
			error.extra == NULL ? "" : error.extra, error.line_number);
	fclose(file);

	/* Write new file. */
	if ((file = fopen("out", "w+")) == NULL)
		fatal("Could not open output: %m\n");
	t3_config_write_file(config, file);
	fclose(file);

	if ((file = fopen("out", "r")) == NULL)
		fatal("Could not re-open output: %m\n");
	if ((reread = t3_config_read_file(file, &error, NULL)) == NULL)
		fatal("Error re-loading output: %s @ %d\n", t3_config_strerror(error.error), error.line_number);
	fclose(file);

	compare_config(config, reread);
	t3_config_delete(config);
	t3_config_delete(reread);

	free(dupptr);

	return EXIT_SUCCESS;
}