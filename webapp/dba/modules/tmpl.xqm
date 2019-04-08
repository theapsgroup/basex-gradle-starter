(:~
 : Template functions.
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
module namespace tmpl = 'dba/tmpl';

import module namespace cons = 'dba/cons' at 'cons.xqm';

(:~
 : Extends the specified table rows with the page template.
 : @param  $tr  tr elements
 : @return HTML page
 :)
declare function tmpl:wrap(
  $tr  as element(tr)+
) as element(html) {
  tmpl:wrap(map{ }, $tr)
};

(:~
 : Extends the specified table rows with the page template.
 : The following options can be specified:
 : <ul>
 :   <li><b>top</b>: current top category</li>
 :   <li><b>error</b>: error string</li>
 :   <li><b>info</b>: info string</li>
 : </ul>
 : @param  $options  options
 : @param  $tr       tr elements
 : @return page
 :)
declare function tmpl:wrap(
  $options  as map(*),
  $tr       as element(tr)+
) as element(html) {
  <html>
    <head>
      <meta charset="utf-8"/>
      <title>Database Administration</title>
      <meta name="description" content="Database Administration"/>
<<<<<<< HEAD
      <meta name="author" content="BaseX Team, 2014-15"/>
=======
<<<<<<< HEAD
      <meta name="author" content="BaseX Team, 2014-15"/>
=======
      <meta name="author" content="BaseX Team, 2014-16"/>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
      <link rel="stylesheet" type="text/css" href="static/style.css"/> 
      { $options('css') ! <link rel="stylesheet" type="text/css" href="static/{.}"/> }
      <script type="text/javascript" src="static/js.js"/>
      { $options('scripts') ! <script type="text/javascript" src="static/{.}"/> }
    </head>
    <body>
<<<<<<< HEAD
      <div class="right"><img style='padding-left:10px;padding-bottom:10px;' src="static/basex.svg"/></div>
=======
<<<<<<< HEAD
      <div class="right"><img style='padding-left:10px;padding-bottom:10px;' src="static/basex.svg"/></div>
=======
<<<<<<< HEAD
      <div class="right"><img style='padding-left:10px;padding-bottom:10px;' src="static/basex.svg"/></div>
=======
      <div class="right"><img style='padding-left:10px;padding-bottom:10px;'
        src="static/basex.svg"/></div>
>>>>>>> basex-8.5
>>>>>>> basex-8.4
>>>>>>> basex-8.3
      <h1>Database Administration</h1>
      <div>{
        let $emph := <span>{(element b {
          attribute id { 'info' },
          $options('error')[.] ! (attribute class { 'error' }, .),
          $options('info')[.] ! (attribute class { 'info' }, .),
          ' '
        })}</span>
        return try {
          cons:check(),
          let $cats := 
            let $top := $options('top')
<<<<<<< HEAD
            for $cat in ('Databases', 'Queries', 'Logs', 'Users', 'Files', 'Settings', 'Logout')
            let $link := <a href="{ lower-case($cat) }">{ $cat }</a>
=======
<<<<<<< HEAD
            for $cat in ('Databases', 'Queries', 'Logs', 'Users', 'Files', 'Settings', 'Logout')
            let $link := <a href="{ lower-case($cat) }">{ $cat }</a>
=======
<<<<<<< HEAD
            for $cat in ('Databases', 'Queries', 'Logs', 'Users', 'Files', 'Settings', 'Logout')
            let $link := <a href="{ lower-case($cat) }">{ $cat }</a>
=======
            for $cat in ('Databases', 'Queries', 'Logs', 'Jobs &amp; Users', 'Files',
              'Settings', 'Logout')
            let $link := <a href="{ lower-case(replace($cat, ' &amp; ', '-')) }">{ $cat }</a>
>>>>>>> basex-8.5
>>>>>>> basex-8.4
>>>>>>> basex-8.3
            return if($top = $link) then (
              <b>{ $link }</b>
            ) else (
              $link
            )
          return (head($cats), tail($cats) ! (' | ', .)),
          (1 to 4) ! '&#x2000;',
          $emph
        } catch basex:login {
          $emph
        },
        <span style='float:right'>User: <b>{
          $cons:SESSION/name/text()
        }</b></span>[$cons:SESSION]
      }</div>
      <hr/>
      <div class='small'/>
      <table width='100%'>{ $tr }</table>
      <hr/>
<<<<<<< HEAD
      <div class='right'><sup>BaseX Team, 2014-15</sup></div>
=======
<<<<<<< HEAD
      <div class='right'><sup>BaseX Team, 2014-15</sup></div>
=======
      <div class='right'><sup>BaseX Team, 2014-16</sup></div>
>>>>>>> basex-8.4
>>>>>>> basex-8.3
      <div class='small'/>
      <script type="text/javascript">(function(){{ buttons(); }})();</script>
    </body>
  </html>
};
