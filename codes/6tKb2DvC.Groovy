class Test {
    boolean test
    Test(boolean test) { this.test = test; }
    boolean isTest() {
        true
    }
}
def t = new Test(false)
println "test is ${t.test ? 'passed' : 'failed' }"