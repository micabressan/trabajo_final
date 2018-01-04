public void setTeLaat(String dagnaam){
        String dag = dagnaam.toLowerCase(); //zonder hoofdletters
        if (aantalTeLaat.containsKey(dag)) {
            Integer temp = aantalTeLaat.get(dag); // eerst waarde van key vinden, dan met 1 verhogen, en dan vervangen
            temp++;
            aantalTeLaat.put(dag, temp);
        } else {
            System.out.println("Geef aub een geldige dagnaam in");
        }
    }