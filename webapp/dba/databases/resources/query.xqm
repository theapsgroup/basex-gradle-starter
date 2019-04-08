(:~
 : Query resources.
 :
<<<<<<< HEAD:webapp/dba/databases/resources/query.xqm
 : @author Christian Grün, BaseX GmbH, 2014-15
=======
 : @author Christian Grün, BaseX Team, 2014-16
>>>>>>> basex-8.4:webapp/dba/databases/resources/query.xqm
 :)
module namespace _ = 'dba/databases';

import module namespace cons = 'dba/cons' at '../../modules/cons.xqm';
import module namespace util = 'dba/util' at '../../modules/util.xqm';

(:~
 : Runs a query on a document and returns the result as string.
 : @param  $name      name of database
 : @param  $resource  resource
 : @param  $query     query
 : @return result string
 :)
declare
  %rest:POST("{$query}")
  %rest:path("/dba/query-resource")
  %rest:query-param("name",     "{$name}")
  %rest:query-param("resource", "{$resource}")
  %output:method("text")
function _:query-resource(
  $name      as xs:string,
  $resource  as xs:string,
  $query     as xs:string
) as xs:string {
  cons:check(),
  let $query := if($query) then $query else '.'
  return util:query($query, "'': db:open($name, $resource)", map {
    'name': $name, 'resource': $resource
  })
};
