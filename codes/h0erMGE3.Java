public class GameOfLife extends Game {

	@Override
	void init() {
        System.out.println("Initializing...");
	}

	@Override
	void start() {
        System.out.println("Please kill yourself...");
	}

	@Override
	void end() {
        System.out.println("If you can read this you lost.");
	}
	
	public static void main(String[] args) {
		this.play();
	}
}