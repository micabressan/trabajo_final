package Database

import scala.util.Try
import scala.util.Success
import scala.util.Failure
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.DriverManager;
import java.sql.SQLException;
import scala.annotation.tailrec
import org.sqlite.JDBC;
import Types._;

object Database extends App {

  override def main(args: Array[String]):Unit = {
    val dbs = new Database
    println(dbs.getMovies("movies.db").isSuccess)
    println(dbs.getMovieWithId(2,"movies.db"))
  }
}

class Database {

  def connectToDb(name: String): Try[Connection] = {
    Try(DriverManager.getConnection("jdbc:sqlite:" + name))
  }

  def searchMovies(name: String, movies: Movies): Movies = {
    Movies(movies.movies.filter(_.name.contains(name)))
  }

  def setMovies(db: String): Movies = {
    val movies = getMovies(db).get.reverse
    Movies(movies)
  }

  def grabNumberOfMovies(num: Int,db: String): Movies = {
    val movies = getMovies(db).get.reverse.take(num)
    Movies(movies)
  }

  def getMovieWithId(id: Int, db:String): Movie = {
    connectToDb(db)
      .map(_.createStatement)
      .map(takeMovieWithId(id, _))
      .get
  }

  @tailrec
  private def getResults(rs: ResultSet,data: List[(Int,String,String)]): List[(Int, String,String)] = {
    if (rs.next) {
      val id = rs.getInt("ID")
      val name = rs.getString("Name")
      val year = rs.getString("Year")
      getResults(rs, ((id,name,year) :: data))
    }
    else {
      data
    }
  }

  def takeMovieWithId(id: Int,stmt: Statement): Movie = {
    val rs: Try[ResultSet] = Try(stmt.executeQuery(s"SELECT * FROM MovieTitle WHERE ID = $id;"));
    val data = List[(Int, String,String)]()
    rs match {
      case Success(results) => {
        createMovie(getResults(results,data).head)
      }
      case Failure(fail) => {
        createMovie(2,"Failed",fail.getMessage)
      }
    }
  }

  def viewMovies(stmt: Statement): List[(Int,String,String)] = {
    val rs: Try[ResultSet] = Try(stmt.executeQuery( "SELECT * FROM MovieTitle;"));
    val data = List[(Int, String,String)]()
    rs match {
      case Success(results) => {
        getResults(results,data)
      }
      case Failure(fail) => {
        List((1,"fail",fail.getMessage))
      }
    }
  }

  def getMovies(db: String): Try[List[Movie]]= {
    connectToDb(db)
      .map(_.createStatement)
      .map(viewMovies(_))
      .map(_.map(createMovie(_)))
  }


  //  def putMovie(db: String,movies: List[(Int,String,String)]): List[Boolean] = {
  //    val stmt = connectToDb(db).map(_.createStatement).get
  //    movies.map(insertMovie(stmt,_))
  //  }

  def insertMovie(stmt: Statement, movie: (Int,String,String)): Boolean = {
    val sql: String = "INSERT INTO MovieTitle (ID,Name,Year) VALUES ("+movie._1+",'"+movie._2+"','"+movie._3+"');";
    stmt.executeUpdate(sql);
    return true
  }

  def createMovie(data: (Int,String,String)): Movie = {
    (Movie.apply _).tupled(data)
  }

}