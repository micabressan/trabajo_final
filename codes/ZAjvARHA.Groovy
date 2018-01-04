import com.atlassian.jira.bc.issue.search.SearchService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.web.bean.PagerFilter

def issueManager = ComponentAccessor.issueManager
def customFieldManager = ComponentAccessor.customFieldManager
def searchService = ComponentAccessor.getComponent(SearchService.class)
def loggedInUser = ComponentAccessor.getJiraAuthenticationContext().getUser()

def jqlSearch = "\"CEDVU Id\" ~ FEDORA"

def issues = null

SearchService.ParseResult parseResult = searchService.parseQuery(loggedInUser, jqlSearch)
if (parseResult.isValid()) {
    def searchResult = searchService.search(loggedInUser, parseResult.getQuery(), PagerFilter.getUnlimitedFilter())
    issues = searchResult.issues.collect { issueManager.getIssueObject(it.id) }
} else {
    return "Invalid JQL: " + jqlSearch
}

return issues.size()