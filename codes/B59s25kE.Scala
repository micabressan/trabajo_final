package com.nuvola_analytics.bigdata.etl.redis.wrapper

import com.nuvola_analytics.bigdata.etl.log.ConfigInstrumented
import com.nuvola_analytics.bigdata.etl.redis.binder.RedisBinder
import com.nuvola_analytics.bigdata.etl.redis.crud.RedisCrud
import com.nuvola_analytics.bigdata.etl.util.ConfigClient
import com.redis.RedisClient

import scala.collection.mutable

class RedisWrapper(
  val client: RedisClient,
  val key: String,
  protected val keys: Map[String, String] = Map()) {

  lazy val crud: RedisCrud = RedisCrud(client, key)

  def keyForName(name: String) = keys(name)

  def section(subkey: String, delimiter: String = ".") = {
    val newKey = key + delimiter + subkey
    new RedisWrapper(client, newKey, keys)
  }

}

object RedisWrapper extends ConfigInstrumented {

  def apply(key: String, keys: Map[String, String] = Map.empty): RedisWrapper = {
    val client = new RedisClient(_options.redis.host, _options.redis.port)
    new RedisWrapper(client, key, keys)
  }

  val credentials =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get(_keys.credentials_key, _defs.credentials_key)))
  val organizations =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get(_keys.organizations_key, _defs.organizations_key)))
  val users =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get(_keys.users_key, _defs.users_key)))
  val attributes =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get(_keys.attributes_key, _defs.attributes_key)))
  val groups =
    RedisWrapper(
      ConfigClient.redisPath(ConfigClient.get(_keys.attributes_key, _defs.attributes_key)),
      Map("users_mapping" -> "users_groups_mapping", "access_mapping" -> "access_groups_mapping"))
  val reports =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get("reports_key", "reports")))
  val trees =
    RedisWrapper(ConfigClient.redisPath(ConfigClient.get("trees_key", "trees")))

}


package com.nuvola_analytics.bigdata.etl.redis.crud

import com.redis.RedisClient

class RedisCrud(client: RedisClient, key: String) {

  //--------------------------------CRUD-------------------------------------------------

  def read(id: String): Option[String] = {
    client.hget(key, id)
  }

  def create(id: String, value: Any): Unit = {
    if (read(id).isDefined) throw new IllegalArgumentException("Element with such id already exists")
    client.hset(key, id, value.toString)
  }

  def update(id: String, value: Any): Unit = {
    if (read(id).isEmpty) throw new NoSuchElementException("No such id to update")
    client.hset(key, id, value.toString)
  }

  def delete(id: String): Unit = {
    client.hdel(key, id)
  }

  //--------------------------------EXPERIMENTAL------------------------------------------------------

  def all(): Option[Map[String, String]] = {
    client.hgetall(key)
  }

  def ids(): Option[List[String]] = {
    client.hkeys(key)
  }

}

object RedisCrud {
  def apply(client: RedisClient, key: String): RedisCrud = new RedisCrud(client, key)
}