import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.search.SearchProvider
import com.atlassian.jira.jql.builder.JqlQueryBuilder
import com.atlassian.jira.web.bean.PagerFilter
import org.apache.log4j.Logger
import com.atlassian.jira.issue.Issue

def cfm = ComponentAccessor.customFieldManager
def sp = ComponentAccessor.getComponent(SearchProvider.class)
def is = ComponentAccessor.issueService
def um = ComponentAccessor.userManager

final String EMPLOYMENT_TYPE = "Employment"

final String ONBOARDING_STATUS = "Onboarding"
final String FIRST_YEAR_STATUS = "1. Year"
final String UNLIMITED_STATUS = "Unlimited"
final String ADMINISTRATION_STATUS = "Administration"

int ONBOARDING_ACTION = 11
int START_FIRST_YEAR_ACTION = 21
int START_UNLIMITED = 31

def cfFirstYearDate = cfm.getCustomFieldObjectByName("Start 1. Year")
def cfStartDate = cfm.getCustomFieldObjectByName("Start Trial Period")
def cfUnlimitedEmployment = cfm.getCustomFieldObjectByName("Start Unlimited Employment")
def user = um.getUserByKey("automation")

def log = Logger.getLogger("com.onresolve.jira.groovy.groovyrunner")//add to logging and profiling

log.info("Groovy service 'Check Employee Time Periods Jira Service' started")

def transitIssue = { Issue issue, int actionId, String newStatusName ->
    def validation = is.validateTransition(user, issue.id, actionId, is.newIssueInputParameters())
    if (validation.valid) {
        is.transition(user, validation)
        log.info(issue.key + " going to status " + newStatusName)
    } else {
        log.error(validation.errorCollection.errorMessages)
    }
}

//onboarding issues
def whereClause = JqlQueryBuilder.newBuilder()
        .where()
        .sub()
        .issueType(EMPLOYMENT_TYPE)
        .and().status(ONBOARDING_STATUS)
        .and().customField(cfFirstYearDate.getIdAsLong()).isNotEmpty()
        .and().customField(cfFirstYearDate.getIdAsLong()).ltEq().functionNow()
        .endsub()

//first year issues
whereClause = whereClause.or()
        .sub()
        .issueType(EMPLOYMENT_TYPE)
        .and().status(FIRST_YEAR_STATUS)
        .and().customField(cfUnlimitedEmployment.getIdAsLong()).isNotEmpty()
        .and().customField(cfUnlimitedEmployment.getIdAsLong()).ltEq().functionNow()
        .endsub()

//administration issues
whereClause = whereClause.or()
        .sub()
        .issueType(EMPLOYMENT_TYPE)
        .and().status(ADMINISTRATION_STATUS)
        .and().customField(cfStartDate.getIdAsLong()).isNotEmpty()
        .and().customField(cfStartDate.getIdAsLong()).ltEq().functionNow()
        .endsub()

def issues = sp.search(whereClause.buildQuery(), user, PagerFilter.unlimitedFilter).issues

log.info("found " + (issues?.size ?: "0") + " issues for transition")

issues?.each { issue ->
    switch (issue.statusObject.name) {
        case ADMINISTRATION_STATUS:
            transitIssue(issue, ONBOARDING_ACTION, ONBOARDING_STATUS)
            break
        case ONBOARDING_STATUS:
            transitIssue(issue, START_FIRST_YEAR_ACTION, FIRST_YEAR_STATUS)
            break
        case FIRST_YEAR_STATUS:
            transitIssue(issue, START_UNLIMITED, UNLIMITED_STATUS)
            break
    }
}