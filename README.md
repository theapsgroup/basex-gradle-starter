# basex-gradle-starter

A simple build script template for using [BaseX](basex.org) (8.3.1) with Gradle. Also adds Saxon 9.6 so you can use XSLT 2.0 out of the gate.

Installation steps:

1. `git clone https://github.com/xokomola/basex-gradle-starter.git`

Yep, that's right. There's only one step between wanting to use this and running
queries with Basex. It even installs Gradle for you.

To see what tasks are available:

    gradlew tasks

To execute other tasks:

    gradlew <taskname>

For more information on [Gradle](https://gradle.org) have a look at it's
extensive documentation.


## Startup tasks

Most of the familiar startup scripts are all available as tasks:

- `gui`
- `console`
- `server` and `serverstop`
- `http`, `httpstart` and `httpstop`

Configuration of BaseX is done in `gradle.properties`.

By default will put all data under the `basex` subdirectory.


## Create a database

    gradlew create -Pdb=dbname -Pdir=~/tmp/xml


## Export a database

    gradlew export -Pdb=dbname -Pdir=~/tmp/export


## XQuery tasks

To run a simple query:

    gradlew query -Pq="1+1"

To run all tests under `basex/webapp`:

    gradlew xqtest


## Execute BaseX commands

See the BaseX documentation on [commands](http://docs.basex.org/wiki/Commands). To execute BaseX commands from a file:

    gradle command -Pc=commands.bxs

To execute BaseX commands provided as a string on the command line:

    gradle command -Pc="get chop"

 
## Running faster with "daemon"

And by using the `--daemon` option you can also avoid a lot of the Java startup
tax.

    gradlew --daemon query


## Where to put XQuery code?

For now the assumes that both source and tests are in `basex/webapp` (or wherever you point `org.basex.WEBPATH` property in `gradle.properties` to).


## Run tests automatically

Gradle introduced "continous builds". If you want all tests to run automatically when test scripts or XQuery source code changes use this:

    gradlew -t xqtest


## Building an HTTP application distribution

You've created an application, running and testing it using this build script.
Now it's time to distribute the application.

    gradlew distZip

This creates a Zip with the application and start scripts.

See also: [Gradle Application
Plugin](http://gradle.org/docs/current/userguide/application_plugin.html)


## Create a runnable server jar

You can combine all the needed jar files and create a so-called fat jar. This
allows you to run BaseX as a jar (easy to deploy). You can already do that
with the BaseX core distribution but with this it also includes the optional
libraries.

    gradlew shadowJar

This will create a jar (we do not have local classes yet) inside `build/libs`.
The task will build both a jar with local code and another one with all
dependencies (postfixed with `-all`).

Run the server:

    java -Dorg.basex.dbpath=basex/data
         -Dorg.basex.repopath=basex/repo 
         -Dorg.basex.webpath=basex/web
         -jar build/libs/basex-gradle-start-0.1-all.jar

Note that you will have to pass the paths (and possibly other settings). In this
case I passed the paths to the project files. You can also use all the regular
basexhttp command-line arguments if you wish.

For example start the HTTP server on a different port:

    java -Dorg.basex.dbpath=basex/data
         -Dorg.basex.repopath=basex/repo 
         -Dorg.basex.webpath=basex/web
         -jar build/libs/basex-gradle-start-0.1-all.jar
         -h1234

The name of the jar is the name of the project. The version is set from within
`build.gradle`.

To connect to this server you could also use the same jar (from another shell
window):

    java -cp build/lib/basex-gradle-start-0.1-all.jar org.basex.BaseXClient

## Known issues

- Sometimes I cannot access the server with `console` from another shell. Run it with `-d` option and you'll see that it cannot acquire a lock
  
- Task `distZip` also packs `basex` directory but when running it it still uses the dir from the project. Need to do better config to set the paths.


## Contributors

- [xokomola](https://github.com/xokomola)
- [vincentml](https://github.com/vincentml)


## TODO

- Run only specific tests (`xqtest` always runs all tests)
- Better configuration
- Provide arguments for query tasks
- Packaging as WAR for Tomcat etc.
- Building XAR packages and managing module repository
- Backup and restore
