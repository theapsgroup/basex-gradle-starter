# basex-gradle-starter

A simple build script template for using [BaseX](basex.org) (8.0) with Gradle. Also adds Saxon 9.6 so you can use XSLT 2.0 out of the gate.

Caution: this is still in very early stage.

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
- `http` and `httpstop`

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


## Running faster with "daemon"

And by using the `--daemon` option you can also avoid a lot of the Java startup
tax.

    gradlew --daemon query


## Where to put XQuery code?

For now the easiest way is to add your code under `basex/webapp` (or wherever
you point `org.basex.WEBPATH` property in `gradle.properties` to).

## Run tests automatically

You can run all tests using the `xqtest` task. But you can also start the `watch`
task which will watch all `*.xqm` files under `basex/webapp/test`. Now everytime
you save an XQuery test file it is automatically run again.

    > gradlew watch

    :watch
    Starting............ OK
    
    --------------------------------------------------------------------------------
     Sun Feb 22 18:37:50 CET 2015
     File "basex/webapp/test/test.xqm" was changed.
    --------------------------------------------------------------------------------
    :xqtest
    <testsuites time="PT0.338S">
    Result: 2 tests, 1 failure, 0 errors, 0 skipped.
      <testsuite name="file:/basex-gradle-starter/basex/webapp/test/test.xqm" 
        time="PT0.011S" tests="2" failures="1" errors="0" skipped="0">
        <testcase name="pass" time="PT0.006S"/>
        <testcase name="fail" time="PT0.002S">
          <failure line="10" column="24">
            <returned item="1" type="xs:integer">1</returned>
            <expected item="1" type="xs:integer">3</expected>
            <info>Item 1: 3 expected, 1 returned.</info>
          </failure>
        </testcase>
      </testsuite>
    </testsuites>
    
    BUILD SUCCESSFUL
    
    Total time: 1.201 secs
    
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

## Why are so many dependencies listed, aren't they part of the BaseX POM?

This is a Gradle limitation. Gradle doesn't follow transitive dependencies that
are declared as optional. This makes sense but it's a bit unfortunate that to
include these optional libraries they have to be explicitly listed in the build
script.

## Known issues

- Client task (`client`) prints build message in between input.

- Sometimes I cannot access the server with `client` from another shell. Run it
  with `-d` option and you'll see that it cannot acquire a lock
  
- Task `distZip` also packs `basex` directory but when running it it still uses
  the dir from the project. Need to do better config to set the paths.

- With Gradle 2.3 the `watch` task doesn't talk to STDOUT anymore so we do
  not see test output anymore.

## TODO

- Better configuration
- Provide arguments for query tasks
- Packaging as WAR for Tomcat etc.
- Building XAR packages and managing module repository
- Backup and restore
