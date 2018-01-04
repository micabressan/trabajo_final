public void Setup() {
    Serial.begin(9600);
    Loop();
}

private void Loop() {
    if (IsChristmas() == true)
    {
      Serial.println("Take it easy, and don't be a cunt"); // LOL haha
    }
    else
    {
      Serial.println("Just another day");
    }
}

bool IsChristmas() {
	int currentDate = 26122017;
    if (currentDate == 25122017)
    {
        return true;
    }

    return false;
}