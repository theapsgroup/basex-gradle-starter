(:~
 : Drop databases.
 :
<<<<<<< HEAD
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
<<<<<<< HEAD
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
 : @author Christian Grün, BaseX Team, 2014-16
>>>>>>> basex-8.4
>>>>>>> basex-8.3
 :)
module namespace _ = 'dba/databases';

import module namespace cons = 'dba/cons' at '../modules/cons.xqm';
import module namespace util = 'dba/util' at '../modules/util.xqm';

(:~ Top category :)
declare variable $_:CAT := 'databases';

(:~
 : Drops databases.
 : @param  $names  names of databases
 :)
declare
  %updating
  %rest:GET
  %rest:path("/dba/drop-db")
  %rest:query-param("name", "{$names}")
  %output:method("html")
function _:drop(
  $names  as xs:string*
) {
  cons:check(),
  try {
    util:update("$n ! db:drop(.)", map { 'n': $names }),
    db:output(web:redirect($_:CAT, map { 'info': 'Dropped databases: ' || count($names) }))
  } catch * {
    db:output(web:redirect($_:CAT, map { 'error': $err:description }))
  }
};
