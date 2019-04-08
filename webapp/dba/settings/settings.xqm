(:~
 : Settings page.
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
module namespace _ = 'dba/settings';

import module namespace Request = 'http://exquery.org/ns/request';
import module namespace cons = 'dba/cons' at '../modules/cons.xqm';
import module namespace tmpl = 'dba/tmpl' at '../modules/tmpl.xqm';

<<<<<<< HEAD
declare option query:write-lock "settings";
=======
declare option query:write-lock 'settings';
>>>>>>> basex-8.2

(:~ Top category :)
declare variable $_:CAT := 'settings';

(:~
 : Settings page.
 :)
declare
  %rest:GET
<<<<<<< HEAD
  %rest:path("dba/settings")
=======
  %rest:path("/dba/settings")
>>>>>>> basex-8.2
  %output:method("html")
function _:settings(
) as element() {
  cons:check(),

  tmpl:wrap(map { 'top': $_:CAT },
    <tr>
      <td>
        <form action="settings" method="post">
          <h2>Settings » <button>Save</button></h2>
          <table>
            <tr>
              <td colspan='2'><h3>Querying</h3></td>
<<<<<<< HEAD
            </tr>
            <tr>
              <td><b>TIMEOUT:</b></td>
              <td><input name="timeout" type="number" value="{ $cons:TIMEOUT }"/>
                <span class='note'> &#xa0;
                  …query timeout (seconds)
                </span>
              </td>
            </tr>
            <tr>
              <td><b>MEMORY:</b></td>
              <td><input name="memory" type="number" value="{ $cons:MEMORY }"/>
                <span class='note'> &#xa0;
                  …memory limit (mb) during query execution
                </span>
              </td>
            </tr>
            <tr>
              <td><b>MAXCHARS:</b></td>
              <td><input name="maxchars" type="number" value="{ $cons:MAX-CHARS }"/>
                <span class='note'> &#xa0;
                  …maximum number of characters in query results
                </span>
              </td>
            </tr>
            <tr>
              <td><b>MAXROWS:</b></td>
              <td><input name="maxrows" type="number" value="{ $cons:MAX-ROWS }"/>
                <span class='note'> &#xa0;
                  …maximum number of displayed table rows
                </span>
              </td>
=======
>>>>>>> basex-8.2
            </tr>
            {
              for $option in element options {
                element { $cons:K-TIMEOUT } { '…query timeout (seconds)' },
                element { $cons:K-MEMORY } { '…memory limit (mb) during query execution' },
                element { $cons:K-MAX-CHARS } { '…maximum number of characters in query results' },
                element { $cons:K-MAX-ROWS } { '…maximum number of displayed table rows' }
              }/*
              let $key := name($option)
              return <tr>
                <td><b>{ upper-case($key) }:</b></td>
                <td><input name="{ $key }" type="number" value="{ $cons:OPTION($key) }"/>
                  <span class='note'> &#xa0; { $option/text() }</span>
                </td>
              </tr>
            }
            <tr>
              <td><b>PERMISSION:</b></td>
              <td>
                <select name="permission">{
<<<<<<< HEAD
                  for $p in $cons:PERMISSIONS
                  return element option { attribute selected { }[$p = $cons:PERMISSION], $p }
                }</select>
                <span class='note'> &#xa0;
                  …for running queries
                </span>
=======
                  let $pm := $cons:OPTION($cons:K-PERMISSION)
                  for $p in $cons:PERMISSIONS
                  return element option { attribute selected { }[$p = $pm], $p }
                }</select>
                <span class='note'> &#xa0; …for running queries</span>
>>>>>>> basex-8.2
              </td>
            </tr>
          </table>
        </form>
      </td>
    </tr>
  )
};

(:~
 : Saves the settings.
 :)
declare
  %rest:POST
<<<<<<< HEAD
  %rest:path("dba/settings")
=======
  %rest:path("/dba/settings")
>>>>>>> basex-8.2
  %output:method("html")
function _:settings-save(
) {
  cons:check(),

<<<<<<< HEAD
  let $config := doc($cons:CONFIG-XML)/config update (
    for $key in Request:parameter-names()
    (: skip empty values :)
    for $value in Request:parameter($key)[.]
    return replace value of node *[name() = $key] with $value
  )
  return (
    file:write($cons:CONFIG-XML, $config),
=======
  let $config := element config {
    for $key in Request:parameter-names()
    return element { $key } { Request:parameter($key) }
  }
  return (
    file:write($cons:DBA-SETTINGS-FILE, $config),
>>>>>>> basex-8.2
    web:redirect("settings")
  )
};
