public void Setup() {
    Serial.begin(9600);
    Loop();
}

private void Loop() {
    if (IsChristmas())
    {
		Serial.println("Take it easy, and don't be a cunt"); // LOL haha
    }
    else
    {
		Serial.println("Just another day");
    }
}

private bool IsChristmas() {
	int currentDate = 26122017;
    return currentDate == 25122017;
}