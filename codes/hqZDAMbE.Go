type appengineConfig struct{}

func WithAppEngine(parent Context, c appengine.Config) Context {
return context.WithValue(parent, appengineConfig{}, c)
}

func AppengineConfig(ctx Context) (appengine.Config, bool) {
c, ok := ctx.Value(appengineConfig{}).(appengine.Config)
return c, ok
}