def getVersionName = { ->
    def stdout = new ByteArrayOutputStream()
    exec {
        commandLine 'git', 'describe', '--tags', '--always', '--abbrev=0'
        standardOutput = stdout
    }
    return stdout.toString().trim()
}