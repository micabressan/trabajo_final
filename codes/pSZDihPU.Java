public abstract class Game {
	abstract void init();
	abstract void start();
	abstract void end();

	public final void play() {
		init();
		start();
		end();
	}
}