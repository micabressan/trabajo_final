package net.verdagon.vcompiler.carpenter

case class LeveledTable[K, V](
    hasher: K => Int,
    table: Array[Array[Option[(K, V)]]]) {
  def get(key: K): Option[V] = {
    val hash = hasher(key);
    val indexInTopLevel = hash % table.size;
    val bucket = table(indexInTopLevel);
    val indexInBucket = hash % bucket.length;
    bucket(indexInBucket) match {
      case None => None
      case Some((foundKey, foundValue)) => {
        if (foundKey == key) Some(foundValue) else None
      }
    }
  }
}

class LeveledTableGenerator[K, V] {
  def generateTetrisTable(map: Map[K, V], hasher: K => Int): LeveledTable[K, V] = {
    if (map.isEmpty) {
      LeveledTable[K, V](hasher, Array(Array()))
    }
    val hashes = map.keys.zip(map.keys).toMap.mapValues(hasher);

    val initialTopLevelSize = Math.ceil(map.size / 4.0).toInt;
    val listBuckets = bucketize(hashes, initialTopLevelSize);
    val hashBuckets = listBuckets.map(listBucket => hashifyBucket(hashes, listBucket))
    val hashBucketsWithValues = hashBuckets.map(hashBucket => {
      hashBucket.map(maybeKey => {
        maybeKey.map(key => {
          (key -> map(key))
        })
      })
    })
    LeveledTable[K, V](hasher, hashBucketsWithValues)
  }

  private def bucketize(hashes: Map[K, Int], topLevelSize: Int): Array[List[K]] = {
    val initialBuckets = (0 until topLevelSize).map(_ => List[K]()).toVector
    val filledBuckets =
      hashes.foldLeft(initialBuckets)({
        case (buckets, (key, hash)) => {
          val index = hash % topLevelSize;
          buckets.updated(index, key :: buckets(index))
        }
      })
    // It's *extremely* unlikely, but if any of the buckets are too large (contain more than a
    // fourth of all the values) then we need to pick a different topLevelSize.
    if (filledBuckets.forall(_.size <= topLevelSize / 4)) {
      // It's fine, return it.
      filledBuckets.toArray
    } else {
      // Try again with a slightly larger top level size.
      bucketize(hashes, topLevelSize + 1)
    }
  }

  private def hashifyBucket(hashes: Map[K, Int], listBucket: List[K]): Array[Option[K]] = {
    hashifyBucketInner(hashes, listBucket, listBucket.size)
  }

  private def hashifyBucketInner(hashes: Map[K, Int], listBucket: List[K], hashBucketSize: Int): Array[Option[K]] = {
    val initialHashBucket: Array[Option[K]] = (0 until hashBucketSize).map(_ => None).toArray
    val resultMaybeHashBucket =
      listBucket.foldLeft[Option[Array[Option[K]]]](Some(initialHashBucket))((maybeHashBucket, key) => {
        maybeHashBucket match {
          case None => None
          case Some(hashBucket) => {
            val index = hashes(key) % hashBucketSize;
            hashBucket(index) match {
              case Some(_) => None
              case None => Some(hashBucket.updated(index, Some(key)))
            }
          }
        }
      })
    resultMaybeHashBucket match {
      case Some(resultHashBucket) => resultHashBucket
      case None => hashifyBucketInner(hashes, listBucket, hashBucketSize + 1)
    }
  }
}