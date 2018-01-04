def matcher = (params.pr =~ /https:\/\/github.com\/VirtualInstruments\/(?<repo>[\w-]+)\/pull\/(?<pr>\d+).*/)
if (!matcher.matches()) {
    echo "Cannot extract the repository name and pull request number from PR parameter value: ${params.pr}"
    manager.buildFailure()
    return
}
def repo = matcher.group('repo')
def pr = matcher.group('pr')
echo "Extracted repo: ${repo} Pull request: ${pr}"
matcher = null
node('docker') {
    checkout changelog: false, poll: false, 
        scm: [
            $class: 'GitSCM', branches: [[name: "pr/${pr}/head"]], 
            doGenerateSubmoduleConfigurations: false, 
            extensions: [[$class: 'CleanBeforeCheckout']], 
            submoduleCfg: [], 
            userRemoteConfigs: [[
                credentialsId: "my-credentials", 
                url: "https://github.com/CompanyName/${repo}.git",
                name: 'origin', 
                refspec: '+refs/pull/*:refs/remotes/origin/pr/*'
            ]]
        ]
}