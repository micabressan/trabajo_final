@Test
    void switchICM(){
        // Get current database time
        db.query("SELECT DATEDIFF(s, '1970-01-01 00:00:00', GETUTCDATE())")
        long now = Long.parseLong(db.getResults().get(0))

        // Stop both ICMs
        stopLittleHorseProxy("icm1")
        stopLittleHorseProxy("icm2")


        final List<String> results = new ArrayList<>()

        long delta = System.currentTimeMillis() / 1000
        while (results.size() < 4 && (System.currentTimeMillis() / 1000 - delta) <= TIMEOUT) {
            db.query(" SELECT ID, EVENT, TIMESTAMP, DETAIL_MESSAGE \n" +
                    "  FROM SYSTEM_EVENT_LOG \n" +
                    "  WHERE EVENT = 29 and TIMESTAMP / 1000 >= " + now + " \n" +
                    "  order by TIMESTAMP desc")
            results.addAll(db.getResults())
            Thread.sleep(500)
        }

        assert results.size() == 4

        println "test"

        startLittleHorseProxy("icm1")
        startLittleHorseProxy("icm2")

        delta = System.currentTimeMillis() / 1000
        while (results.size() < 8 && (System.currentTimeMillis() / 1000 - delta) <= TIMEOUT) {
            db.query(" SELECT ID, EVENT, TIMESTAMP, DETAIL_MESSAGE \n" +
                    "  FROM SYSTEM_EVENT_LOG \n" +
                    "  WHERE EVENT = 28 and TIMESTAMP / 1000 >= " + now + " \n" +
                    "  order by TIMESTAMP desc")
            results.addAll(db.getResults())
            Thread.sleep(500)
        }

        assert results.size() == 8

        println "test"
    }