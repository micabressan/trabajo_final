
bool searchkernel();
bool search(int value, int values[], int n)
{
    // TODO: implement a searching algorithm
	while (n >0)
	searchkernel(value, values, 0,n-1);
	return false;
}




bool searchkernel(int value, int values[],int lowerbound, int upperbound)
{	if (lowerbound > upperbound)
	return false;
	else 
	{
		int midpoint = round((lowerbound + upperbound)/2);
		int mid_val = values[midpoint];
		bool left = (value < mid_val);
		bool right = (value > mid_val);
		if (left) searchkernel(value, values, lowerbound, (midpoint-1));
		if (right) 
		   searchkernel(value, values, (midpoint + 1), upperbound);
		else return mid_val;
	}
	return false;
}