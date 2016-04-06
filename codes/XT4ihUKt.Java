package helloworld;

public class pingdom {
	public void intercept(RequestFacase request) {
		request.addHeader("App-Key", "{app-key}");
		String login = "{username}:{password}";
		String auth = "Basic " + Base64.encodeToString(login.getBytes(), Base64.NO_WRAP);
}
}