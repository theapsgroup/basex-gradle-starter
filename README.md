# basex-gradle-starter

A simple build script template for using [BaseX](basex.org) (8.0) with Gradle. Also adds Saxon 9.6 so you can use XSLT 2.0 out of the gate.

Installation steps:

1. `git clone https://github.com/xokomola/basex-gradle-starter.git`

Yep, that's right. There's only one step between wanting to use this and running queries with Basex. It even pulls down Gradle for you.

To see what tasks are available:

    gradlew tasks

Most of the familiar startup scripts are all available via the buildscript:

- `gui`
- `server` and `serverstop`
- `http` and `httpstop`
- `client`

To stop a running server you have to open another console and issue the
command from this other console.

Configuration of BaseX is done via the file `gradle.properties`.

To start the server:

    gradlew server

To run a simple query:

    gradlew query

And by using the `--daemon` option you can also avoid a lot of the Java startup tax.

    gradlew --daemon query

By default will put data under a `basex` subdirectory.

For more information on [Gradle](https://gradle.org) have a look at it's extensive documentation.
