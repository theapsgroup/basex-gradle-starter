(:~
 : Code for logging in and out.
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
module namespace _ = 'dba/login';

import module namespace Session = 'http://basex.org/modules/session';
import module namespace cons = 'dba/cons' at 'modules/cons.xqm';
import module namespace html = 'dba/html' at 'modules/html.xqm';
import module namespace tmpl = 'dba/tmpl' at 'modules/tmpl.xqm';

(:~
 : Login page.
 : @param  $name   user name
 : @param  $url    url
 : @param  $error  error string 
 : @return page
 :)
declare
  %rest:path("/dba/login")
  %rest:query-param("name" , "{$name}")
  %rest:query-param("url",   "{$url}")
  %rest:query-param("error", "{$error}")
  %output:method("html")
function _:welcome(
  $name   as xs:string?,
  $url    as xs:string?,
  $error  as xs:string?
) as element(html) {
  tmpl:wrap(map { 'error': $error },
    <tr>
      <td>
        <form action="login-check" method="post">
          <div class='note'>
            Enter your admin credentials:
          </div>
          <div class='small'/>
          <table>
            <tr>
              <td><b>Name:</b></td>
              <td>
                <input size="30" name="name" value="{ $name }" id="user"/>
                { html:focus('user') }
              </td>
            </tr>
            <tr>
              <td><b>Password:</b></td>
              <td>
                <input size="30" type="password" name="pass"/>
                { html:button('login', 'Login') }
              </td>
            </tr>
            <tr>
              <td colspan='2'>
              <div class='small'/>
              <div class='note'>
                Enter a <code>host:port</code> combination if you want to connect<br/>
                to a remote BaseX server instance:
              </div>
              <div class='small'/>
              </td>
            </tr>
            <tr>
              <td><b>Address:</b></td>
              <td>
                <input size="30" name="url" value="{ $url }"/>
              </td>
            </tr>
          </table>
        </form>
      </td>
    </tr>
  )
};

(:~
 : Checks the user input and redirects to the start or login page.
 : @param  $name  user name
 : @param  $pass  password
 : @param  $url   url
 : @return redirect
 :)
declare
  %rest:path("/dba/login-check")
  %rest:query-param("name", "{$name}")
  %rest:query-param("pass", "{$pass}")
  %rest:query-param("url",  "{$url}")
function _:login(
  $name  as xs:string,
  $pass  as xs:string,
  $url   as xs:string
) as element(rest:response) {
  if($url) then (
    if(matches($url, '^.+:\d+/?$')) then (
      let $host := replace($url, ':.*$', '')
      let $port := replace($url, '^.*:|/$', '')
      return try {
        let $id := client:connect($host, xs:integer($port), $name, $pass)
        return (
          try {
            (: check if user can perform admin operations :)
            prof:void(client:query($id, 'admin:sessions()')),
            _:accept($name, $pass, $host, $port)
          } catch bxerr:BASX0001 {
            _:reject($name, $url, 'Admin credentials required.')
          },
          client:close($id)
        )
      } catch * {
        _:reject($name, $url, $err:description)
      }
    ) else (
      _:reject($name, $url, 'Please check the syntax of your URL.')
    )
  ) else (
<<<<<<< HEAD
    let $user := user:list-details($name)
=======
<<<<<<< HEAD
    let $user := user:list-details($name)
=======
<<<<<<< HEAD
    let $user := user:list-details($name)
=======
    let $user := user:list-details()[@name = $name]
>>>>>>> basex-8.5
>>>>>>> basex-8.4
>>>>>>> basex-8.3
    let $pw := $user/password[@algorithm = 'salted-sha256']
    let $salt := $pw/salt
    let $hash := $pw/hash
    let $user-hash := lower-case(xs:string(xs:hexBinary(hash:sha256($salt || $pass))))
    return if($hash = $user-hash) then (
      if($user/@permission eq 'admin') then (
        _:accept($name, $pass, '', '')
      ) else (
        _:reject($name, $url, 'Admin credentials required.')
      )
    ) else (
      _:reject($name, $url, 'Please check your login data.')
    )
  )
};

(:~
 : Ends a session and redirects to the login page.
 : @return redirect
 :)
declare %rest:path("/dba/logout") function _:logout(
) as element(rest:response) {
  let $name := $cons:SESSION/name
  let $url := string-join($cons:SESSION/(host, port), ':')
  return (
<<<<<<< HEAD
    admin:write-log('User was logged out: ' || $name),
    Session:delete($cons:SESSION-KEY),
    Session:close(),
=======
<<<<<<< HEAD
    admin:write-log('User was logged out: ' || $name),
    Session:delete($cons:SESSION-KEY),
    Session:close(),
=======
    admin:write-log('DBA user was logged out: ' || $name),
    Session:delete($cons:SESSION-KEY),
<<<<<<< HEAD
    Session:close(),
=======
>>>>>>> basex-8.5
>>>>>>> basex-8.4
>>>>>>> basex-8.3
    web:redirect("/dba/login", map { 'nane': $name, 'url': $url })
  )
};

(:~
 : Accepts a user and redirects to the main page.
 : @param  $name  entered user name
 : @return redirect
 :)
declare %private function _:accept(
  $name  as xs:string,
  $pass  as xs:string,
  $host  as xs:string,
  $port  as xs:string
) {
  Session:set($cons:SESSION-KEY,
<<<<<<< HEAD
    element session {
=======
<<<<<<< HEAD
    element session {
=======
<<<<<<< HEAD
    element session {
=======
    element dba-session {
>>>>>>> basex-8.5
>>>>>>> basex-8.4
>>>>>>> basex-8.3
      element name { $name },
      element pass { $pass },
      element host { $host }[$host],
      element port { $port }[$port]
    }
  ),
<<<<<<< HEAD
  admin:write-log('User was logged in: ' || $name),
=======
<<<<<<< HEAD
  admin:write-log('User was logged in: ' || $name),
=======
  admin:write-log('DBA user was logged in: ' || $name),
>>>>>>> basex-8.4
>>>>>>> basex-8.3
  web:redirect("databases")
};

(:~
 : Rejects a user and redirects to the login page.
 : @param  $name     entered user name
 : @param  $url      entered url
 : @param  $message  error message
 : @return redirect
 :)
declare %private function _:reject(
  $name     as xs:string,
  $url      as xs:string,
  $message  as xs:string
) as element(rest:response) {
<<<<<<< HEAD
  admin:write-log('Login was denied: ' || $name),
=======
<<<<<<< HEAD
  admin:write-log('Login was denied: ' || $name),
=======
  admin:write-log('DBA login was denied: ' || $name),
>>>>>>> basex-8.4
>>>>>>> basex-8.3
  web:redirect("login", map { 'name': $name, 'url': $url, 'error': $message })
};
