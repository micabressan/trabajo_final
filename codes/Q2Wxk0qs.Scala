package unit.model

import model.email.Email
import org.scalatestplus.play.PlaySpec

class EmailTest extends PlaySpec {

  final val EmailString: String = "valid@email.com"
  final val EmailTuple: (String, String) = "email" -> EmailString
  final val ValidEmail = new Email(EmailString)
  final val InvalidEmail = new Email("notanemail")

  "Email" must {
    "be validated as valid" in {
      ValidEmail.isValid mustBe true
    }

    "be validated as invalid" in {
      InvalidEmail.isValid mustBe false
    }

    "throw IllegalArgumentException when validating" in {
      a[IllegalArgumentException] must be thrownBy {
        InvalidEmail.validate()
      }
    }

    "returns correct email String" in {
      ValidEmail.toString mustEqual EmailString
    }

    "have correct tuple" in {
      ValidEmail.tuple mustEqual EmailTuple
    }
  }
}