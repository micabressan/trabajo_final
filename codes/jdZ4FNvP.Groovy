#!/usr/bin/env groovy
/**
 * demoGroovyLogTransformation.groovy
 *
 * Grab SLF4J, Log4j, and Apache Commons Logging dependencies using @Grab and
 * demonstrate Groovy 1.8's injected logging handles.
 *
 * http://marxsoftware.blogspot.com/2011/05/easy-groovy-logger-injection-an...
 */

// No need to "grab" java.util.logging: it's part of the JDK!

/*
 * Specifying 'slf4j-simple' rather than 'slf4j-api' to avoid the error
 * "Failed to load class "org.slf4j.impl.StaticLoggerBinder" that is caused by
 * specifying no or more than one of the actual logging binding libraries to
 * be used (see http://www.slf4j.org/codes.html#StaticLoggerBinder). One should
 * be selected from 'slf4j-nop', 'slf4j-simple', 'slf4j-log4j12.jar',
 * 'slf4j-jdk14', or 'logback-classic'. An example of specifying the SLF4J
 * dependency via @Grab is available at
 * http://mvnrepository.com/artifact/org.slf4j/slf4j-api/1.6.1.
 */
@Grab(group='org.slf4j', module='slf4j-simple', version='1.6.1')

/*
 * An example of specifying the Log4j dependency via @Grab is at
 * http://mvnrepository.com/artifact/log4j/log4j/1.2.16.
 */
@Grab(group='log4j', module='log4j', version='1.2.16')

/*
 * An example of specifying the Apache Commons Logging dependency via @Grab is at
 * http://mvnrepository.com/artifact/commons-logging/commons-logging-api/1.....
 */
@Grab(group='commons-logging', module='commons-logging-api', version='1.1')


/*
 * Run the tests...
 */
int headerSize = 79
printHeader("java.util.logger", headerSize)
def javaUtilLogger = new JavaUtilLoggerClass()
printHeader("Log4j", headerSize)
def log4jLogger = new Log4jLoggerClass()
printHeader("SLF4j", headerSize)
def slf4jLogger = new Slf4jLoggerClass()
printHeader("Apache Commons", headerSize)
def commonsLogger = new ApacheCommonsLoggerClass()


/**
 * Print header with provided text.
 *
 * @param textForHeader Text to be included in the header.
 * @param sizeOfHeader Number of characters in each row of header.
 */
def printHeader(final String textForHeader, final int sizeOfHeader)
{
   println "=".multiply(sizeOfHeader)
   println "= ${textForHeader}${' '.multiply(sizeOfHeader-textForHeader.size()-4)} ="
   println "=".multiply(sizeOfHeader)
}