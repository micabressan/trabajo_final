package net.gmc.nuc.tests.configuration

import net.gmc.nuc.tools.db.DatabaseUtil
import net.gmc.nuc.tools.traits.LittleHorseProxyTrait
import net.gmc.nuc.tools.traits.NucleusClientTrait
import net.gmc.util.com.ThreadSleep
import org.junit.After
import org.junit.Test

import static net.gmc.util.com.time.Cal.SECOND

/**
 * @author m.horcicko
 * @since 13. 11. 2017
 */

class NU_5273_EventLogIcmIpsDBTest implements LittleHorseProxyTrait, NucleusClientTrait {

    static final int TIMEOUT = 15
    static final int EVENT_IPS_STARTED = 24
    static final int EVENT_IPS_STOPPED = 25
    static final int EVENT_ICM_STARTED = 28
    static final int EVENT_ICM_STOPPED = 29
    static final String IPS = "ips1"
    static final String MAIN_ICM = "icm1"
    static final String BACKUP_ICM = "icm2"

    DatabaseUtil db = new DatabaseUtil(null)
    List<String> results = new ArrayList<>()
    long currentDatabaseTime


    @Test
    void "When Ips is turned off and on, events are written into eventLog"() {
        // given
        selectCurrentDatabaseTime()

        // when
        stopLittleHorseProxy(IPS)
        forceScalerToCheckIpsState()

        // then
        assertEventInEventLog(EVENT_IPS_STOPPED)

        // when
        startLittleHorseProxy(IPS)
        forceScalerToCheckIpsState()

        // then
        assertEventInEventLog(EVENT_IPS_STARTED)
    }

    @Test
    void switchICM() {//todo name
        // given
        selectCurrentDatabaseTime()

        // when
        stopLittleHorseProxy(MAIN_ICM)
        stopLittleHorseProxy(BACKUP_ICM)

        // then
        assertEventInEventLog(EVENT_ICM_STOPPED)

        // when
        startLittleHorseProxy(MAIN_ICM)
        startLittleHorseProxy(BACKUP_ICM)

        // then
        assertEventInEventLog(EVENT_ICM_STARTED)
    }

    void assertEventInEventLog(int event) {
        String databaseEvent = getEventFromDatabase(currentDatabaseTime, event)
        assert databaseEvent == event.toString()
    }

    void forceScalerToCheckIpsState() {
        nucleusClient.submitJobAndReadResponseBody("default", "{}")
    }

    String getEventFromDatabase(long fromTime, int eventId) {
        String dbEvent = "No event obtained"
        ThreadSleep.waitUntilCondition({
            db.query("""SELECT EVENT 
                FROM SYSTEM_EVENT_LOG
                WHERE EVENT = $eventId and TIMESTAMP / 1000 >= $fromTime 
                order by TIMESTAMP desc
                """)
            results = db.getResults()
            if (results.size() > 1) {
                throw new IllegalStateException("Only one event was expected by test, but obtained events: $results")
            }
            if (results.isEmpty()) {
                return false
            } else {
                dbEvent = results[0]
                return true
            }
        }, 500, TIMEOUT * SECOND)
        return dbEvent
    }

    void selectCurrentDatabaseTime() {
        db.query("SELECT DATEDIFF(s, '1970-01-01 00:00:00', GETUTCDATE())")
        currentDatabaseTime = Long.parseLong(db.getResults().get(0))
    }

    @After
    void cleanup() {
        startLittleHorseProxy(IPS)
        startLittleHorseProxy(MAIN_ICM)
        startLittleHorseProxy(BACKUP_ICM)
    }

}