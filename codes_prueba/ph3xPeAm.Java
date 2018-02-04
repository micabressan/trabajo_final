import java.util.Scanner;

public class Tax3
{
	enum reb_ages {PRIMARY, SECONDARY, TERTIARY}
	private final int P_REB;
	private final int S_REB;
	private final int T_REB;
	
	public static Scanner input = new Scanner(System.in);
	private int salary;
	private int an_income;
	private int age;
	Save3 savings;

	public Tax3()
	{
		P_REB = 13257;	
		S_REB = 13257 + 7407;
		T_REB = 13257 + 7407 + 2466;
		an_income = 0;
		age = 0;
		
	}
	

	public int getPreb()
	{
		return this.P_REB;
	}
	
	public int getSreb()
	{
		return this.S_REB;
	} 

	public int getTreb()
	{
		return this.T_REB;
	} 

	private void setSalary(int salary)
	{
		this.salary = salary;
	}

	public int getSalary()
	{
		return this.salary;
	}

	private void setAnsalary(int an_salary)
	{
		this.an_income = an_salary;
	}

	public int getAnsalary()
	{
		return this.an_income;
	}

	private void setAge(int age)
	{
		this.age = age;
	}

	public int getAge()
	{
		return this.age;
	}
	
	
	public int parseToInt(String cost)
	{
		return Integer.parseInt(cost);
	}

	public void inputTax() 
	{
		System.out.print("Enter monthly salary: "); //prompting input.
		setSalary(parseToInt(Util.stripR(input.next())));//run set method for salary.
		setAnsalary(getSalary()*12); // setting annual income from monthly salary.
		System.out.print("Enter age: "); 
		setAge(input.nextInt());
		getRebate(getAge());//goes to rebate method to get rebate.
	}
	
	
	private void getRebate(int age)
	{
		int user_age = getAge();
		reb_ages reb_level = (user_age>=75)?reb_ages.TERTIARY:(user_age>=65)?reb_ages.SECONDARY:reb_ages.PRIMARY; //determining the age bracket of the user.
		int annual_sal = getAnsalary();
		switch(reb_level) 
		{
			case PRIMARY: //the first age bracket.
				if(annual_sal<=73650) //checking to see whether the annual income is greater than or equal to the given value.
				{
					System.out.print("No tax. Under threshold.\n"); 
					savings = new Save3();//create Savings object and call input method. 
				
				}
				else
				{
					calcTax(annual_sal, getPreb()); //continues to the calculation.
				}
				
				break;
			case SECONDARY:
				if(annual_sal<=114800)
				{
					System.out.print("No tax. Under threshold.\n");
					savings = new Save3();
				
				}
				else
				{
					calcTax(annual_sal, getSreb());
				}
				break;
			case TERTIARY:
				if(annual_sal<=128500)
				{
					System.out.print("No tax. Under threshold.\n");
					 savings = new Save3();//skips to the savings input promps.
				
				}
				else
				{
					calcTax(annual_sal, getTreb());
				}
				break;
		
		}
		
	}
	
	public void calcTax(int income, int rebate) //Calculates tax 
	{
		int base_value = 0; 
		double rate = 0;     
		int fixed_amount = 0;
		if(income>=701301) // checking whether the annual income is greater than the given number.
		{
			base_value = 701300; // the base value is set to the lower limit of the class bing used.
			rate = 0.41; //the tax rate.
			fixed_amount = 208587;	//the amount of tax to be added to the total tax.
		}
		if(income>=550101 && base_value == 0)// performs previous check and determines whether the base_value is still zero.If it is still zero it means no 

previous tax bracket conditions have accidently been applied to the annual income.
		{
			base_value = 550100;  
			rate = 0.39;
			fixed_amount = 149619;	
		}
		if(income>=393201 && base_value == 0)
		{
			base_value = 393200;
			rate = 0.36;
			fixed_amount = 93135;	
		}
		if(income>=284101 && base_value == 0)
		{
			base_value = 284100;
			rate = 0.31;
			fixed_amount = 59314;	
		}		

		if(income>=181901 && base_value == 0)
		{
			base_value = 181900;
			rate = 0.26;
			fixed_amount = 32742;	
		}
		if(income<=181900 && base_value == 0)
		{
			rate = 0.18;	
		}
		double tax = ((getAnsalary()-base_value)*rate) + fixed_amount; //the base value is subtracted from the anual income. The answer obtained here is 

multiplied by the pretermined rate, and thereafter the fixed amount is added to the tax.
		tax -= rebate;
		outputTax(tax);
		
	}

	public void outputTax(double tax) //outputs the tax information.
	{
		int an_sal = getAnsalary();
		System.out.printf("%s%d %s%.2f %s %d%s %n", "Tax for annual salary of R" , an_sal, "is R",tax, "which is net", (int)((tax/an_sal)*100),"%");// the 

display is formatted so that tax is given as a 2 decimal point value.
		savings = new Save3();//calls savings input
		
	}

}