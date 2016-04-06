package models

import javax.inject.{Singleton, Inject}

import scala.concurrent.Future
import play.api.db.slick.{HasDatabaseConfigProvider, DatabaseConfigProvider}
import play.api.libs.concurrent.Execution.Implicits.defaultContext
import slick.driver.JdbcProfile

// Case class (why?)
case class CompanyModel(id: Option[Long], name: String)

// Component or something
trait CompaniesComponent {
  self: HasDatabaseConfigProvider[JdbcProfile] =>

  import driver.api._

  // Table structure
  class CompaniesTable(tag: Tag) extends Table[CompanyModel](tag, "COMPANIES") {
    def id = column[Long]("ID", O.PrimaryKey, O.AutoInc)

    def name = column[String]("NAME")

    def * = (id.?, name) <>(CompanyModel.tupled, CompanyModel.unapply)
  }

}

// What we actually use
@Singleton()
class CompaniesDAO @Inject()(protected val dbConfigProvider: DatabaseConfigProvider) extends CompaniesComponent
with HasDatabaseConfigProvider[JdbcProfile] {

  import driver.api._

  val companies = TableQuery[CompaniesTable]

  /** Construct the Map[String,String] needed to fill a select options set */
  def options(): Future[Seq[(String, String)]] = {
    val query = (for {
      company <- companies
    } yield (company.id, company.name)).sortBy(/*name*/ _._2)

    db.run(query.result).map(rows => rows.map { case (id, name) => (id.toString, name) })
  }

  /** Insert a new company */
  def insert(company: CompanyModel): Future[Unit] =
    db.run(companies += company).map(_ => ())

  /** Insert new companies */
  def insert(companies: Seq[CompanyModel]): Future[Unit] =
    db.run(this.companies ++= companies).map(_ => ())

  def all(): Future[List[CompanyModel]] =
    db.run(this.companies.result).map(_ .toList)
}