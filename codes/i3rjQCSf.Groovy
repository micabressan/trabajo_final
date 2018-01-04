import org.apache.commons.io.IOUtils
import com.atlassian.jira.component.ComponentAccessor
import org.apache.log4j.Logger


tempoApiToken = 'e4f41d78-f8e1-407a-9fba-ccafd2c83d86'
tempoDateFrom = '2000-01-01'
tempoDateTo = '2099-12-31'

tempo = new TempoTool(apiToken: tempoApiToken, baseUrl: requestContext.canonicalBaseUrl, dateFrom: tempoDateFrom, dateTo: tempoDateTo)

/**
 * Velocity tool to query Tempo worklogs from the Tempo Servlet API.
 *
 * @see https://tempoplugin.jira.com/wiki/display/TEMPO/Tempo+Servlet+Manual
 */
class TempoTool {
	def log = Logger.getLogger(this.getClass())

	/* Tempo servlet request parameters. */
	String apiToken
	String baseUrl
	String dateFrom
	String dateTo

	def slurper = new XmlSlurper()

	/**
	 * Returns the Tempo managed worklogs for the passed issue as a <code>List</code> of <code>Maps</code>, or the exception object if something went wrong.
	 * You can trivially iterate over the list and access the values by the keys visible in the "def m = ..." line. Ex: "hours", "work_date", etc.
	 */
	def getWorklogs(def issueKey) {
		log.debug("Downloading Tempo worklogs for ${issueKey}")
		InputStream stream

		try {
			// note: you can't filter by username (the Tempo API can filter either by issue key or by username, but not both)
			def url = "${baseUrl}/plugins/servlet/tempo-getWorklog/?issueKey=${issueKey}&dateFrom=${dateFrom}&dateTo=${dateTo}&format=xml&addBillingInfo=true&addUserDetails=true&tempoApiToken=${apiToken}"
			log.debug("Tempo URL for ${issueKey}: ${url}")
			stream = new URL(url).openStream()
			def xml = IOUtils.toString(stream, "UTF-8")
			log.debug("Tempo XML for ${issueKey}:\n${xml}")

			def result = slurper.parseText(xml)
			def worklogs = result.worklog
			log.debug("${worklogs.size()} Tempo worklogs found for ${issueKey}")

			// deserialize
			def worklogObjects = []
			result.worklog.each { w ->
				def m = [ hours: w.hours.toDouble(), work_date: Date.parse("yyyy-MM-dd",  w.work_date as String), username: w.username, billing_key: w.billing_key, work_description: w.work_description, full_name: w.user_details.full_name, billing_name: w.Billing.@name, activity_name: w.activity_name ]
				worklogObjects.add(m)
			}
			log.debug("Worklogs for ${issueKey}: ${worklogObjects}")

			return worklogObjects
		} catch(Throwable ex) {
			log.error('Failed to download Tempo worklogs', ex)
			def failureMessage = "Failed to download Tempo worklogs (have you enabled the Tempo API?): ${ex.message}"
			return [
					[ hours: "", work_date: "", username: "", billing_key: "", work_description: failureMessage, full_name: "", billing_name: "", activity_name: "" ]
			]
		} finally {
			IOUtils.closeQuietly(stream)
		}
	}
}