scala> val whitespace = Set(' ','\n','\r','\t')
whitespace: scala.collection.immutable.Set[Char] =
Set( ,
, 	)

scala> "abc".exists(!whitespace.contains(_))
res1: Boolean = true

scala> " ".exists(!whitespace.contains(_))
res2: Boolean = false

scala> "\r\n\r\t".exists(!whitespace.contains(_))
res3: Boolean = false