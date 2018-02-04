myFuture.map {
  case Foo(_) => Ok(yeah)
  case Bar(_) => InternalServerError(bohoo)
}