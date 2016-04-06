public abstract class AbstractGameScreen extends AbstractScreen {
	protected GameWorld gameWorld;

	public AbstractGameScreen() {
		super();
		gameWorld = new GameWorld();
	}

	@Override
	public abstract void create();

	@Override
	public void render(float delta) {

		gameWorld.render(batch);

	}

	protected void registerGameEntity(String tag, AbstractGameEntity entity) {
		gameWorld.registerGameEntity(tag, entity);

	}

}