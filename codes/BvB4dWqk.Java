public interface PlanetsListView {
  void setupData(List<Planet> planets);
  void updateData();
}

public interface PlanetsPresenter {
  void requestPlanetsUpdate();
  void onAddPlanetClicked(Planet planet);
  void onDeletePlanetClicked(Planet planet);
}

public class PlanetListActivity extends AppCompatActivity implements PlanetsListView {

  private PlanetsPresenter mPresenter;

  @Override
  public void onCreate(Bundle savedInstanceState) {
    // ...

    mPresenter = new PlanetsPresenterImpl(this);
    mPresenter.requestPlanetsUpdate();

    // Планета, которая будет добавляться/удаляться, скорее всего находится не 
    // в onCreate, а достается каким-то иным способом, суть того, что дальше 
    // происходит, в том, что операция над планетой осуществляется не в UI, 
    // а передается в презентер
    
    Planet planet;
    
    // ...

    Button addButton = findViewById(R.id.addPlanetButton);
    addButton.setOnClickListener(v -> {
      mPresenter.onAddPlanetClicked(planet);
    });

    Button deleteButton = findViewById(R.id.deletePlanetButton);
    deleteButton.setOnClickListener(v -> {
      mPresenter.onDeletePlanetClicked(planet);
    });
  }
  
  // ...

  @Override
  public void setupData(List<Planet> planets) {
    mRecyclerView.setAdapter(new MyAdapter(planets)); 
  }

  @Override
  public void updateData() {
    mRecyclerView.getAdapter().notifyDataSetChanged();
  }
}

public class PlanetsPresenterImpl implements PlanetsPresenter {

  private PlanetView mPlanetView;

  public PlanetsPresenterImpl(PlanetView planetView) {
    mPlanetView = planetView;
  }
  
  @Override
  public void requestPlanetsUpdate() {
    PlanetsProvider.getAllPlanets(planetList -> {
      mPlanetView.setupData(planetList);
    });
  }

  @Override
  public void onAddPlanetClicked(Planet planet) {
    PlanetsProvider.addPlanet(planet, () -> {
      mPlanetView.updateData();
    });
  }

  @Override
  public void onDeletePlanetClicked(Planet planet) {
    PlanetsProvider.deletePlanet(planet, () -> {
      mPlanetView.updateData();
    });
  }
}