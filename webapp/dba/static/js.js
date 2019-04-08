function buttons() {
  var forms = document.getElementsByTagName("form");
  for(var f = 0; f < forms.length; f++) {
    var form = forms[f];
    if(form.className != 'update') continue;

    var inputs = form.getElementsByTagName("input");
    var c = 0;
    for(var i = 0; i < inputs.length; i++) {
      if(inputs[i].type == "checkbox" && inputs[i].checked) c++;
    }
    var buttons = form.getElementsByTagName("button");
    for(var i = 0; i < buttons.length; i++) {
      var button = buttons[i], n = button.className, s = button.value, e = !button.disabled;
      if(n == 'global') continue;

      if(s == "optimize" || s == "optimize-all" || s == "drop-backup" ||
<<<<<<< HEAD
         s == "drop-db" || s == "drop-pattern" || s == "drop-user" ||
         s == "kill-session" || s == "restore" || s == "backup" || s == "delete" ||
         s == "delete-files" || s == "delete-logs" || s == "kill") {
=======
<<<<<<< HEAD
         s == "drop-db" || s == "drop-pattern" || s == "drop-user" ||
         s == "kill-session" || s == "restore" || s == "backup" || s == "delete" ||
         s == "delete-files" || s == "delete-logs" || s == "kill") {
=======
         s == "drop-db" || s == "drop-pattern" || s == "drop-user" || s == "stop-job" ||
         s == "kill-session" || s == "restore" || s == "backup" || s == "delete" ||
         s == "delete-files" || s == "delete-logs" || s == "kill-session") {
>>>>>>> basex-8.5
>>>>>>> basex-8.4
        e = c > 0;
      }
      button.disabled = !e;
    }
  }
};

function setInfo(message) {
  setText(message, 'info');
};

function setWarning(message) {
  setText(message, 'warning');
};

function setError(message) {
  setText(message.replace(/Stack Trace:.*/, ''), 'error');
};

function setText(message, type) {
  var i = document.getElementById("info");
  i.className = type;
  i.textContent = message;
};

