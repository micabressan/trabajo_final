"use strict";
var App = App || {};
window.i18nArr = window.i18nArr || {};
App.i18n = new function() {
 var a = this;
 i18nArr = i18nArr || {};
 this.language = "en";
 this.setLanguage = function(b) {
  if (!b || b === "") {
   b = "en"
  }
  b = b.substr(b.length - 2, b.length);
  if (b === "gs") {
   b = "de"
  }
  a.language = b ? b : "en"
 };
 this.getLanguage = function() {
  return a.language
 };
 this.translationExists = function(b) {
  return !Ext.isEmpty(App.data.i18n[b])
 };
 this.i18n = function(d, b) {
  var e = "";
  if (!App.data || !App.data.i18n) {
   e = i18nArr[d];
   if (!e) {
    return d + " UNDEFINED LABEL"
   }
   return i18nArr[d][a.language]
  }
  e = App.data.i18n[d];
  if (!e) {
   return d + " UNDEFINED LABEL"
  }
  if (b instanceof Array) {
   for (var c = 0; c < b.length; c++) {
    e = e.replaceAll("{" + c + "}", b[c])
   }
  } else {
   for (var c = 1; c < arguments.length; c++) {
    e = e.replaceAll("{" + (c - 1) + "}", arguments[c])
   }
  }
  return e
 };
 this.i18n2 = function(b) {
  if (String(b).startsWith("i18n:")) {
   b = b.substring(5)
  }
  var c = "";
  if (!App.data || !App.data.i18n) {
   c = i18nArr[b + "." + a.language];
   if (!c) {
    return b
   }
   return i18nArr[b + "." + a.language]
  }
  c = App.data.i18n[b];
  return !c ? b : c
 };
 this.setLabel = function(b, d, c) {
  if (!i18nArr[b]) {
   i18nArr[b] = {}
  }
  i18nArr[b + "." + d] = c
 }
};
window.i18n = App.i18n.i18n;
window.i18n2 = App.i18n.i18n2;
window.setLanguage = App.i18n.setLanguage;
window.setLabel = App.i18n.setLabel;
window.captchaRandom = 0;
window.svc = function(b, a) {
 if (a && App.user.extUrl) {
  return App.user.extUrl + "servic/" + b
 } else {
  return "/crm/service/" + b
 }
};
window.errorMessage = function(b) {
 var a = document.getElementById("statusmsg");
 if (a) {
  a.innerHTML = "<span style='color:red'>" + i18n2(b) + "</span>"
 }
};
window.errorMsg = function(a, c) {
 var b = document.getElementById("i18n_" + a);
 if (b) {
  b.setAttribute("style", "color:red")
 }
 b = document.getElementById("input_" + a);
 if (b) {
  b.setAttribute("class", "invalid_element")
 }
 b = document.getElementById("error_" + a);
 if (b) {
  b.innerHTML = i18n2(c)
 }
};
window.infoMessage = function(b) {
 var a = document.getElementById("statusmsg");
 if (a) {
  a.innerHTML = "<span style='color:green'>" + i18n2(b) + "</span>"
 }
};
String.prototype.startsWith = function(a) {
 return (this.substring(0, a.length) == a)
};
window.request = function(c, i, a) {
 var b = svc(c) + "?id=" + window.iid + "&mid=" + window.mid + i;
 var h;
 try {
  h = new ActiveXObject("Msxml2.XMLHTTP")
 } catch (g) {
  try {
   h = new ActiveXObject("Microsoft.XMLHTTP")
  } catch (f) {
   try {
    h = new XMLHttpRequest()
   } catch (d) {
    h = false
   }
  }
 }
 h.onreadystatechange = function() {
  if (h.readyState == 4) {
   a(h)
  }
 };
 h.open("POST", b, true);
 h.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8");
 h.send(null)
};
window.getObject = function(response) {
 try {
  return eval("(" + response.responseText + ")")
 } catch (e) {
  return null
 }
};
window.getElementValue = function(b, d) {
 if (!d) {
  return null
 }
 if (typeof d == "string") {
  d = document.getElementsByName(d)[0]
 }
 var c = "";
 if (d.getAttribute && d.getAttribute("type") && (d.getAttribute("type") == "radio" || d.getAttribute("type") == "checkbox")) {
  if (b === "tac") {
   return b + "=" + d.checked
  } else {
   if (b === "properties") {
    return d.value + "=" + (d.checked ? "Y" : "N")
   } else {
    c = d.checked ? d.value : ""
   }
  }
 } else {
  if (d.tagName === "SELECT") {
   var a = d.selectedIndex;
   if (a >= 0) {
    c = encodeURIComponent(d.options[a].value)
   }
  } else {
   c = d.value
  }
 }
 if (c == "") {
  return ""
 } else {
  if (b === "properties") {
   return c
  } else {
   return b + "=" + encodeURIComponent(c)
  }
 }
};
window.submitForm = function(a) {
 var e = "";
 var d = {};
 var g = document.getElementsByTagName("*");
 var h = "";
 for (var f = 0; f < g.length; f++) {
  var c = g[f];
  if (c.tagName !== "INPUT" && c.tagName !== "SELECT") {
   continue
  }
  var b = c.getAttribute("name");
  if (!b) {
   continue
  }
  if (d[b]) {
   continue
  }
  var j = getElementValue(b, c);
  if (b === "properties") {
   if (h != "") {
    h += ","
   }
   h += j;
   continue
  }
  if (!j) {
   continue
  }
  d[b] = true;
  e += "&" + j
 }
 if (h !== "") {
  e += "&properties=" + h
 }
 e += "&cr=" + captchaRandom;
 var k = a || "color:black";
 updateLabels(function(i) {
  if (i.tagName !== "A" && i.tagName !== "BUTTON" && i.type !== "submit") {
   i.setAttribute("style", k)
  }
 });
 updateLabels(function(i) {
  i.innerHTML = ""
 }, "error_");
 request("saveIdentity", e, function(i) {
  var n = getObject(i);
  if (!n.success) {
   var m = n.errors;
   for (var l in m) {
    errorMsg(l, m[l])
   }
  } else {
   try {
    successHandler(n)
   } catch (l) {
    window.parent.location.href = n.redirect
   }
  }
 })
};
window.getFormValue = function(a, c) {
 var b = document.getElementsByName(a);
 if (b && b.length > 0 && b[0].value.length > 0) {
  return b[0].value
 } else {
  return c
 }
};
window.updateLabels = function(a, e) {
 if (!e) {
  e = "i18n_"
 }
 var d = document.getElementsByTagName("*");
 for (var b = 0; b < d.length; b++) {
  var c = d[b];
  if (c.getAttribute && c.getAttribute("id")) {
   var f = c.getAttribute("id");
   if (f.startsWith(e)) {
    a(c)
   }
  }
 }
};
window.reloadCaptcha = function() {
 var a = document.getElementById("captchaImage");
 if (a) {
  captchaRandom = String(Math.random() * 999);
  a.src = svc("cap?" + captchaRandom)
 }
};
window.fillForm = function() {
 infoMessage("");
 window.iid = getFormValue("iid", 0);
 window.mid = getFormValue("mid", 0);
 window.chk = getFormValue("chk", 0);
 window.nlid = getFormValue("nlid", 0);
 var a = getFormValue("displayLanguage", "en");
 a = a.substr(0, 2).toLowerCase();
 setLanguage(a);
 updateLabels(function(b, d) {
  d = b.getAttribute("id");
  var c = i18n2(d.substring(5, d.length));
  if (b.tagName === "INPUT") {
   b.value = c
  } else {
   b.innerHTML = c
  }
 });
 reloadCaptcha();
 if (window.iid == 0) {
  return
 }
 request("getIdentity", "&attributes=true&nlid=" + window.nlid + "&chk=" + window.chk, function(g) {
  var l = getObject(g);
  for (var b in l) {
   if (!l.hasOwnProperty(b)) {
    continue
   }
   var o = l[b];
   var d = document.getElementsByName(b);
   if (d.length === 0) {
    continue
   }
   var p = d[0];
   if (b === "salutation" && d[1]) {
    if (o === "mr") {
     d[0].checked = true
    } else {
     d[1].checked = true
    }
   } else {
    if (b === "properties" && p) {
     var c = l[b];
     for (var m = 0; m < p.length; m++) {
      var n = false;
      var h = 0;
      while (c[h]) {
       if (p[m].value == c[h].key + "=" + c[h].text) {
        p.selectedIndex = m;
        n = true;
        break
       }
       h++
      }
      if (n) {
       break
      }
     }
    } else {
     if (d.tagName === "SELECT") {
      for (var e = 0; e < p.length; e++) {
       if (p[e].value == o) {
        p.selectedIndex = e
       }
      }
     } else {
      p.value = o
     }
    }
   }
  }
 })
};

