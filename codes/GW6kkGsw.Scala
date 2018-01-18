  def sign(bytes: Array[Byte]): Array[Byte] = {
    val signature = Signature.getInstance("SHA512withRSAandMGF1", new org.bouncycastle.jce.provider.BouncyCastleProvider())
    signature.initSign(clientPrivateKey)
    signature.update(bytes)
    signature.sign()
  }