<<<<<<< HEAD
var searchDelay = 200;
var _d;
function query(wait, success, key, query, enforce, target) {
  var d = new Date();
  _d = d;
  setTimeout(function() {
    if(_d != d) return;
    if(wait) setWarning(wait);

    var name = document.getElementById("name");
    var resource = document.getElementById("resource");
    var sort = document.getElementById("sort");
    var loglist = document.getElementById("loglist");
    var url = key +
      "?name=" + encodeURIComponent(name ? name.value : "") +
      "&resource=" + encodeURIComponent(resource ? resource.value : "") +
      "&sort=" + encodeURIComponent(sort ? sort.value : "") +
      "&loglist=" + encodeURIComponent(loglist ? loglist.value : "");
    request("POST", url, query,
      function(req) {
        if(_d != d) return;
        target(req.responseText);
        if(success) setInfo(success);
      },
      function(req) {
        if(_d != d) return;
        setErrorFromResponse(req);
      }
    )
  }, enforce ? 0 : searchDelay);
=======
var _running = 0;
function query(key, query, enforce, target) {
  setInfo("");
  _running++;
  setTimeout(function() {
    if(_running) setWarning("Please wait…");
  }, 500);

  var name = document.getElementById("name");
  var resource = document.getElementById("resource");
  var sort = document.getElementById("sort");
  var loglist = document.getElementById("loglist");
  var url = key +
    "?name=" + encodeURIComponent(name ? name.value : "") +
    "&resource=" + encodeURIComponent(resource ? resource.value : "") +
    "&sort=" + encodeURIComponent(sort ? sort.value : "") +
    "&loglist=" + encodeURIComponent(loglist ? loglist.value : "");
  request("POST", url, query,
    function(req) {
      _running--;
      target(req.responseText);
      setInfo("Query was successful.");
    },
    function(req) {
      _running--;
      if(req.status != 410) setErrorFromResponse(req);
    }
  )
>>>>>>> basex-8.4
};

// Jetty and Tomcat support (both return error messages differently)
function setErrorFromResponse(req) {
  var msg = req.statusText.match(/\[\w+\]/g) ? req.statusText : req.responseText;
  var s = msg.indexOf('['), e1 = msg.indexOf('\n', s), e2 = msg.indexOf('<', s);
  if(s > -1) msg = msg.substring(s, e1 > e2 ? e2 : e1 > s ? e1 : msg.length);
  var html = document.createElement('div');
  html.innerHTML = msg;
  setError(html.innerText || html.textContent);
};

var _list;
<<<<<<< HEAD
function logslist(wait, success) {
  var input = document.getElementById('loglist').value.trim();
  if(_list == input) return false;
  _list = input;
  query(wait, success, 'loglist', input, false, function(text) {
    document.getElementById("list").innerHTML = text;
  })
};

var _logs;
function logentries(wait, success) {
  var input = document.getElementById('logs').value.trim();
  if(_logs == input) return false;
  _logs = input;
  query(wait, success, 'log', input, false, function(text) {
    document.getElementById("output").innerHTML = text;
  });
};

var _input;
function queryResource(wait, success) {
  var input = document.getElementById('input').value.trim();
  if(_input == input) return false;
  _input = input;
  var target = 'query-resource';
  var enforce = false;
  query(wait, success, target, input, enforce, function(text) {
    document.getElementById("output").value = text;
  });
};

var _editor;
function editor(wait, success, enforce) {
  var mode = document.getElementById("mode").selectedIndex;
  var update = mode == 2;
  var realtime = mode == 1;
  document.getElementById("run").disabled = realtime;

  var editor = document.getElementById('editor').value;
  if(enforce || (realtime && _editor != editor)) {
    _editor = editor;
    var target = update ? 'update-query' : 'eval-query';
    query(wait, success, target, editor, enforce, function(text) {
      document.getElementById("output").value = text;
      var evt = document.createEvent("HTMLEvents");
      evt.initEvent("change",false,false);
      document.getElementById("output").dispatchEvent(evt);
    });
  }
};

=======
function logList() {
  var list = document.getElementById('loglist').value.trim();
  if(_list == list) return false;
  _list = list;
  query('loglist', list, false, function(text) {
    document.getElementById("list").innerHTML = text;
  })
};

var _logs;
function logEntries() {
  var logs = document.getElementById('logs').value.trim();
  if(_logs == logs) return false;
  _logs = logs;
  query('log', logs, false, function(text) {
    document.getElementById("output").innerHTML = text;
  });
};

var _input;
function queryResource() {
  var input = document.getElementById('input').value.trim();
  if(_input == input) return false;
  _input = input;
  query('query-resource', input, false, function(text) {
    _outputMirror.setValue(text);
  });
};

function evalQuery(reverse) {
  var mode = document.getElementById("mode").selectedIndex;
  var editor = document.getElementById('editor').value;
  var update = (mode == 1) ^ reverse;
  var target = update ? 'update-query' : 'eval-query';
  query(target, editor, true, function(text) {
    _outputMirror.setValue(text);
  });
};

>>>>>>> basex-8.4
function request(method, url, data, success, failure) {
  var req = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");
  req.onreadystatechange = function() {
    if(req.readyState == 4) {
      if(req.status == 200) {
        success(req);
      } else {
        failure(req);
      }
    }
  };
  // synchronous querying: wait for server feedback
  req.open(method, url, true);
  req.setRequestHeader("Content-Type", "text/plain");
  req.send(data);
};
<<<<<<< HEAD
=======

var _editorMirror;
var _outputMirror;
function loadCodeMirror() {
  if (CodeMirror && dispatchEvent) {
    var editorArea = document.getElementById("editor");
    if(editorArea) {
      _editorMirror = CodeMirror.fromTextArea(editorArea, {
        mode: "xquery",
        lineNumbers: true,
        extraKeys: {
          "Ctrl-Enter": function(cm) { evalQuery(); },
          "Cmd-Enter": function(cm) { evalQuery(); },
          "Shift-Ctrl-Enter": function(cm) { evalQuery(true); },
          "Shift-Cmd-Enter": function(cm) { evalQuery(true); }
        }
      });
      _editorMirror.on("change",function(cm, cmo) { cm.save(); });
      _editorMirror.display.wrapper.style.border = "solid 1px grey";
    }

    var outputArea = document.getElementById("output");
    _outputMirror = CodeMirror.fromTextArea(outputArea, {
      mode: "xml",
      readOnly: true,
    });
    _outputMirror.display.wrapper.style.border = "solid 1px grey";

    window.addEventListener("load",setDisplayHeight);
    window.addEventListener("resize",setDisplayHeight);
  }
}

function setDisplayHeight() {
  var elem = document.createElement("div");
  document.body.appendChild(elem);
  p = elem.offsetTop + 24;
  var elems = document.getElementsByClassName("CodeMirror");
  var c = elems[0].offsetHeight;
  var s = window.innerHeight;
  Array.prototype.forEach.call(elems,function(cm) {
    cm.CodeMirror.setSize("100%",Math.max(200,s-(p-c)));
  });
}
>>>>>>> basex-8.4
