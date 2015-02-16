# basex-gradle-starter

A simple build script template for using [BaseX](basex.org) (8.0) with Gradle. Also adds Saxon 9.6 so you can use XSLT 2.0 out of the gate.

Caution: this is still in very early stage.

Installation steps:

1. `git clone https://github.com/xokomola/basex-gradle-starter.git`

Yep, that's right. There's only one step between wanting to use this and running queries with Basex. It even installs Gradle for you.

To see what tasks are available:

    gradlew tasks

To execute other tasks:

    gradlew <taskname>

Most of the familiar startup scripts are all available as tasks:

- `gui`
- `console`
- `server` and `serverstop`
- `http` and `httpstop`

Configuration of BaseX is done in `gradle.properties`.

To run a simple query:

    gradlew query

And by using the `--daemon` option you can also avoid a lot of the Java startup tax.

    gradlew --daemon query

By default will put data under a `basex` subdirectory.

For more information on [Gradle](https://gradle.org) have a look at it's extensive documentation.

## Where to put your XQuery code?

For now the easiest way is to add your code under `basex/webapp` (or wherever you set the `org.basex.WEBPATH` property in `gradle.properties` to).

## TODO

- Provide arguments for query tasks
- Test task
- Packaging as WAR for Tomcat etc.
- Building XAR packages and managing module repository
- Import/export files
- Backup and restore


