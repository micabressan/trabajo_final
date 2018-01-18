  def apply(authFailed: Boolean): Document.Node[Context.Effect[M, UIState, Any]] = {
    val emailField = elementId()
    val passwordField = elementId()

    'div (
      if (authFailed) 'p ("Authentication failed") else Document.Empty,
      'div (
        'label (
          "Email", 'input ('type /= "text", emailField)
        ),
        'label (
          "Password", 'input ('type /= "password", passwordField)
        )
      ),
      'button (
        "Login",
        event('click) { access =>
          for {
            email <- access.property(emailField, 'value).map(model.user.email(_))
            password <- access.property(passwordField, 'value).map(model.auth.password(_))
            authResult <- authService.authenticate(email, password)
            result <- authResult match {
              case Right(user) =>
                access.transition { _ =>
                  UIState.Authenticated(user.displayName)
                }
              case Left(_) =>
                access.transition { _ =>
                  UIState.NotAuthenticated(authFailed = true)
                }
            }
          } yield result
        }
      )
    )
  }