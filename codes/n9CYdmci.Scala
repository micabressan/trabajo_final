case class UserName(name: String) {
  def lookup(admin: Admin): UserData
}
case class Password(hash: Hash) {
  def lookup(admin: Admin): UserData
}

def help(id: UserName | Password) = {
  val user = id match {
    case UserName(name) => lookupName(name)
    case Password(hash) => lookupPassword(hash)
  }
}