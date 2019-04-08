(:~
 : Queries page.
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
module namespace _ = 'dba/queries';

import module namespace cons = 'dba/cons' at '../modules/cons.xqm';
import module namespace html = 'dba/html' at '../modules/html.xqm';
import module namespace tmpl = 'dba/tmpl' at '../modules/tmpl.xqm';
import module namespace util = 'dba/util' at '../modules/util.xqm';

<<<<<<< HEAD
(:~ Top category :)
declare variable $_:CAT := 'queries';

(:~
 : Queries page.
 : @param  $query  input query
 : @param  $error  error string
 : @param  $info   info string
=======
(:~ Top category. :)
declare variable $_:CAT := 'queries';
(:~ Query file suffix. :)
declare variable $_:SUFFIX := '.xq';

(:~
 : Queries page.
 : @param  $error   error string
 : @param  $info    info string
>>>>>>> basex-8.2
 : @return HTML page
 :)
declare
  %rest:GET
<<<<<<< HEAD
  %rest:path("dba/queries")
  %rest:query-param("query",  "{$query}")
=======
  %rest:path("/dba/queries")
>>>>>>> basex-8.2
  %rest:query-param("error",  "{$error}")
  %rest:query-param("info",   "{$info}")
  %output:method("html")
function _:queries(
<<<<<<< HEAD
  $query  as xs:string?,
  $error  as xs:string?,
  $info   as xs:string?
) as element() {
  cons:check(),

  let $f := function($b) { "xquery('Please wait…', 'Query was successful.', " || $b || ");" }
  return tmpl:wrap(map { 'top': $_:CAT, 'info': $info, 'error': $error },
=======
  $error   as xs:string?,
  $info    as xs:string?
) as element() {
  cons:check(),

<<<<<<< HEAD
  let $f := function($b) { "editor('Please wait…', 'Query was successful.', " || $b || ");" }
  return tmpl:wrap(
=======
<<<<<<< HEAD
  let $f := function($b) { "editor('Please wait…', 'Query was successful.', " || $b || ");" }
  return tmpl:wrap(
=======
  tmpl:wrap(
>>>>>>> basex-8.4
>>>>>>> basex-8.3
    map {
      'top': $_:CAT, 'info': $info, 'error': $error,
      'css': 'codemirror/lib/codemirror.css',
      'scripts': ('editor.js', 'codemirror/lib/codemirror.js',
                  'codemirror/mode/xquery/xquery.js','codemirror/mode/xml/xml.js')
    },
>>>>>>> basex-8.2
    <tr>
      <td width='50%'>
        <table width='100%'>
          <tr>
<<<<<<< HEAD
            <td>
              <button id='run' onClick="{ $f(true()) }">Run</button>
              <select id='mode' onChange='{ $f(false()) }'>{
                ('Standard', 'Realtime', 'Updating') ! element option { . }
              }</select>
=======
            <td width='80%'>
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> basex-8.3
              <select id='mode' onchange='{ $f(false()) }'>{
                ('Standard', 'Realtime', 'Updating') ! element option { . }
              }</select>
              <button id='run' onclick="{ $f(true()) }">Run</button>
<<<<<<< HEAD
=======
=======
              <select id='mode'>{
                ('Read-Only', 'Updating') ! element option { . }
              }</select>
              <button id='run' onclick="evalQuery()"
                title='Ctrl-Enter'>Run</button>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
            </td>
            <td align='right'>
              <h2>Editor</h2>
            </td>
          </tr>
        </table>
<<<<<<< HEAD
        <textarea id='editor' rows='20' spellcheck='false' onkeyup="{ $f(false()) }">{
          $query
        }</textarea>
=======
<<<<<<< HEAD
        <textarea id='editor' name='editor' rows='20' spellcheck='false' onkeyup="{ $f(false()) }"/>
=======
<<<<<<< HEAD
        <textarea id='editor' name='editor' rows='20' spellcheck='false' onkeyup="{ $f(false()) }"/>
=======
        <textarea id='editor' name='editor' rows='20' spellcheck='false'/>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
        <table width='100%'>
          <tr>
            <td>
              <div align='right'>
                <form autocomplete='off' action='javascript:void(0);'>
                  <input id='file' name='file' placeholder='Name of query'
                         list='files' oninput='checkButtons()' onpropertychange='checkButtons()'/>
                  <datalist id='files'>{ _:files() ! element option { . } }</datalist>
                  <button type='submit' name='open' id='open' disabled='true'
                          onclick='openQuery()'>Open</button>
                  <button type='save' name='save' id='save' disabled='true'
                          onclick='saveQuery()'>Save</button>
                  <button type='delete' name='delete' id='delete' disabled='true'
                          onclick='deleteQuery()'>Delete</button>
                </form>
              </div>
            </td>
          </tr>
        </table>
>>>>>>> basex-8.2
        { html:focus('editor') }
      </td>
      <td width='50%'>
        <table width='100%'>
          <tr>
            <td align='right'>
              <h2>Result</h2>
            </td>
          </tr>
        </table>
<<<<<<< HEAD
        <textarea id='output' rows='20' readonly='' spellcheck='false'/>
=======
<<<<<<< HEAD
        <textarea id='output' rows='20' readonly='' spellcheck='false'/>
=======
<<<<<<< HEAD
        <textarea id='output' rows='20' readonly='' spellcheck='false'/>
=======
        <textarea name='output' id='output' rows='20' readonly='' spellcheck='false'/>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
        <script type="text/javascript">loadCodeMirror();</script>
>>>>>>> basex-8.2
      </td>
    </tr>
  )
};

(:~
 : Evaluates a query and returns the result.
 : @param  $query  query
 : @return result of query
 :)
declare
<<<<<<< HEAD
  %rest:path("dba/eval-query")
  %rest:query-param("query", "{$query}")
=======
  %rest:POST("{$query}")
  %rest:path("/dba/eval-query")
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
  %rest:single
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
  %output:method("text")
function _:eval-query(
  $query  as xs:string?
) as xs:string {
  cons:check(),
  util:query($query)
};

(:~
<<<<<<< HEAD
=======
 : Returns the contents of a query file.
 : @param  $name  name of query file (without suffix)
 : @return query string
 :)
declare
  %rest:path("/dba/open-query")
  %rest:query-param("name", "{$name}")
  %output:method("text")
function _:open-query(
  $name  as xs:string
) as xs:string {
  cons:check(),
  file:read-text(_:to-path($name))
};

(:~
 : Delete a query file and returns the names of stored queries.
 : @param  $name  name of query file (without suffix)
 : @return names of stored queries
 :)
declare
  %rest:path("/dba/delete-query")
  %rest:query-param("name", "{$name}")
  %output:method("text")
function _:delete-query(
  $name  as xs:string
) as xs:string {
  cons:check(),
  file:delete(_:to-path($name)),
  string-join(_:files(), '/')
};

(:~
 : Saves a query file and returns the list of stored queries.
 : @param  $name   name of query file (without suffix)
 : @param  $query  query string
 : @return names of stored queries
 :)
declare
  %rest:POST("{$query}")
  %rest:path("/dba/save-query")
  %rest:query-param("name", "{$name}")
  %output:method("text")
function _:save-query(
  $name   as xs:string,
  $query  as xs:string
) as xs:string {
  cons:check(),
  file:write-text(_:to-path($name), $query),
  string-join(_:files(), '/')
};

(:~
>>>>>>> basex-8.2
 : Runs an updating query.
 : @param  $query  query
 :)
declare
  %updating
<<<<<<< HEAD
  %rest:path("dba/update-query")
  %rest:query-param("query", "{$query}")
=======
<<<<<<< HEAD
  %rest:path("/dba/update-query")
  %rest:query-param("query", "{$query}")
=======
  %rest:POST("{$query}")
  %rest:path("/dba/update-query")
>>>>>>> basex-8.3
>>>>>>> basex-8.2
  %output:method("text")
function _:update-query(
  $query  as xs:string?
) {
  cons:check(),
  util:update-query($query)
};

(:~
 : Returns the options for evaluating a query.
 : @return options
 :)
<<<<<<< HEAD
declare %private function _:query-options() {
  "map { 'timeout':" || $cons:TIMEOUT ||
       ",'memory':" || $cons:MEMORY ||
       ",'permission':'" || $cons:PERMISSION || "' }"
=======
declare %private function _:query-options() as xs:string {
  "map { 'timeout':" || $cons:OPTION($cons:K-TIMEOUT) ||
       ",'memory':" || $cons:OPTION($cons:K-MEMORY) ||
       ",'permission':'" || $cons:OPTION($cons:K-PERMISSION) || "' }"
};

(:~
 : Returns a normalized file path for the specified file name.
 : @param  $name  file name
 : @return file path
 :)
declare %private function _:to-path(
  $name  as xs:string
) as xs:string {
  $cons:DBA-DIR || translate($name, '\/:*?"<>|', '---------') || $_:SUFFIX
};

(:~
 : Returns the names of all files.
 : @return list of files
 :)
declare %private function _:files() as xs:string* {
  for $file in file:list($cons:DBA-DIR, false(), '*' || $_:SUFFIX)
  return replace($file, $_:SUFFIX || '$', '')
>>>>>>> basex-8.2
};
