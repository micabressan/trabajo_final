/********************************************************************** 
  Required Results: 
  Develop an application to calculate & print a weekly payroll report. 
  Display formatted computed values for: gross pay, tax, union dues  
  and net pay. modulize program. 
  
*********************************************************************/ 
#include <iostream.h> 
#include <iomanip.h> 
 
int      main() 
 
{ 
//prototypes 
	void funcTotalsOutPut    (double, double, double); 
	char funcAddmore         (); 
	void funcOutPut          (double, double, double,  
							  double, double, double,  
							  double, double); 
	double funcTotalEmployees(double); 
	double funcTotalGrossPay (double, double); 
	double funcTotalNetPay   (double, double); 
	double funcIdNumber      (); 
	double funcRegularPay    (double,double); 
	double funcOvertimePay   (double,double); 
	double funcGrossPay      (double,double); 
	double funcStateTax      (double); 
	double funcFederalTax    (double); 
	double funcTotalTax      (double,double); 
	double funcUnionDues     (char); 
	double funcHoursWorked   (); 
	double funcPayRate       (); 
	double funcNetPay        (double,double,double); 
	char   funcUnionCode     (); 
	char   funcPayCode       (); 
	int    funcElementFinder (int); 
	double arrHoursWorked[6] = {40.0, 50.0, 30.0, 40.0, 20.5, 15.0}; 
	double arrPayRate[6] = {14.5, 10.0, 25.75, 30.0, 40.0, 50.0}; 
	char    arrUnionCode[6] = {3, 2, 1, 1, 3, 3}; 
	 
//main variables 
	double grossPay, stateTax, federalTax, totalTax, unionDues, netPay, regularPay, 
	       overtimePay=0, totalGrossPay=0,totalEmployees=0,totalNetPay=0,hoursWorked, 
		   payRate; 
	int    idNumber, element; 
	char   payCode, addmore, unionCode; 
	 
	do 
	{ 
 
//prompt user for input 
	                idNumber=funcIdNumber(); 
//get array element 
		element=funcElementFinder(idNumber); 
		payCode=funcPayCode(); 
//		hoursWorked=funcHoursWorked(); 
		hoursWorked=arrHoursWorked[element]; 
//		payRate=funcPayRate(); 
		payRate=arrPayRate[element]; 
//		unionCode=funcUnionCode(); 
		unionCode=arrUnionCode[element]; 
//call hours worked functions 
		if (hoursWorked>40) 
		{ 
			regularPay=funcRegularPay(payRate,hoursWorked); 
			overtimePay=funcOvertimePay(hoursWorked,payRate); 
		} 
		else regularPay=funcRegularPay(payRate,hoursWorked); 
		grossPay=funcGrossPay(regularPay,overtimePay); 
//call tax functions 
		stateTax=funcStateTax(grossPay); 
		federalTax=funcFederalTax(grossPay); 
		totalTax=funcTotalTax(federalTax,stateTax); 
//call unionDues function 
	    unionDues=funcUnionDues(unionCode); 
//call net pay function 
        netPay=funcNetPay(grossPay,totalTax,unionDues); 
//call output function 
		funcOutPut(regularPay, overtimePay, grossPay, stateTax,  
		federalTax, totalTax, unionDues, netPay); 
//call count functions 
		totalEmployees=funcTotalEmployees(totalEmployees); 
		totalGrossPay=funcTotalGrossPay(totalGrossPay, grossPay); 
		totalNetPay=funcTotalNetPay(totalNetPay, netPay); 
//call add usr function 
		addmore=funcAddmore(); 
		} 
	while (addmore == 'y' || addmore == 'Y'); 
//call totals output 
	funcTotalsOutPut(totalEmployees, totalGrossPay, totalNetPay); 
	return 0; 
} 
//----------------------------------------------------- 
//element finder function 
int funcElementFinder(int idNumber) 
{ 
    int arrIdNumber[6] = {205, 123, 412, 602, 173, 100}; 
	int element = -1, x; 
    for(x=0; x < 6; x++) 
	{ 
		if (arrIdNumber[x] == idNumber) 
			element = x; 
	} 
	return element; 
} 
	 
 
//idnumber function 
double funcIdNumber() 
{ 
	double idNumber; 
	cout << "\nEnter ID Number (100-800) : "; 
	cin >>idNumber; 
	while ((idNumber < 100) || (idNumber > 800)) 
	{ 
		cout << "Invalid ID Number.\n"; 
		cout << "Enter ID Number (100-800) : "; 
		cin >> idNumber; 
	} 
	return idNumber; 
} 
//paycode function 
char funcPayCode() 
{ 
	char payCode; 
	cout << "Enter Payroll Code (H,h) : "; 
	cin >> payCode; 
	while (payCode != 'h' && payCode != 'H') 
	{ 
		cout << "Invalid payroll code."; 
		cout << "\nEnter Payroll Code (H,h) : "; 
		cin >> payCode; 
	} 
	return payCode; 
} 
//hours worked function 
double funcHoursWorked() 
{ 
	double hoursWorked; 
	cout << "Enter Total Hours Worked (0-65.5) : "; 
	cin >> hoursWorked; 
	if ((hoursWorked < 0) || (hoursWorked > 65.5)) 
	{ 
		do 
		{ 
			cout << "Invalid amount."; 
			cout << "\nEnter Total Hours Worked (0-65.5) : "; 
			cin >> hoursWorked; 
		} 
		while ((hoursWorked < 0) || (hoursWorked > 65.5)); 
	} 
	return hoursWorked; 
} 
//payrate function 
double funcPayRate() 
{ 
	double payRate; 
	cout << "Enter Regular Hourly Payrate (8.5-45) : "; 
	cin >> payRate; 
	if ((payRate < 8.5) || (payRate > 45)) 
	{ 
		do 
		{ 
			cout << "Invalid amount."; 
			cout << "\nEnter Regular Hourly Payrate (8.5-45) : "; 
			cin >> payRate; 
		} 
		while ((payRate < 8.5) || (payRate > 45)); 
	} 
	return payRate; 
} 
//union code function 
char funcUnionCode() 
{ 
	char unionCode; 
	cout << "Enter Union Code (1-3) : "; 
	cin >> unionCode; 
	if ((unionCode != '1') && (unionCode != '2') && (unionCode != '3')) 
	{ 
		do 
		{ 
			cout << "Invalid Union Code."; 
			cout << "\nEnter Union Code (1-3) : "; 
			cin >> unionCode; 
		} 
		while ((unionCode != '1') && (unionCode != '2') && (unionCode != '3')); 
	} 
	return unionCode; 
} 
//calculate pay + overtime pay 
double funcRegularPay(double payRate,double hoursWorked) 
{ 
	double regularPay; 
	regularPay = payRate * hoursWorked; 
	return regularPay; 
} 
double funcOvertimePay(double hoursWorked,double payRate) 
{ 
	double overtimePay; 
	overtimePay = (hoursWorked-40) * payRate * 1.5; 
	return overtimePay; 
} 
double funcGrossPay(double regularPay,double overtimePay) 
{ 
	double grossPay; 
	grossPay = regularPay + overtimePay; 
	return grossPay; 
} 
double funcNetPay(double grossPay,double totalTax,double unionDues) 
{ 
	double netPay; 
	netPay = grossPay - (totalTax + unionDues); 
	return netPay; 
} 
//tax functions 
double funcStateTax(double grossPay) 
{ 
	double stateTax; 
	if (grossPay > 1000) 
		stateTax = .05 * grossPay; 
	else if (grossPay > 500) 
		stateTax = .03 * grossPay; 
	else stateTax = 0; 
	return stateTax; 
} 
double funcFederalTax(double grossPay) 
{ 
	double federalTax; 
	if (grossPay > 1000) 
		federalTax = .07 * grossPay; 
	else if (grossPay > 500) 
		federalTax = .05 * grossPay; 
	else  
		federalTax = 0; 
	return federalTax; 
} 
double funcTotalTax(double stateTax,double federalTax) 
{ 
	double totalTax; 
	totalTax = stateTax + federalTax; 
	return totalTax; 
} 
//union dues function 
double funcUnionDues(char unionCode) 
{ 
	double unionDues; 
	switch (unionCode) 
	{ 
	case '1': 
			unionDues = 15.0; 
			break; 
	case '2': 
			unionDues = 25.0; 
			break; 
	case '3': 
			unionDues = 35.0; 
			break; 
	} 
	return unionDues; 
} 
//output function 
void funcOutPut(double regularPay, double overtimePay, double grossPay,  
		        double stateTax,   double federalTax,  double totalTax,  
		        double unionDues,  double netPay) 
{ 
	cout << setiosflags(ios::fixed) 
         << setiosflags(ios::showpoint) 
         << setprecision(2); 
	cout << "\nRegular Pay    $"<< setw(8) << regularPay  << endl; 
    cout << "Overtime Pay   $"  << setw(8) << overtimePay << endl; 
    cout << "Gross Pay      $"  << setw(8) << grossPay    << endl;  
    cout << "\nState Tax      $"<< setw(8) << stateTax    << endl; 
    cout << "Federal Tax    $"  << setw(8) << federalTax  << endl; 
    cout << "Total Tax      $"  << setw(8) << totalTax    << endl; 
    cout << "\nUnion Dues     $"<< setw(8) << unionDues   << endl; 
    cout << "Net Pay        $"  << setw(8) << netPay      << endl; 
} 
double funcTotalEmployees(double totalEmployees) 
{ 
	totalEmployees = totalEmployees + 1; 
return totalEmployees; 
} 
double funcTotalGrossPay(double totalGrossPay, double grossPay) 
{ 
	totalGrossPay = totalGrossPay + grossPay; 
	return totalGrossPay; 
} 
double funcTotalNetPay(double totalNetPay, double netPay) 
{ 
	totalNetPay = totalNetPay + netPay; 
	return totalNetPay; 
} 
//add more users function 
char funcAddmore() 
{ 
	char addmore; 
	cout << "\nCalculate another salary?"; 
    cout << "\n'Y' for yes; any other key for no : "; 
    cin  >> addmore; 
	return addmore; 
} 
//totals output function 
void funcTotalsOutPut(double totalEmployees, double totalGrossPay, double totalNetPay) 
{ 
    cout << "\n\nTotal Number of Employees " << setw(8) << totalEmployees << endl; 
    cout << "Total Gross Pay            $"   << setw(8) << totalGrossPay << endl; 
    cout << "Total Net Pay              $"   << setw(8) << totalNetPay << endl; 
    cout << "Average Gross Pay          $"   << setw(8) << (totalGrossPay / totalEmployees) << endl; 
    cout << "Average Net Pay            $"   << setw(8) << (totalNetPay / totalEmployees) << endl; 
}