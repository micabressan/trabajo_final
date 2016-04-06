package com.myhungergames.fr;

public enum GameState {
	
	IN_LOBBY(true), IN_PREPVP(false), IN_GAME(false), IN_FINISH(false);
	
	
	private static GameState currentState;
	private boolean canJoin;

	GameState(boolean canJoin){
		this.canJoin = canJoin;
	}
	
	public boolean canJoin(){
		return canJoin;
	}
	
	public static void setState(GameState state){
		GameState.currentState = state;
	}
	
	public static boolean isState(GameState state){
		return GameState.currentState == state;
	}
	
	public static GameState getState(){
		return currentState;
	}
}