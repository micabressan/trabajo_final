package com.pavelsikun.kotlin.adbautoconnector

import java.io.File
import java.nio.file.Files
import java.nio.file.Paths
import java.util.*

class FileTransmitter(from: String, to: String, val filter: (File) -> Boolean = {true}) {

    var enteredResourceDir: Boolean = false

    val fromDirectory = File(from)
    val toDirectory   = File(to)

    val nameCollisions = HashMap<String, String>()
    val existingResolutions = ArrayList<String>()

    fun action() {
        toDirectory.listFiles()
                .filter { it.name.contains("drawable-") }
                .map { it.name }
                .forEach { existingResolutions.add(it) }
        fromDirectory.toFileEntity().performOperation()
    }


    fun FileEntity.performOperation() {
        when(this) {
            is Directory -> this.file.listFiles()
                    .map { it.toFileEntity() }
                    .forEach { it.performOperation() }
            is ResourceDirectory -> this.file.listFiles()
                    .map{ it.toFileEntity() }
                    .forEach { it.performOperation() }
            is Resource -> if(filter(this.file)) moveFile(this.file)
        }
    }

    fun moveFile(f: File) {
        if (!existingResolutions.contains(f.parent)) return
        val moveToDir = File(toDirectory.getAbsolutePath() + f.parent)
        var name = f.name
        if (moveToDir.listFiles().map{ it.name }.contains(f.name)) {
            name = nameCollisions.getOrElse<String, String>(name, { f.handleNameConflict() })
        }
        Files.copy(
                Paths.get(f.getAbsolutePath()),
                Paths.get("${moveToDir.getAbsolutePath()}${File.separator}$name"))
    }


    interface FileEntity
    data class Directory(val file: File) : FileEntity
    data class ResourceDirectory(val file: File) : FileEntity
    data class Resource(val file: File) : FileEntity


    inline fun <T> Array<T>.forAll(body: (T) -> Boolean): Boolean {
        var isSuccess = true
        forEach { if(!body(it)) isSuccess = false }
        return isSuccess
    }

    fun File.handleNameConflict() = ""

    inline fun <K, V> Map<K, V>.getOrElse(key: K, defaultValue: () -> V): V = this[key] ?: defaultValue()

    fun File.toFileEntity(): FileEntity {
        if (isDirectory()) {
            if (listFiles().forAll{ it.isDirectory() && it.name.contains("drawable") }) return ResourceDirectory(this)
            else return Directory(this)
        }
        else return Resource(this)
    }
}