(:~
 : Common RESTXQ access points.
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
module namespace _ = 'dba/common';

import module namespace Request = 'http://exquery.org/ns/request';
import module namespace cons = 'dba/cons' at 'modules/cons.xqm';
import module namespace tmpl = 'dba/tmpl' at 'modules/tmpl.xqm';

(:~
 : Redirects to the start page.
 :)
declare
<<<<<<< HEAD
  %rest:path("dba")
function _:redirect(
) {
  web:redirect('dba/databases')
=======
  %rest:path("/dba")
function _:redirect(
) {
  web:redirect("/dba/databases")
>>>>>>> basex-8.2
};

(:~
 : Returns a file.
 : @param  $file  file or unknown path
 : @return rest response and binary file
 :)
declare
<<<<<<< HEAD
  %rest:path("dba/files/{$file=.+}")
=======
  %rest:path("/dba/static/{$file=.+}")
>>>>>>> basex-8.2
function _:file(
  $file as xs:string
) as item()+ {
  let $path := file:base-dir() || 'files/' || $file
  return (
    web:response-header(map { 'media-type': web:content-type($path) }),
    file:read-binary($path)
  )
};

(:~
 : Shows a page not found error.
 : @param  $unknown  unknown page
 : @return page
 :)
declare
<<<<<<< HEAD
  %rest:path("dba/{$unknown}")
=======
  %rest:path("/dba/{$unknown}")
>>>>>>> basex-8.2
  %output:method("html")
function _:any(
  $unknown  as xs:string
) as element(html) {
  cons:check(),
  tmpl:wrap(
    <tr>
      <td>
        <h3>Page not found!</h3>
        <ul>
          <li>Page: <code>dba/{ $unknown }</code></li>
          <li>Method: <code>{ Request:method() }</code></li>
        </ul>
      </td>
    </tr>
  )
};

(:~
 : Login error: redirects to the login page.
 :)
declare
  %rest:error("basex:login")
function _:error-login(
) {
  web:redirect("login")
};
