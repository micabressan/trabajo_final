            case "NICK":
            {
                string new_nick = recvd[2][1..$];
                string old_nick = recvd[0].split("!")[0][1 .. $];

                foreach (string channel, string[] list; users)
                {
                    for (int i = 0; i < list.length; i++)
                    {
                        string nick = list[i];
                        if (nick == old_nick)
                        {
                            list[i] = new_nick;
                            break;
                        }
                    }
                }

                break;
            }