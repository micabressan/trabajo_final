import org.junit.Test

class Asdf {

    private String testInput

    void runTests() {
        Scanner input = new Scanner(System.in)
        println "Please insert some value"
        testInput = input.nextLine()
        println testInput
        "hello there tests"()
    }

    @Test
    void "hello there tests"() {
        assert "boi" == testInput
    }


}