(:~
 : Logging page.
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
module namespace _ = 'dba/logs';

import module namespace cons = 'dba/cons' at '../modules/cons.xqm';
import module namespace html = 'dba/html' at '../modules/html.xqm';
import module namespace tmpl = 'dba/tmpl' at '../modules/tmpl.xqm';
import module namespace util = 'dba/util' at '../modules/util.xqm';

(:~ Top category :)
declare variable $_:CAT := 'logs';

(:~
 : Logging page.
 : @param  $sort     table sort key
 : @param  $name     name (date) of log file
 : @param  $loglist  search term for log list
 : @param  $logs     search term for logs
 : @param  $error    error string
 : @param  $info     info string
 : @return page
 :)
declare
  %rest:GET
<<<<<<< HEAD
  %rest:path("dba/logs")
=======
  %rest:path("/dba/logs")
>>>>>>> basex-8.2
  %rest:query-param("sort",    "{$sort}", "")
  %rest:query-param("name",    "{$name}")
  %rest:query-param("loglist", "{$loglist}")
  %rest:query-param("logs",    "{$logs}")
  %rest:query-param("error",   "{$error}")
  %rest:query-param("info",    "{$info}")
  %output:method("html")
function _:logs(
  $sort     as xs:string,
  $name     as xs:string?,
  $loglist  as xs:string?,
  $logs     as xs:string?,
  $error    as xs:string?,
  $info     as xs:string?
) as element(html) {
  cons:check(),

  let $loglists := _:loglist($sort, $loglist)
  let $error := if($loglists) then $error else $cons:DATA-ERROR
  return tmpl:wrap(map { 'top': $_:CAT, 'info': $info, 'error': $error },
    <tr>
      <td width='230'>
        <form action="javascript:void(0);">
          <h2>{ if($name) then <a href="{ $_:CAT }">Logs</a> else 'Logs' }:
            <input size="14" name="loglist" id="loglist" value="{ $loglist }"
<<<<<<< HEAD
              onkeyup="logslist('Please wait…', 'Query was successful.');"/>
=======
<<<<<<< HEAD
              onkeyup="logslist('Please wait…', 'Query was successful.');"/>
=======
              placeholder="regular expression"
<<<<<<< HEAD
              onkeyup="logslist('Please wait…', 'Query was successful.');"/>
=======
              onkeyup="logList();"/>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
          </h2>
        </form>
        <form action="{ $_:CAT }" method="post" class="update" autocomplete="off">
          <input type='hidden' name='name' id='name' value='{ $name }'/>
          <input type='hidden' name='sort' id='sort' value='{ $sort }'/>
          <div id='list'>{ $loglists }</div>
        </form>
      </td>
      <td class='vertical'/>
      <td>{
        if($name) then (
          <h3>
            { $name }:
            <input size="40" id="logs" value="{ ($loglist, $logs)[1] }"
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
              placeholder="regular expression"
<<<<<<< HEAD
>>>>>>> basex-8.3
>>>>>>> basex-8.2
              onkeyup="logentries('Please wait…', 'Query was successful.');"/>
          </h3>,
          <div id='output'/>,
          <script type="text/javascript">(function(){{ logentries('', ''); }})();</script>
<<<<<<< HEAD
=======
<<<<<<< HEAD
=======
=======
              onkeyup="logEntries();"/>
          </h3>,
          <div id='output'/>,
          <script type="text/javascript">(function(){{ logEntries(); }})();</script>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
        ) else (),
        html:focus(if($name) then 'logs' else 'loglist')
      }</td>
    </tr>
  )
};

(:~
 : Returns log entries of a specific log file.
<<<<<<< HEAD
=======
<<<<<<< HEAD
>>>>>>> basex-8.2
 : @param  $names    name of selected log files
 : @param  $sort     table sort key
 : @param  $loglist  loglist
 : @param  $query    query
 : @return html elements
 :)
declare
  %rest:POST
<<<<<<< HEAD
  %rest:path("dba/log")
  %rest:query-param("name",    "{$name}")
  %rest:query-param("sort",    "{$sort}")
  %rest:query-param("loglist", "{$loglist}")
  %rest:query-param("query",   "{$query}")
  %output:method("html")
function _:query(
=======
=======
 : @param  $query    query
 : @param  $names    name of selected log files
 : @param  $sort     table sort key
 : @param  $loglist  loglist
 : @return html elements
 :)
declare
  %rest:POST("{$query}")
>>>>>>> basex-8.3
  %rest:path("/dba/log")
  %rest:query-param("name",    "{$name}")
  %rest:query-param("sort",    "{$sort}")
  %rest:query-param("loglist", "{$loglist}")
<<<<<<< HEAD
  %rest:query-param("query",   "{$query}")
  %output:method("html")
function _:query(
=======
  %output:method("html")
<<<<<<< HEAD
function _:query(
=======
  %rest:single
function _:log(
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
  $name     as xs:string,
  $sort     as xs:string?,
  $query    as xs:string?,
  $loglist  as xs:string?
) as element()* {
  cons:check(),

  let $logs := try {
    util:eval("admin:logs($n, true())[matches(., $q, 'i')]",
      map { 'n': $name, 'q': $query }
    )
  } catch * { () }

  where $logs
  let $entries := $logs !
    <e t='{ @time }' a='{ @address }' u='{ @user}' p='{ @type }' m='{ @ms }' d='{ . }'/>
  let $headers := (
    <t type='time' order='desc'>Time</t>,
    <a>Address</a>,
    <u>User</u>,
    <p>Type</p>,
    <m type='decimal' order='desc'>ms</m>,
    <d>{ html:label($entries, ('Log Entry', 'Log Entries')) }</d>
  )
  return html:table($entries, $headers, (),
    map { 'name': $name, 'loglist': $loglist, 'logs': $query }, $sort)
};

(:~
 : Returns log data.
 : @param  $sort   table sort key
 : @param  $query  query
 : @return html elements
 :)
declare
<<<<<<< HEAD
  %rest:POST
  %rest:path("dba/loglist")
  %rest:query-param("sort",  "{$sort}")
  %rest:query-param("query", "{$query}")
  %output:method("html")
=======
<<<<<<< HEAD
  %rest:POST
  %rest:path("/dba/loglist")
  %rest:query-param("sort",  "{$sort}")
  %rest:query-param("query", "{$query}")
  %output:method("html")
=======
  %rest:POST("{$query}")
  %rest:path("/dba/loglist")
  %rest:query-param("sort",  "{$sort}")
  %output:method("html")
<<<<<<< HEAD
=======
  %rest:single
>>>>>>> basex-8.4
>>>>>>> basex-8.3
>>>>>>> basex-8.2
function _:loglist(
  $sort   as xs:string?,
  $query  as xs:string?
) as element()* {
  cons:check(),

  let $logs := try {
    util:eval("for $a in admin:logs()
      let $n := $a/(@date,text())/string()
      where not($query) or (some $a in admin:logs($n) satisfies matches($a, $query, 'i'))
      order by $n descending
      return $a", map { 'query': $query }
    )
  } catch * { () }
  where $logs
  let $entries :=
    (: legacy (7.8.1): $a/@date :)
    for $a in $logs
    order by $a descending
    (: legacy (7.8.1): $a/@date :)
    return <e name='{ ($a/(@date,text())) }' size='{ $a/@size }'/>
  let $headers := (
    <name>{ html:label($entries, ('Log', 'Logs')) }</name>,
    <size type='bytes'>Size</size>
  )
  let $buttons := html:button('delete-logs', 'Delete', true())
  let $link := function($value) { $_:CAT }
  return html:table($entries, $headers, $buttons,
    map { 'sort': $sort, 'loglist': $query }, (), $link)
};

(:~
 : Redirects to the specified action.
 : @param  $action  action to perform
 : @param  $names   names of selected databases
 :)
declare
  %rest:POST
  %rest:path("dba/logs")
  %rest:query-param("action", "{$action}")
  %rest:query-param("name",   "{$names}")
  %output:method("html")
function _:action(
  $action  as xs:string,
  $names   as xs:string*
) {
  web:redirect($action, map { 'name': $names[.], 'redirect': $_:CAT })
};
