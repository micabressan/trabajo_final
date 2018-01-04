//class constructor
public MyClass(LinkedHashMap classVariables = null) {
    if(classVariables != null) {
        classVariables.each { 
            this[it.key] = it.value;
        }
    }
}