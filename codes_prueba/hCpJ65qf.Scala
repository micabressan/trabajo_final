class Application @Inject() (dao: DAOComponent[Curriculum]) extends Controller {}

trait DAOComponent[T] {}

object CurriculumDao extends DAOComponent[Curriculum] {}

I get this error on run:

ProvisionException: Unable to provision, see the following errors: 1) No implementation for dao.DAOComponent<models.Curriculum> was bound. 
while locating dao.DAOComponent<models.Curriculum> 
for parameter 0 at controllers.Application.<init>(Application.scala:16) 
while locating com.google.inject.Provider<controllers.Application> 
for parameter 1 at router.Routes.<init>(Routes.scala:31) 
while locating router.Routes 
while locating play.api.inject.RoutesProvider 
while locating play.api.routing.Router