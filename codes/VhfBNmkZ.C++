#include <vector>
#include <cstring>
#include <iostream>
#include <string>

using namespace std;

struct Brace
{
	enum Type { Open, Closed };
	Type type;
	size_t pos;
	Brace(Type type, size_t pos)
	{
		this->type = type;
		this->pos = pos;
	}
};

string Calculate(string input);
vector<char> GetSigns(string input);
vector<long double> GetNumbers(string input);
vector<Brace> GetBraces(string input);
string Solve(string input);

int main()
{
	string input;
	cin >> input;
	cout << Calculate(input);

	getchar();
	getchar();

	return 0;
}

string Calculate(string input)
{
	vector<Brace> braces = GetBraces(input);

	while (!braces.empty())
	{
		for (size_t i = 0; i < braces.size() - 1; i++)
		{
			if (braces[i].type != braces[i + 1].type)
			{
				input.replace(braces[i].pos, braces[i + 1].pos - braces[i].pos + 1, Solve(input.substr(braces[i].pos + 1, braces[i + 1].pos - braces[i].pos - 1)));
				braces = GetBraces(input);
				break;
			}
		}
	}
	input = Solve(input);

	return input;
}

void GradeOneOps(std::vector<long double>& numbers, std::vector<char>& signs);
void GradeTwoOps(std::vector<long double>& numbers, std::vector<char>& signs);


string Solve(string input)
{
	vector<long double> numbers = GetNumbers(input);
	vector<char> signs = GetSigns(input);
	GradeTwoOps(numbers, signs);
	GradeOneOps(numbers, signs);

	long double numericResult = numbers[0];

	string result = to_string(numericResult);
	return result;
}

void GradeOneOps(std::vector<long double>& numbers, std::vector<char>& signs)
{
	for (unsigned i = 0; i < signs.size(); i++)
	{
		switch (signs[i])
		{
		case '+':
			numbers[i] += numbers[i + 1];
			numbers.erase(numbers.begin() + i + 1);
			signs.erase(signs.begin() + i);
			i--;
			break;
		case '-':
			numbers[i] -= numbers[i + 1];
			numbers.erase(numbers.begin() + i + 1);
			signs.erase(signs.begin() + i);
			i--;
			break;
		}
	}
}

void GradeTwoOps(std::vector<long double>& numbers, std::vector<char>& signs)
{
	for (unsigned i = 0; i < signs.size(); i++)
	{
		switch (signs[i])
		{
		case '*':
			numbers[i] *= numbers[i + 1];
			numbers.erase(numbers.begin() + i + 1);
			signs.erase(signs.begin() + i);
			i--;
			break;
		case '/':
			numbers[i] /= numbers[i + 1];
			numbers.erase(numbers.begin() + i + 1);
			signs.erase(signs.begin() + i);
			i--;
			break;
		}
	}
}

vector<Brace> GetBraces(string input)
{
	vector<Brace> braces;
	for (size_t i = 0; i < input.length(); i++)
	{
		if (input[i] == '(')
		{
			braces.push_back(Brace(Brace::Open, i));
		}
		else if (input[i] == ')')
		{
			braces.push_back(Brace(Brace::Closed, i));
		}
	}

	return braces;
}

bool IsSign(char c)
{
	return c == '+' || c == '-' || c == '*' || c == '/' || c == '=';
}

vector<char> GetSigns(string input)
{
	vector<char> signs;
	for (size_t i = 0; i < input.length(); i++)
	{
		if (IsSign(input[i]))
		{
			signs.push_back(input[i]);
		}
	}

	return signs;
}

vector<long double> GetNumbers(string input)
{
	vector<long double> numbers;
	string currentNumStr = "";
	for (size_t i = 0; i < input.length(); i++)
	{
		if (!IsSign(input[i]) && !(input[i] == '(' || input[i] == ')'))
		{
			currentNumStr += input[i];
		}
		else
		{
			numbers.push_back(stold(currentNumStr));
			currentNumStr = "";
		}
	}
	if (input[input.length() - 1] != '=')
	{
		numbers.push_back(stold(currentNumStr));
	}

	return numbers;
}