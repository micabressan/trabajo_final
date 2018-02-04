public class Player {
	
	private Movement movement;
	private CastleWarsDomain castlewars;
	
	private int x;
	private int y;
	private int z;
}

public class Movement {
	
	private Player p;
	
	public Movement(Player p) {
		this.player = p;
	}
	
	// methods
	
}

public class CastleWarsDomain {
	private CastleWars minigame;
	private boolean isHoldingFlag;
	private boolean inCastleWars;
	// etc
}