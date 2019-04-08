(:~
 : Resource handling.
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

import module namespace cons = 'dba/cons' at '../../modules/cons.xqm';

(:~ Top category :)
declare variable $_:CAT := 'databases';
(:~ Sub category :)
declare variable $_:SUB := 'database';

(:~
 : Redirects to the specified action.
 : @param  $action    action to perform
 : @param  $name      name of resource
 : @param  $resource  resource
 :)
declare
  %rest:POST
  %rest:path("dba/resource")
  %rest:form-param("action",   "{$action}")
  %rest:form-param("name",     "{$name}")
  %rest:form-param("resource", "{$resource}")
function _:resource(
  $action    as xs:string,
  $name      as xs:string,
  $resource  as xs:string*
) {
  cons:check(),
  if($action = ('rename', 'replace')) then (
    web:redirect($action, map { 'name': $name, 'resource': $resource })
  ) else (
    (: download :)
    web:redirect($action || '/' || file:name($resource), map { 'name': $name, 'resource': $resource})
  )
};