function resizeCrossDomainIframe(b) {
 CrossDomainIframeLoad(b)
}

function CrossDomainIframeLoad(d) {
 browserwarning();
 var c = document.getElementById("ems-webform");
 addEvent("message", function(a) {
  if (a.origin !== d) {
   return
  }
  if (a.data === "scrollTop") {
   scrollTop()
  } else {
   if (!isNaN(a.data)) {
    var b = parseInt(a.data);
    b += 15;
    c.height = b + "px"
   }
  }
 });
 setTimeout("fixBUORGPosition()", 100)
}

function fixBUORGPosition() {
 if (document.getElementById("buorg")) {
  document.getElementById("buorg").style.top = "0";
  document.getElementById("buorg").style.position = "fixed"
 }
}

function addEvent(a, b) {
 if (window.addEventListener) {
  window.addEventListener(a, b, false)
 } else {
  if (window.attachEvent) {
   if (document.URL.indexOf("http://www.bregenzerwald.at/") !== -1) {
    var f = document.getElementById("ems-webform");
    if (navigator.userAgent.indexOf("MSIE 7.0") !== -1) {
     f.height = 1330 + "px"
    } else {
     f.height = 1030 + "px"
    }
   }
  }
 }
}

function scrollTop() {
 window.scrollBy(0, -25);
 if ((document.documentElement.scrollTop || document.body.scrollTop) !== 0) {
  scrolldelay = setTimeout("scrollTop()", 10)
 }
}

