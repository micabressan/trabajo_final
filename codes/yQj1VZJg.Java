public abstract class Game {
	abstract void init();
	abstract void start();
	abstract void end();

	public final void play() {
		init();
		start();
		end();
	}

	private void init() {
		System.out.println("Initializing...");
	}

	private void start() {
		System.out.println("Please kill yourself...");
	}

	private void end() {
		System.out.println("If you can read this you lost.");
	}
}