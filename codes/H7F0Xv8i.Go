func LogEndOfRequestHandler(a *app.Application) func(http.Handler) http.Handler {
	return func(next http.Handler) http.Handler {
		return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
			defer func() {
				requestId := r.Header.Get(contextutils.HeaderRequestId)
				a.Logger.Infof("HEADER REQUEST ID: %+v", requestId)
				value := r.Context().Value(contextutils.ContextRequestIDKey)
				a.Logger.Infof("CONTEXT REQUEST ID: %+v", value)
				sessionId := r.Header.Get(contextutils.HeaderSessionIdKey)
				a.Logger.Infof("HEADER REQUEST ID: %+v", sessionId)
				client := r.Context().Value(contextutils.ContextClientKey)
				a.Logger.Infof("CONTEXT CLIENT STRUCT: %+v", client)
			}()
			next.ServeHTTP(w, r)
		})
	}
}