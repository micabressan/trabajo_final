#include <iostream>
#include <fstream>
#include <string>
#include <vector>

using namespace std;

class SalesData
{
private:
	ifstream inputFile;
	ofstream outputFile;
	vector<int> salesRecords;
public:
	void loadDataFromFile(string filename);
	void saveBarChartToFile(string filename);
};

void SalesData::loadDataFromFile(string filename)
{
	int salesData = 0;

	salesRecords.clear(); // Clear out old data
	inputFile.open(filename); // Open input file

	if (!inputFile) //Does file exist
	{
		cout << "Error: File not found!" << endl;
		return;
	}

	while (inputFile)
	{
		inputFile >> salesData; // Read data from file
		salesRecords.push_back(salesData); // Save data to vector 
	}

	inputFile.close();
}

void SalesData::saveBarChartToFile(string filename)
{
	int storeNum = 0;

	if (salesRecords.size() == 0)
	{
		cout << "Error: No sales data available!" << endl;
		return;
	}

	outputFile.open(filename); 
	outputFile << "SALES BAR CHART" << endl
		<< "(each * equals £100)" << endl;

	if (!outputFile) // Does file exist
	{
		cout << "Error: File not found" << endl;
		return;
	}

	for (unsigned int i = 0; i <= salesRecords.size(); i++)
	{
		int graphStars = salesRecords[i] / 100;
		for (int j = 0; j < graphStars; j++)
			outputFile << "*";
		outputFile << endl;
	}

	outputFile.close();
}

int main()
{
	SalesData sales;
	string input = "F:\\My Documents\\Visual Studio 2015\\Projects\\OOPExercises\\OOPExercises\\sales.txt";
	string output = "F:\\My Documents\\Visual Studio 2015\\Projects\\OOPExercises\\OOPExercises\\graph.txt";

	sales.loadDataFromFile(input);
	sales.saveBarChartToFile(output);

	return 0; 
}