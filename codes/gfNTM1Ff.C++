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
	FormData(){}
	FormData(const FormData& root);
	FormData& operator=(const FormData&);
	vector<coordinates_of_the_point> coordinates;
};