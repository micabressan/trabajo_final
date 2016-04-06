String string = "Wed Aug 19 15:49:10 CEST 2015";
                DateFormat format = new SimpleDateFormat("EEE MMM dd HH:mm:ss zzz yyyy", Locale.ENGLISH);
                Date date = format.parse(string);
                System.out.println(date); // Sat Jan 02 00:00:00 GMT 2010