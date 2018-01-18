  // Here org.freehep.freehep-xdr is used.
  def readServerHandshakeResponse(bytes: Array[Byte]): XdrHandshakeResponse = {
    val xdr = new XDRInputStream(new ByteArrayInputStream(bytes))

    val dataToSignLength = xdr.readInt()
    val dataToSign = new Array[Byte](dataToSignLength)
    xdr.read(dataToSign)

    val lastSeenSequence = xdr.readLong()

    val serverAesKeyLength = xdr.readInt()
    val serverAesKey = new Array[Byte](serverAesKeyLength)
    xdr.read(serverAesKey)

    XdrHandshakeResponse(dataToSign, lastSeenSequence, serverAesKey)
  }
  
  // Sign with Bouncy Castle
  def sign(bytes: Array[Byte]): Array[Byte] = {
    val signature = Signature.getInstance("SHA512withRSAandMGF1", new org.bouncycastle.jce.provider.BouncyCastleProvider())
    signature.initSign(clientPrivateKey)
    signature.update(bytes)
    signature.sign()
 }

  // Handshake call 
  def handshakeSignResponse(serverResponse: Array[Byte]) = {
    val xrdMessage = encryption.decryptMessageWithClientPrivateKey(serverResponse)  // SUCCESS
    val s = XdrMessages.readServerHandshakeResponse(xrdMessage)  // LOOKS LIKE SUCCESS, function above
    val signedData = encryption.sign(s.dataToSign) // COULD BE WRONG, function above
    send(signedData) // Call of org.java_websocket.client.WebSocketClient.send
  }