function browserwarning() {
 try {
  if ($buoop.ol) {
   $buoop.ol()
  }
 } catch (b) {}
 var b = document.createElement("script");
 b.setAttribute("type", "text/javascript");
 b.setAttribute("src", "http://browser-update.org/update.js");
 document.body.appendChild(b)
};
var App = App || new Object();
App.ems = App.ems || new Object();
App.ems.loadWebform = App.ems.loadWebform || new Object();
App.ems.head = document.head || document.getElementsByTagName("head")[0];
App.ems.s1 = document.createElement("script");
App.ems.s1.src = "https://code.jquery.com/jquery-1.10.2.min.js";
App.ems.s1.integrity = "sha256-C6CB9UYIS9UJeqinPHWTHVqh/E1uhG5Twh+Y5qFQmYg=";
App.ems.s1.crossOrigin = "anonymous";
App.ems.s1.onload = function() {
 App.ems.s2 = document.createElement("script");
 App.ems.s2.src = "https://code.jquery.com/ui/1.10.2/jquery-ui.min.js";
 App.ems.s2.integrity = "sha256-FgiaQnQazF/QCrF9qSvpRY6PACn9ZF8VnlgqfqD1LsE=";
 App.ems.s2.crossOrigin = "anonymous";
 App.ems.s2.onload = function() {
  var a = jQuery.noConflict(true);
  App.ems.loadWebform.isEmpty = function(b) {
   return (b === null || b === undefined || b === "")
  };
  App.ems.loadWebform.initOverlay = function() {
   var f = a("#ems-openModal");
   if (f.length > 0) {
    var e = f[0];
    var d = a(e).attr("data-wf");
    var h = a(e).attr("data-src");
    var b;
    if (d != "") {
     var g = function() {
      a("#" + d + ">#ems-wf-scroll>#ems-wf-buttonContainer>#ems-wf-closeOverlay").on("click", function() {
       a("#" + d + ">#ems-wf-scroll").css("height", "0%");
       a("#" + d + ">#ems-wf-scroll").css("overflow-y", "hidden");
       setTimeout(function() {
        a("#" + d + ">#ems-wf-scroll").css("box-shadow", "0 0px 25px 10px rgba(0,0,0,0)");
        a("#" + d).css("background-color", "rgba(255,255,255,0)");
        a("#" + d + ">#ems-wf-scroll").css("background-color", "rgba(255,255,255,0)")
       }, 300);
       setTimeout(function() {
        a("#" + d).hide()
       }, 800)
      })
     };
     var c = function() {
      if (a("#" + d).children().length == 0 && h != "") {
       var i = document.createElement("script");
       i.setAttribute("type", "text/javascript");
       i.src = h;
       i.async = false;
       document.getElementsByTagName("head")[0].appendChild(i)
      }
      b = setInterval(function() {
       if (a("#" + d).children().length > 0) {
        App.webformObject.gotoPage(0, "none");
        var j = a(e).find("input");
        a.each(j, function(m, l) {
         var k = a("#" + d).find("[name='" + l.name + "']");
         if (f.length > 0 && l.value !== "") {
          k[0].value = l.value;
          App.webformObject.storeContent();
          App.webformObject.validateContent(k[0])
         }
        });
        a("#" + d).show();
        a("#" + d).css("background-color", "rgba(0,0,0,0.7)");
        setTimeout(function() {
         var k = App.webform.settings.overlayHeight || "70%";
         a("#" + d + ">#ems-wf-scroll").css("background-color", "rgba(255,255,255,1)");
         a("#" + d + ">#ems-wf-scroll").css("box-shadow", "0 0px 25px 10px #000000");
         a("#" + d + ">#ems-wf-scroll").css("height", k)
        }, 300);
        setTimeout(function() {
         a("#" + d + ">#ems-wf-scroll").css("overflow-y", "auto")
        }, 800);
        g();
        clearInterval(b)
       }
      }, 100)
     };
     a(e).find(":button").on("click", function() {
      c()
     });
     a(e).find("input").bind("enterKey", function(i) {
      c()
     });
     a(e).find("input").keyup(function(i) {
      if (i.keyCode == 13) {
       a(this).trigger("enterKey")
      }
     })
    }
   }
  };
  window.onload = function() {
   App.ems.loadWebform.initOverlay()
  }
 };
 App.ems.head.appendChild(App.ems.s2)
};
App.ems.head.appendChild(App.ems.s1);