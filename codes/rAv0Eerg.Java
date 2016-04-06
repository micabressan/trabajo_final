package controllers.login;

import models.User;
import play.data.Form;
import play.libs.Akka;
import play.libs.F.Promise;
import play.mvc.Controller;
import play.mvc.Result;
import scala.concurrent.duration.Duration;
import service.MySQLDatabaseSelectRequest;
import service.MySQLDatabaseService;
import akka.actor.ActorRef;
import akka.dispatch.Mapper;
import akka.pattern.Patterns;
import akka.util.Timeout;

import com.avaje.ebean.Ebean;
import com.google.common.collect.ImmutableList;

public final class LoginController extends Controller {
	public Result index() {
		return ok(views.html.index.render());
	}
	
	public Promise<Result> login() {
		// TODO: run validation on a validation actor
		Form<User> loginForm = Form.form(User.class).bindFromRequest();
		
		if (loginForm.hasGlobalErrors()) {
			return Promise.pure(ok(views.html.index.render()));
		} else {
			ActorRef databaseService = Akka.system().actorOf(MySQLDatabaseService.create(), "database-service");
			
			User user = loginForm.get();
			
			MySQLDatabaseSelectRequest<User> request = new MySQLDatabaseSelectRequest<User>(Ebean.find(User.class)
					.where()
					.eq("username", user.getUsername())
					.eq("password", user.getPassword()));
			
			Timeout timeout = new Timeout(Duration.create(1, "second"));
			
			Mapper<Object, Result> mapper = new Mapper<Object, Result>() {
				@Override
				public Result apply(Object result) {
					return authenticate(result);
				}
			};
			
			return Promise.wrap(Patterns.ask(databaseService, request, timeout).map(mapper, Akka.system().dispatcher()));
		}
	}

	private Result authenticate(Object result) {
		if (result instanceof ImmutableList<?>) {
			ImmutableList<?> matches = (ImmutableList<?>) result;
			
			switch (matches.size()) {
			case 1:
				return ok(views.html.index.render()); // TODO: redirect to home
			default:
				return ok(views.html.index.render()); // TODO: invalid username/password
			}
		}
		
		throw new IllegalArgumentException("Result not of type of ImmutableList");
	}
}