package net.verdagon.vcompiler.carpenter

case class TetrisTable[K, V](
    hasher: K => Int,
    size: Int,
    topLevel: Array[Option[(Int, Int)]],
    combinedBuckets: Array[Option[(K, V)]]) {
  def get(key: K): Option[V] = {
    val hash = hasher(key);
    val indexInTopLevel = hash % size;
    topLevel(indexInTopLevel) match {
      case None => None
      case Some((bucketBeginIndex, bucketSize)) => {
        val indexInBucket = hash % bucketSize;
        val indexInCombinedBuckets = bucketBeginIndex + indexInBucket
        combinedBuckets(indexInCombinedBuckets) match {
          case None => None
          case Some((foundKey, foundValue)) => {
            if (foundKey == key) Some(foundValue) else None
          }
        }
      }
    }
  }
}

class TetrisTableGenerator[K, V] {
  def generateTetrisTable(map: Map[K, V], hasher: K => Int): TetrisTable[K, V] = {
    if (map.isEmpty) {
      TetrisTable[K, V](hasher, 0, Array(), Array())
    }
    val hashes = map.keys.zip(map.keys).toMap.mapValues(hasher);

    val initialTopLevelSize = Math.ceil(map.size / 4.0).toInt;
    val listBuckets = bucketize(hashes, initialTopLevelSize);
    val hashBuckets = listBuckets.map(listBucket => hashifyBucket(hashes, listBucket))
    val (topLevel, combinedBuckets) = tetris(map, hashes, hashBuckets)
    TetrisTable[K, V](hasher, hashBuckets.length, topLevel, combinedBuckets)
  }

  private def tetris(
      map: Map[K, V],
      hashes: Map[K, Int],
      hashBuckets: Array[Array[Option[K]]]):
  (Array[Option[(Int, Int)]], Array[Option[(K, V)]]) = {
    // Note: these bucket pointers currently point at themselves; that is updated inside
    // tetrisInner to point at where the bucket is eventually placed.
    val topLevel: Array[Option[(Int, Int)]] =
      hashBuckets.zipWithIndex.map({
        case (hashBucket, index) => Some((index, hashBucket.length))
      }).toArray
    val numberedHashBuckets =
      hashBuckets.zipWithIndex.map({
        case (hashBucket, number) => (number, hashBucket)
      }).toList
    val sortedNumberedHashBuckets =
      numberedHashBuckets.sortWith({
        case ((_, bucketA), (_, bucketB)) => {
          bucketShouldBeInsertedBefore(bucketA, bucketB)
        }
      })
    tetrisInner(map, hashes, topLevel, Vector(), sortedNumberedHashBuckets)
  }

  private def getSpan(bucket: Array[Option[K]]): Int = {
    bucket
        .toList
        .foldLeft(List[Option[K]]())({
          case (Nil, None) => Nil
          case (previous, anything) => previous :+ anything
        })
        .foldRight(List[Option[K]]())({
          case (None, Nil) => Nil
          case (anything, subsequent) => anything :: subsequent
        })
        .length
  }

  private def bucketShouldBeInsertedBefore(
      bucketA: Array[Option[K]],
      bucketB: Array[Option[K]]):
  Boolean = {
    val bucketASpan = getSpan(bucketA);
    val bucketBSpan = getSpan(bucketB);
    if (bucketASpan < bucketBSpan) {
      false
    } else if (bucketASpan > bucketBSpan) {
      true
    } else {
      val bucketAMembers = bucketA.count(_.nonEmpty);
      val bucketBMembers = bucketB.count(_.nonEmpty);
      if (bucketAMembers < bucketBMembers) {
        false
      } else if (bucketAMembers > bucketBMembers) {
        true
      } else {
        false
      }
    }
  }

  private def tetrisInner(
      map: Map[K, V],
      hashes: Map[K, Int],
      topLevel: Array[Option[(Int, Int)]],
      combinedBuckets: Vector[Option[(K, V)]],
      numberedHashBuckets: List[(Int, Array[Option[K]])]):
  (Array[Option[(Int, Int)]], Array[Option[(K, V)]]) = {
    numberedHashBuckets match {
      case Nil => (topLevel, combinedBuckets.toArray)
      case (thisHashBucketNumber, thisHashBucket) :: remainingHashBuckets => {
        val (newCombinedBuckets, bucketStartIndex) = merge(map, hashes, combinedBuckets, thisHashBucket)

        topLevel(thisHashBucketNumber) match {
          case Some((bucketStartIndex, size)) => assert(bucketStartIndex == thisHashBucketNumber)
          case _ => throw new RuntimeException("NO")
        }

        val newTopLevelMember = Some(bucketStartIndex, thisHashBucket.length);
        val newTopLevel = topLevel.updated(thisHashBucketNumber, newTopLevelMember)
        tetrisInner(map, hashes, newTopLevel, newCombinedBuckets, remainingHashBuckets)
      }
    }
  }

  private def merge(
      map: Map[K, V],
      hashes: Map[K, Int],
      combinedBuckets: Vector[Option[(K, V)]],
      bucket: Array[Option[K]]):
  (Vector[Option[(K, V)]], Int) = {
    mergeInner(map, hashes, combinedBuckets, bucket, 0)
  }

  private def mergeInner(
      map: Map[K, V],
      hashes: Map[K, Int],
      tetrisTable: Vector[Option[(K, V)]],
      bucket: Array[Option[K]],
      indexToInsertBucket: Int):
  (Vector[Option[(K, V)]], Int) = {
    val mergesCleanly =
      tetrisTable.drop(indexToInsertBucket).zip(bucket).forall({
        case (None, _) => true
        case (_, None) => true
        case (_, _) => false
      })
    if (mergesCleanly) {
      val tetrisTableEndIndex = tetrisTable.size
      val bucketEndIndexInTetrisTable = indexToInsertBucket + bucket.size
      val tetrisTableNewSize = Math.max(tetrisTableEndIndex, bucketEndIndexInTetrisTable)
      val numEmptiesNeededAtEndOfTetrisTable = tetrisTableNewSize - tetrisTable.size
      val expandedTetrisTable = tetrisTable ++ (0 until numEmptiesNeededAtEndOfTetrisTable).map(_ => None)
      val mergedTetrisTable =
        bucket.zipWithIndex.foldLeft(expandedTetrisTable)({
          case (currentTetrisTable, (bucketMember, indexInBucket)) => {
            val indexInTable = indexToInsertBucket + indexInBucket;
            val currentTableMember = currentTetrisTable(indexInTable)
            val newTableMember =
              (currentTableMember, bucketMember) match {
                case (tetrisTableMember, None) => tetrisTableMember
                case (None, Some(key)) => Some((key, map(key)))
              };
            currentTetrisTable.updated(indexInTable, newTableMember)
          }
        })
      (mergedTetrisTable, indexToInsertBucket)
    } else {
      mergeInner(map, hashes, tetrisTable, bucket, indexToInsertBucket + 1)
    }
  }

  private def bucketize(hashes: Map[K, Int], topLevelSize: Int): Array[List[K]] = {
    val initialBuckets = (0 until topLevelSize).map(_ => List[K]()).toArray
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
      filledBuckets
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