object Token{

	val _tokenList: List[Token.Type] = List(Token.NOT, Token.AND,
		Token.OR, Token.OPEN, Token.CLOSE, Token.ID, Token.NUMBER, Token.BINARYOP, Token.WHITESPACE)

	// Map to store all tokens ever created.
	private val tokenCache = mutable.Map[Builder, Token]()

	/* Returns a token of the given type and with the given ancillary data.
	 * Creates a new token if not found */
	def of(_type: Type, _data: String): Token = {
		val passedBuilder = Builder(_type, Option(_data))

		tokenCache.get(passedBuilder) match {
			// Return the token if found
			case Some(n) => n

			// Create a new token, add it to tokenCache, and return it
			case _ => {
				val newToken = Token(_type, Option(_data))
				tokenCache.put(passedBuilder, newToken)
				newToken
			}
		}
	}

	// type is a keyword, used _type instead
	final case class Builder(private final val _type: Type, private final val _data: Option[String]) {

		// Returns a new token of the local type and data
		def build: Token = {
			new Token(_type, _data)
		}

		/* Determines if a builder is equivalent to a passed in builder, by checking
		* equality of pattern, hasData, the type itself, and the ancillary data */
		def equals(that: Builder): Boolean = {
			if (that == null) {
				false
			}

			else {
				val tokenEqualsBool = this._type.equals(that._type)
				val ancillaryBool = optionEquals(that)

				tokenEqualsBool && ancillaryBool
			}
		}

		// Helper for equals. Checks if the data Option for this is equal to the data Option for that
		private def optionEquals(that: Builder): Boolean = this._data match {
			case Some(n) => that._data match {
				case Some(x) => n == x
				case _ => false
			}
			case _ => false
		}

		/* Calculates a hashcode based on the builder's hashcode on it's type, pattern,
		 * ancillary data.*/
		override def hashCode: Int = {
			val prime = 17
			val tokenHashCode = _type.hashCode
			val patternCode = _type.pattern.hashCode
			val ancillaryCode = _data match {
				case Some(n) => n.hashCode
				case _ => 0
			}

			prime * (tokenHashCode + patternCode + ancillaryCode)
		}
	}

	/* Token Enum implementation with a constructor
	 * all subclasses must be in the same file, hence "sealed"
	 * abstract classes can have constructors */
	sealed abstract class Type(val _pattern: String, val _hasData: Boolean,
		val _isComplex: Boolean, val _errorCode: Option[ParserException.ErrorCode]) {

		// Getters
		def pattern = _pattern
		def hasData = _hasData
		def isComplex = _isComplex

		// Prints out the Enum's name and information
		override def toString: String = {
			"[" + getName + ": \"" + pattern + "\", " + hasData + "]"
		}

		// Helper for toString. Returns the name of the Enum we want data for
		def getName: String = {
			this.getClass.getName.toString.split("\\$").last // Strips the getName name (e.g. Scala230923 $NOT$)
		}

		// Returns a boolean if an Enum is equal to the this Enum
		def equals(that: Type): Boolean = {
			if (null == that) {
				false
			}
			(pattern == that.pattern) && (hasData == that.hasData)
		}

		/* Returns a hashcode based on the Type of the Token*/
		override def hashCode: Int = {
			getName.hashCode
		}
	}

	/* Enum implementation of Token.Type
	 * by using case objects, the compiler warns if a match is not exhaustive */
	case object NOT extends Type("not", false, false, None)
	case object AND extends Type("and", false, true, Some(ParserException.AND_EXPECTED()))
	case object OR extends Type("or", false, true, None)
	case object OPEN extends Type("\\(", false, false, Some(ParserException.OPEN_EXPECTED()))
	case object CLOSE extends Type("\\)", false, false, Some(ParserException.CLOSE_EXPECTED()))
	case object ID extends Type("[a-z]+", true, false, Some(ParserException.ID_EXPECTED()))
	case object NUMBER extends Type("\\-\\d+|\\d+", true, false, None)
	case object BINARYOP extends Type("\\*|\\+|\\-|\\/", true, false, None)
	case object WHITESPACE extends Type("\\s+", true, false, None)
}