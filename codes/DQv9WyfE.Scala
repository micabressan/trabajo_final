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