(:~
 : Drop databases.
 :
<<<<<<< HEAD
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
<<<<<<< HEAD
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
<<<<<<< HEAD
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
 : @author Christian Grün, BaseX Team, 2014-16
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
 :)
module namespace _ = 'dba/databases';

import module namespace cons = 'dba/cons' at '../modules/cons.xqm';
import module namespace util = 'dba/util' at '../modules/util.xqm';

(:~ Top category :)
declare variable $_:CAT := 'logs';

(:~
 : Deletes database logs.
 : @param  $names  names of log files
 :)
declare
  %rest:GET
<<<<<<< HEAD
  %rest:path("dba/delete-logs")
=======
  %rest:path("/dba/delete-logs")
>>>>>>> basex-8.2
  %rest:query-param("name", "{$names}")
  %output:method("html")
function _:drop(
  $names  as xs:string*
) {
  cons:check(),
  try {
    util:eval("$n ! admin:delete-logs(.)", map { 'n': $names }),
    web:redirect($_:CAT, map { 'info': 'Deleted logs: ' || count($names) })
  } catch * {
    web:redirect($_:CAT, map { 'error': $err:description })
  }
};
