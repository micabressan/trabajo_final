func NewLogin() *login {
	return new(login)
}

type login struct {
	_    app.Controller `knex-provide:"resource"`
	user interact.User  `knex-provide:"resource"`
	mvc.BaseController

	Model     request.Login
	ViewModel response.Login
}

func (ctrl *login) Init() {
	ctrl.Route = "login"
	ctrl.Method = mvc.POST
	ctrl.Auth = false
}

func (ctrl *login) Inject(user interact.User) {
	ctrl.user = user
}

func (ctrl *login) Validate(validate mvc.Validator) {
	validate(ctrl.Model.Email, mvc.ValueNotEmpty, "empty email")
	validate(ctrl.Model.Password, mvc.ValueNotEmpty, "empty password")
}

func (ctrl *login) Action() (mvc.View, error) {
	return ctrl.user.Login(ctrl.Model)
}