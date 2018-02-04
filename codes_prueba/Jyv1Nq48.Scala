package game.chunk.mixin

import akka.event.LoggingAdapter
import api.Chunk
import api.Chunk._
import game.blocks.{GREEN, RED, BLUE, BaseColor}
import game.chunk.ChunkActor.ChunkActor
import internal.BundledMessage.BundledMessageInstance
import math.{Location, LocationChunk, MathUtils}

import scala.collection.immutable.HashMap
import scala.collection.mutable.ArrayBuffer

/** Creation date: 15.05.2015.
  *
  * Copyright (c) harati
  */
object LightManager {

	trait LightCalculator { this: ChunkActor ⇒

		preStartBuilder += { _ ⇒
			onReadyLatch.up(queue)
			calculateBlockLight()
		}

		receiveBuilder += {
			case ExternalLight(p, value, color, deep) ⇒ wave(Math.floor(p.x).toInt, Math.floor(p.y).toInt, Math.floor(p.z).toInt, color, value, deep)
		}

		private var queue: ArrayBuffer[ExternalLight] = new ArrayBuffer()

		private def calculateBlockLight()(implicit log: LoggingAdapter) = {
			val c = calculate()
			log debug s"Свёт в чанке $pos() посчитан за $c мс, пакетов к отправке ${queue.length}"
			queue.foldLeft(new HashMap[LocationChunk, BundledMessageInstance]())((acc, light) ⇒ {
				val chunk = light.p.toLocationChunk
				acc.get(chunk) match {
					case Some(f) ⇒
						f += light
						acc
					case None ⇒
						val m = BundledMessageInstance() += chunk
						acc + ((chunk, m))
				}
			}) foreach { case (p: LocationChunk, m: BundledMessageInstance) ⇒ Chunk.whenExist(p) tell m }
			queue.clear()
			onReadyLatch.down(queue)
		}

		private def calculate(): Long = {
			val time = System.currentTimeMillis()
			for (xr ← pos.blockX to pos.blockX + 15)
				for (yr ← pos.blockY to pos.blockY + 15)
					for (z ← 0 to 255) if (!state.getBlock(xr, yr, z).emission.isNone) calculateLight(xr, yr, z)
			System.currentTimeMillis() - time
		}

		def calculateLight(x: Int, y: Int, z: Int) = {
			wave(x, y, z, GREEN, 0, 0)
			wave(x, y, z, BLUE, 0, 0)
			wave(x, y, z, RED, 0, 0)
		}

		private def wave(x: Int, y: Int, z: Int, color: BaseColor, value: Int = 0, deep: Int): Unit = {
			if (z < 0 || z > 254) return

			if (!state.position().inSameChunk(x, y, state.position().dimID) && deep < 2) {
				queue += ExternalLight(Location(x, y, z, pos.dimID), value, color, deep + 1)
				return
			}

			val block = state.getBlock(x, y, z)
			if (block.emission.isNone && (value == 0 || block.attenuation.isFull)) return
			val corrected = block.attenuation(value)

			val ext = color(corrected)
			val int = color(state.getLight(x, y, z))
			val nat = color(block.emission.boxed)

			val max = MathUtils.max(ext, int, nat)
			if (max == int) return
			state.setLightCompound(x, y, z, max, color)

			val light = state.getLight(x, y, z)
			wave(x + 1, y, z, color, light, deep)
			wave(x - 1, y, z, color, light, deep)
			wave(x, y + 1, z, color, light, deep)
			wave(x, y - 1, z, color, light, deep)
			wave(x, y, z + 1, color, light, deep)
			wave(x, y, z - 1, color, light, deep)
		}

	}

	case class ExternalLight(p: Location, value: Int, color: BaseColor, deep: Int = 0)

}