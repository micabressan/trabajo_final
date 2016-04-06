struct smsflood
{
	char* message = "";
	bool activate = false;
	int Timer = 0;
};
smsflood smsf = New smsflood();

void cmd_smsflood(char *params)
{
    traceLastFunc("cmd_smsflood()");
    if (!strlen(params))
		{
		if (smsf->activate)
			smsf->activate = false;
			else
			{
				addMessageToChatWindow("Введите: /smsflood <текст>");
				return;
			}
		}
	smsf->activate = true;
	smsf->message = params;
}

void Flood() //Вызывать из основного цикла
{
	if (smsf->activate && smsf->Timer < GetTickCount())
	{
		smsf->Timer = GetTickCount() + 30000;
        for(int i=0; i < SAMP_MAX_PLAYERS; i++)
            say("/sms %d %s", i, smsf->message);
	}
}