
object BlockNodeGenerators extends ScalaCheck {
	def genLinkPreviewStyle: Gen[LinkPreviewStyle] = Gen.oneOf(
		LinkPreviewStyle.Normal,
		LinkPreviewStyle.CommerceCondensed,
		LinkPreviewStyle.CommerceList
	)

	def genLinkPreview: Gen[LinkPreview] = for {
		url <- genUrl
		style <- genLinkPreviewStyle
	} yield LinkPreview(url, style)
}

abstract class GenericBlockNodeSpec[T: Format: TypeTag](val gen: Gen[T]) extends mutable.Specification {

	val className: String = implicitly[TypeTag[T]].tpe.typeSymbol.name.toString
	val format: Format[T] = implicitly[Format[T]]

	className should {

		"have a symmetric JSON serializer/deserializer" in {
			implicit val arb = Arbitrary(gen)
			prop { node: T =>
				Json.toJson(node).validate[T].get === node
			}.set(minTestsOk = 100)
		}

	}

}

class LinkPreviewBlockNodeSpec extends GenericBlockNodeSpec[LinkPreview](genLinkPreview)