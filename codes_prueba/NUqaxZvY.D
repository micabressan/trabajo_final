void run()
{
    /* notify the user about starting the bot */
    writefln("Starting mainloop.");

    /* this will prevent from joining multiple times */
    bool joined = false;

    /* loop it baby! */
    for (;;)
    {
        /* try receiving */
        try
        {
            buf = irc.recv();
        }
        catch (Exception e)
        {
            /*
             * on fail, return from the
             * function and stop the loop
             */
            writeln("ERROR: ", e.msg);
            return;
        }

        /* let's ping in and if we're not yet joined, join. */
        if (std.string.indexOf(buf, "PING") > -1)
        {
            /* parse the buffer */
            string[] ping = buf.stripRight().split();
            irc.send("PONG " ~ ping[1]);

            /* join if not joined */
            if (!joined)
            {
                /* loop all channels to join */
                for (size_t i = 0; i < channels.length; i++)
                {
                    if (logging)
                    {
                        logfiles[channels[i]] = new File(
                            std.path.join(
                                "logs", addExt(channels[i], "txt")
                            ),
                            "a"
                        );
                        logfiles[channels[i]].writefln(
                            "*** BEGIN LOG - %s ***",
                            Clock.currTime().toSimpleString()
                        );
                    }

                    irc.join(channels[i]);

                    /* fill up the list */
                    irc.send("NAMES " ~ channels[i]);

                    string nbuf = "";
                    while (std.string.indexOf(
                        nbuf, "End of /NAMES list"
                    ) == -1)
                    {
                        nbuf ~= irc.recv();
                    }
                    nbuf = nbuf.split(":")[2];
                    users[channels[i]] = nbuf.split(" ");
                }

                /* lock it! */
                joined = true;
            }
        }

        /* rejoin if kicked. */
        if (std.string.indexOf(buf, "KICK") > -1
         && std.string.indexOf(buf, nick ~ " :" ~ nick) > -1)
        {
            writefln("KICKED: REJOINING.");
            irc.join(buf.split("KICK ")[1].split()[0]);
        }

        /* finally, parse the message we got. */
        string[] recvd = buf.split();

        /*
         * MODES:
         * :USER JOIN :#channel
         * :USER QUIT :msg
         * :USER PART #channel :msg
         * :USER PRIVMSG #channel :msg
         * :USER KICK #channel TARGET :msg
         * :USER MODE #channel MODES MASK
         * :USER NICK :NEWNICK
        */

        switch(recvd[1])
        {
            case "PRIVMSG":
            {
                writeln("INFO: Calling message handler ..");

                string channel = recvd[2];
                string user    = recvd[0].split("!")[0][1 .. $];
                string message = buf.split(recvd[2] ~ " :")[1];

                if (logging)
                {
                    logfiles[channel].writefln(
                        "%s <%s> %s",
                        Clock.currTime().toSimpleString(),
                        user,
                        message
                    );
                }

                bool r = lua.call_message_handler(channel, user, message);

                /* check for retval - quit if handler returns false */
                if (r) irc.quit();

                break;
            }
            case "JOIN":
            {
                if (!logging) break;

                string channel = recvd[2][1..$];
                string user    = recvd[0].split("!")[0][1 .. $];

                logfiles[channel].writefln(
                    "%s * %s joined %s",
                    Clock.currTime().toSimpleString(),
                    user,
                    channel
                );

                size_t len = users[channel].length;
                users[channel].length = len + 1;
                users[channel][len]   = user;

                break;
            }
            case "PART":
            {
                if (!logging) break;

                string channel = recvd[2];
                string user    = recvd[0].split("!")[0][1 .. $];
                string message = (recvd.length >= 4)
                    ? buf.split(recvd[2] ~ " :")[1]
                    : "";

                logfiles[channel].writefln(
                    "%s * %s left %s (%s)",
                    Clock.currTime().toSimpleString(),
                    user,
                    channel,
                    message
                );

                for (int i = 0; i < users[channel].length; i++)
                {
                    string nick = users[channel][i];
                    if (nick == user)
                    {
                        users[channel] = remove(users[channel], i);
                        break;
                    }
                }

                break;
            }
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
                            users[channel] = remove(list, i);
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
            case "KICK":
            {
                if (!logging) break;

                string channel = recvd[2];
                string op      = recvd[0].split("!")[0][1 .. $];
                string target  = recvd[3];
                string message = buf.split(recvd[3] ~ " :")[1];

                logfiles[channel].writefln(
                    "%s * %s kicked %s from %s (%s)",
                    Clock.currTime().toSimpleString(),
                    op,
                    target,
                    channel,
                    message
                );

                break;
            }
            case "MODE":
            {
                if (!logging || recvd.length <= 4) break;

                string channel = recvd[2];
                string op      = recvd[0].split("!")[0][1 .. $];
                string modes   = recvd[3];
                string mask    = buf.split(recvd[3] ~ " ")[1];

                logfiles[channel].writefln(
                    "%s * %s set mode %s to %s",
                    Clock.currTime().toSimpleString(),
                    op,
                    modes,
                    mask
                );

                break;
            }
            case "NICK":
            {
                string new_nick = recvd[2][1..$];
                string old_nick = recvd[0].split("!")[0][1 .. $];

                foreach (string channel, string[] list; users)
                {
                    for (int i = 0; i < list.length; i++)
                    {
                        if (list[i] == old_nick)
                        {
                            users[channel][i] = new_nick;
                            break;
                        }
                    }
                }

                break;
            }
            default: break;
        }
    }
}