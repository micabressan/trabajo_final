#include "stdafx.h"
#include "klase.hpp"

using namespace std;

static vector<Word> words;
static set <string> unique_words;
static vector<string> text;
static string file_path, output_path;

static int count_line_words(const string);
static void add_word(string);

int _tmain(int argc, _TCHAR* argv[]) {
	/*
		get input and output file
	*/
	cout << "Input file(full path): " << endl;
	cin >> file_path;
	cout << "Output file(full path): " << endl;
	cin >> output_path;
	
	/*
		declare external files
	*/
	static ifstream f_read;
	static ofstream f_write;

	static string line;
	static int wordcount = 0;

	f_read.open(file_path);

	if (f_read.is_open()) {
		while (getline(f_read, line)) {
			text.push_back(line);
		}
		f_read.close();
	}
	for (vector<string>::iterator it = text.begin(); it != text.end(); ++it) {
		count_line_words(static_cast<const string>((*it)));
		add_word(static_cast<const string>((*it)));
	}
	cout << "Broj reci je: " << wordcount;
	for (set<string>::iterator it = unique_words.begin(); it != unique_words.end(); ++it) {
		cout << (*it) << endl;
	}
	return 0;
}

static int count_line_words(const string line) {
	int words = 0;
	for (unsigned short int i = 0; i < line.length(); i++) {
		if (static_cast<char>(line[i]) == ' ')
			words++;
	}
	return words;
}

static void add_word(string line) {
	char* c;
	char str[line.length] = static_cast<char[line.length]>(line);
	c = strtok(str, " ,.-");

	while (c != NULL) {
		unique_words.insert(c);
		c = strtok(NULL, " ,.-");
	}
}