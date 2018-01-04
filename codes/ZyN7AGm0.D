module core.websettings;

import diamond.core.websettings;

class DiamondWebSettings : WebSettings
{
  import vibe.d : HTTPServerRequest, HTTPServerResponse, HTTPServerErrorInfo;

  import diamond.authentication;
  
  private:
  this()
  {
    super();
  }

  public:
  override void onApplicationStart()
  {
    // Boolean values are: read, write, update, delete
    auto guest = addRole("guest")
      .addPermission("/", true, false, false, false)
      .addPermission("/test", false, false, false, false);

    auto user = addRole("user")
      .addPermission("/", true, false, false, false)
      .addPermission("/test", true, false, false, false);

    setDefaultRole(guest);

    setTokenValidator(&validateToken);
    setTokenSetter(&setToken);
    setTokenInvalidator(&invalidateToken);
  }

  private Role validateToken(string token, HTTPServerRequest request, HTTPServerResponse response)
  {
    return tokenIsValidInDatabase(token) ? getRole("user") : getRole("guest");
  }

  private string setToken(HTTPServerRequest request, HTTPServerResponse response)
  {
    auto token = generateAuthToken();
    insertTokenToDatabase(token);

    return token;
  }

  private void invalidateToken(string token, HTTPServerRequest request, HTTPServerResponse response)
  {
    deleteTokenFromDatabase(token);
  }

  override bool onBeforeRequest(HTTPServerRequest request, HTTPServerResponse response)
  {
    return true;
  }

  override void onAfterRequest(HTTPServerRequest request, HTTPServerResponse response)
  {
  }

  override void onHttpError(Throwable thrownError, HTTPServerRequest request,
    HTTPServerResponse response, HTTPServerErrorInfo error)
  {
  }

  override void onNotFound(HTTPServerRequest request, HTTPServerResponse response)
  {
  }

  override void onStaticFile(HTTPServerRequest request, HTTPServerResponse response)
  {
  }
}

shared static this()
{
  webSettings = new DiamondWebSettings;
}