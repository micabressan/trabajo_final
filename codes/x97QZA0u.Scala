def genIdAndOptThumbnail[A: TypeTag]: Gen[A] = for {
		id <- gen[String]
		thumbnail <- Gen.option(genSimpleImage)
    
		tt = typeTag[A]
		mirror = currentMirror.reflectClass(tt.tpe.typeSymbol.asClass)
		ctor = tt.tpe.decl(termNames.CONSTRUCTOR).asMethod
	} yield mirror.reflectConstructor(ctor).apply(id, thumbnail)