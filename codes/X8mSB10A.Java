
public class ClassAllocation
{
	//basic variables
	boolean fullAllocation = false;
	boolean firstAllocCycle = false;
	int assignedClassInstances = 0;
	int totalInstanceHours = 0;
	int totalWorkHours = 0;
	float avgHoursNeeded;
	
	//temp/test variables
	//String tempName;
	int tempDay, tempT1, tempT2, tempType;
	int[] timeData1 = new int[3];
	int[] timeData2 = new int[6];
	
	//more temp/test variables
	boolean lengthCheck = true;
	boolean subjectCheck = true;
	boolean timeDataCheck = true;
	boolean prefsCheck = true;
	
	//ArrayList variables
	ArrayList<Subject> subArray; // Incorrect ?
	ArrayList<Teacher> teachArray; // ?
	//ArrayList<SubjectClass>; // ?
	ArrayList<ClassInstance> classInstances = new ArrayList<ClassInstance>(); // ?
	ArrayList<ScheduleInstance> scheduleInstances = new ArrayList<ScheduleInstance>(); // ?
	
	//constructor
	public ClassAllocation(ArrayList<Subject> newSubArray, ArrayList<Teacher> newTeachArray) // ?
	{
		subArray = newSubArray; // ?
		teachArray = newTeachArray; // ?
	}
	
	//non-void methods
	public String attemptAllocation()
	{
		//1) fill classInstances with new ClassInstance objects
		int numSubjects = subArray.getSize();
		for(int i=0; i<numSubjects; i++) //iterate once per subject
		{
			int tempCounter;
			int[] tempClassNums = (subArray.get(i)).getClassNums();
			int tempLectures = tempClassNums[0];
			int tempTutorials = tempClassNums[1];
			int tempLabs = tempClassNums[2];
			String tempName = (subArray.get(i)).getName();
			ArrayList<SubjectClass> tempClassesArray = (subArray.get(i)).getClassesArray();
			int tempNumClasses = tempClassesArray.getSize();
			for (int j=0; j<tempLectures; j++) //iterate once per lecture
			{
				timeData1[0] = (tempClassesArray.get(j)).getDay();
				timeData1[1] = (tempClassesArray.get(j)).getT1();
				timeData1[2] = (tempClassesArray.get(j)).getT2();
				tempType = 0;
				classInstances.add(new ClassInstance(tempName, tempType, timeData1));
				tempCounter = j;
			}
			if (tempTutorials == 0) //if the subject has no tutorials
			{
				for (int k=tempCounter; k<(tempLabs+tempCounter); k++) //iterate lab
				{
					timeData1[0] = (tempClassesArray.get(k)).getDay();
					timeData1[1] = (tempClassesArray.get(k)).getT1();
					timeData1[2] = (tempClassesArray.get(k)).getT2();
					tempType = 1;
					classInstances.add(new ClassInstance(tempName, tempType, timeData1));
				}
			}
			else //if the subject has tutorials
			{
				for (int k=tempCounter; k<tempTutorials; k++) //iterate once per tutorial + lab combo
				{
					timeData2[0] = (tempClassesArray.get(k)).getDay();
					timeData2[1] = (tempClassesArray.get(k)).getT1();
					timeData2[2] = (tempClassesArray.get(k)).getT2();
					timeData2[3] = (tempClassesArray.get(k+tempCounter)).getDay();
					timeData2[4] = (tempClassesArray.get(k+tempCounter)).getT1();
					timeData2[5] = (tempClassesArray.get(k+tempCounter)).getT2();
					tempType = 2;
					classInstances.add(new ClassInstance(tempName, tempType, timeData2));
				}
			}
		}
		//2) fill scheduleInstances with new scheduleInstance objects
		int numTeachers = teachArray.getSize();
		for (int i=0; i<numTeachers; i++) //iterate once per teacher
		{
			String tempName = (teachArray.get(i)).getName();
			int tempHours = (teachArray.get(i)).getHours();
			totalWorkHours += tempHours;
			scheduleInstances.add(new ScheduleInstance(tempName, tempHours));
		}
		//3) Calculate total instance hours and avgHoursNeeded
		for (int i=0; i<(classInstances.getSize()); i++) //iterate once per classInstance object
		{
			int tempType = (classInstances.get(i)).getType();
			int[] tempTimeData = (classInstances.get(i)).getTimeData();
			if (tempType == 2)
			{
				totalInstanceHours += ((tempTimeData[2]-tempTimeData[1]) + (tempTimeData[4]-tempTimeData[5]));
			}
			else
			{
				totalInstanceHours += ((tempTimeData[2]-tempTimeData[1]);
			}
		}
		avgHoursNeeded = (float)totalInstanceHours / numTeachers;
		//4) Check if fullAllocation is true
		if (totalInstanceHours > totalWorkHours)
		{
			fullAllocation = true;
		}
		//5) Attempt allocation
		for (int i=0; i<numTeachers; i++) //iterate once per teacher
		{
			ArrayList<String> schInstSubjects = (scheduleInstances.get(i)).getTeacherSubjects();
			/* if (fullAllocation == true)
			{
				for (j=(scheduleInstances.get(i)).getHoursLeft(); j>1; j--) //iterate once per classInstance
				{
					for (k=0; k<(classInstances.getSize()); k++)
					{
						
						int[] tempTimeData2 = (classInstances.get(k)).getTimeData();
						if ((classInstances.get(k).)
					}
				}
			} DO THIS LATER! */
			//else
			if (firstAllocCycle == true)
			{
				int yetAnotherTemp = (teachArray.get(i)).getHours();
				if (yetAnotherTemp <= avgHoursNeeded) //in this case every hour is used
				{
					for (int j=(scheduleInstances.get(i)).getHoursLeft(); j>1; j--) //iterate once per classInstance
					{
						for (int k=0; k<(classInstances.getSize()); k++)
						{
							int classLength;
							String instanceSubject = (classInstances.get(k)).getSubject();
							int[] tempTimeData2 = (classInstances.get(k)).getTimeData();
							int classInstanceType = (classInstances.get(k)).getType();
							
							if (classInstanceType == 2)
							{
								classLength = ((tempTimeData2[2]-tempTimeData2[1]) + (tempTimeData2[4]-tempTimeData2[5]));
							}
							else
							{
								classLength = ((tempTimeData2[2]-tempTimeData2[1]);
							}
							if (classLength > j) //check 1
							{
								lengthCheck = false;
							}
							for (int l=0; l<(schInstSubjects.getSize()); l++) //check 2
							{
								if (schInstSubjects.get(l).equals())
							}
						}
					}
				}
				else
				{
					
				}
			}
			
		}
	}
	public void resetChecks()
	{
		lengthCheck = true;
		subjectCheck = true;
		timeDataCheck = true;
		prefsCheck = true;
	}
}