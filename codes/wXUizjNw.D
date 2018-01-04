            case "QUIT":
            {
                if (!logging) break;

                string user    = recvd[0].split("!")[0][1 .. $];
                string message = buf.split(recvd[1] ~ " :")[1];

                foreach (string channel, string[] list; users)
                {
                    for (int i = 0; i < list.length; i++)
                    {
                        string nick = list[i];
                        if (nick == user)
                        {
                            remove(list, nick);
                            logfiles[channel].writefln(
                                "%s * %s quit (%s)",
                                Clock.currTime().toSimpleString(),
                                nick,
                                message
                            );
                            break;
                        }
                    }
                }

                break;
            }