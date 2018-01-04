import org.junit.Test
import static org.junit.Assert.*

class StringCalculatorTest {
  @Test
  void "una cadena vacía suma 0"() {
    def stringCalculator = new StringCalculator()
    def suma = stringCalculator.sumar('')
    assertEquals(0, suma)
  }

  @Test
  void "una cadena con un 1 suma 1"() {
    def stringCalculator = new StringCalculator()
    def suma = stringCalculator.sumar('1')
    assertEquals(1, suma)
  }
}