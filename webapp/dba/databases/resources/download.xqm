(:~
 : Download resources.
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

import module namespace cons = 'dba/cons' at '../../modules/cons.xqm';
import module namespace util = 'dba/util' at '../../modules/util.xqm';

(:~
 : Downloads a resource.
 : @param  $name      database
 : @param  $resource  resource
 : @param  $file      file name (ignored)
 : @return rest response and file content
 :)
declare
  %rest:path("/dba/download/{$file}")
  %rest:query-param("name",     "{$name}")
  %rest:query-param("resource", "{$resource}")
function _:download(
  $name      as xs:string,
  $resource  as xs:string,
  $file      as xs:string
) as item()+ {
  cons:check(),
  try {
    let $options := map { 'n': $name, 'r': $resource }
    let $raw := util:eval("db:is-raw($n, $r)", $options)
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> basex-8.3
    return (
      <rest:response>
        <output:serialization-parameters>
          <output:method value='{ if($raw) then "raw" else "xml" }'/>
          <output:media-type value='{ util:eval("db:content-type($n, $r)", $options) }'/>
        </output:serialization-parameters>
      </rest:response>,
<<<<<<< HEAD
=======
=======
    let $ct := util:eval("db:content-type($n, $r)", $options)
    return (
      web:response-header(map { 'media-type': $ct }),
>>>>>>> basex-8.4
>>>>>>> basex-8.3
      util:eval(if($raw) then "db:retrieve($n, $r)" else "db:open($n, $r)", $options)
    )
  } catch * {
    <rest:response>
      <http:response status="400" message="{ $err:description }"/>
    </rest:response>
  }
};

(:~
 : Downloads a database backup.
 : @param  $backup  name of backup file (ignored)
 : @return zip file
 :)
declare
  %rest:path("/dba/backup/{$backup}")
<<<<<<< HEAD
  %output:method("raw")
=======
<<<<<<< HEAD
  %output:method("raw")
=======
>>>>>>> basex-8.4
>>>>>>> basex-8.3
  %output:media-type("application/octet-stream")
function _:download(
  $backup  as xs:string
) {
  cons:check(),
  util:eval("file:read-binary(db:system()/globaloptions/dbpath || '/' || $b)",
    map { 'b': $backup }
  )
};
