#pragma once
#include <vector>
#include "coordinates.h"

using namespace std;
class FormData
{
public:
	static const FormData& Instance()
	{
		static FormData theSingleInstance;
		return theSingleInstance;
	}
private:
	vector<coordinates_of_the_point> coordinates;
};